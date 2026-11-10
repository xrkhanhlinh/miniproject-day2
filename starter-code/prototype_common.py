"""Explicit test harness: offline fixtures are never evidence about a model."""
import argparse
import json
import os
from datetime import datetime, timezone
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]


def api_key():
    from dotenv import load_dotenv
    load_dotenv(ROOT / ".env", override=False)
    key = os.getenv("GEMINI_API_KEY") or os.getenv("GOOGLE_API_KEY")
    if not key:
        raise RuntimeError("Missing API key")
    return key


def generate(client, model, system_prompt, schema, content):
    from google.genai import types
    response = client.models.generate_content(
        model=model, contents=json.dumps(content, ensure_ascii=False),
        config=types.GenerateContentConfig(
            system_instruction=system_prompt, response_mime_type="application/json",
            response_json_schema=schema, temperature=0, max_output_tokens=1200,
            thinking_config=types.ThinkingConfig(thinking_budget=0),
        ),
    )
    if not response.text:
        raise ValueError("Empty model output")
    return response.text


def parse_object(raw, required):
    result = json.loads(raw)
    if not isinstance(result, dict) or set(result) != set(required):
        raise ValueError("Unexpected JSON fields")
    return result


def run_suite(title, model, cases, evaluate, protect, check):
    parser = argparse.ArgumentParser(description=title)
    mode = parser.add_mutually_exclusive_group()
    mode.add_argument("--live", action="store_true", help="Call Gemini with local credentials")
    mode.add_argument("--offline", action="store_true", help="Use synthetic fixtures (default)")
    parser.add_argument("--output", type=Path, help="Save synthetic test evidence as JSON")
    args = parser.parse_args()
    mode_name = "live" if args.live else "offline_fixture"
    print(f"{title} | mode={mode_name} | model={model}")
    if not args.live:
        print("OFFLINE: fixed responses; no Gemini call, no model-quality claim.")
    report = {"title": title, "mode": mode_name, "model": model if args.live else None,
              "timestamp_utc": datetime.now(timezone.utc).isoformat(),
              "synthetic_inputs_only": True, "cases": []}
    success = True
    for case in cases:
        try:
            raw = evaluate(case["input"], case.get("context")) if args.live else json.dumps(case["fixture"], ensure_ascii=False)
        except Exception as exc:
            # Do not print SDK error strings: they can contain request details.
            code = getattr(exc, "code", None)
            code = code if isinstance(code, (int, str)) and str(code).isdigit() else None
            fallback, issues = protect("", case.get("context"), case["input"])
            report["cases"].append({"name": case["name"], "input": case["input"], "context": case.get("context"),
                                    "status": "api_error", "error_type": type(exc).__name__, "http_code": code,
                                    "raw_output": None, "final_output": fallback, "raw_boundary_issues": issues})
            print(f"ERROR: {case['name']} ({type(exc).__name__}, code={code}). No model result verified.")
            print("[DRAFT_ONLY] fallback: " + json.dumps(fallback, ensure_ascii=False))
            success = False
            break
        final, issues = protect(raw, case.get("context"), case["input"])
        ok = check(final, case)
        try:
            changed = json.loads(raw) != final
        except (ValueError, TypeError):
            changed = True
        report["cases"].append({"name": case["name"], "input": case["input"], "context": case.get("context"),
                                "expected_violation": case["expected_violation"], "raw_output": raw,
                                "raw_boundary_issues": issues, "guardrail_intervened": changed,
                                "final_output": final, "status": "passed" if ok else "failed"})
        print(f"{'Passed' if ok else 'Failed'}: {case['name']} | guardrail_intervened={changed}")
        print("[DRAFT_ONLY] " + json.dumps(final, ensure_ascii=False))
        success = success and ok
    report["success"] = success and len(report["cases"]) == len(cases)
    report["completed_cases"] = len([c for c in report["cases"] if c["status"] != "api_error"])
    report["total_cases"] = len(cases)
    if args.output:
        args.output.parent.mkdir(parents=True, exist_ok=True)
        args.output.write_text(json.dumps(report, ensure_ascii=False, indent=2) + "\n", encoding="utf-8")
        print(f"Evidence saved: {args.output}")
    return 0 if report["success"] else 1
