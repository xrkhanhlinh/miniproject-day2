
# 🔍 Phase 1 — SCAN (Cá nhân, 20 min)

> **Phạm vi bằng chứng:** Các bài toán dưới đây là giả thuyết phục vụ Lab 02 theo bối cảnh đề bài, chưa phải kết luận khảo sát tại doanh nghiệp. Thời gian, sản lượng và lợi ích là giả định thiết kế; cần xác nhận bằng log và phỏng vấn người vận hành. Bài được chọn để phân tích sâu: **Vinhomes — trợ lý phân loại phản ánh cư dân, luôn có nhân viên duyệt**.

Hãy sử dụng **4 Lenses** dưới đây để quét qua hoạt động vận hành của các công ty thành viên Vingroup. Ghi lại **ít nhất 5 bài toán/bottleneck** thực tế.

### 4 Lenses tìm bài toán AI cho Vingroup:
1. **Lặp lại (Repetitive):** Tác vụ lặp đi lặp lại nhiều lần hằng ngày. (Ví dụ: So khớp hóa đơn sạc điện tại VinFast, route lại chuyến taxi tại Xanh SM).
2. **Tốn thời gian (Time-consuming):** Tác vụ ngốn thời gian xử lý thủ công của nhân viên. (Ví dụ: Soạn thảo phản hồi đánh giá 1-star của cư dân Vinhomes).
3. **AI có thể tốt hơn (AI-upgrade):** Dịch vụ khách hàng hiện tại còn chậm hoặc phản hồi rập khuôn. (Ví dụ: Chatbot CSKH Vinpearl hỗ trợ đặt vé vui chơi).
4. **Pain từ người khác (Stakeholder Pain):** Bottleneck khiến khách hàng hoặc nhân viên thực địa phàn nàn. (Ví dụ: Tài xế Xanh SM phàn nàn về việc hệ thống gợi ý điểm đón khách không chính xác).

> [!TIP]
> **🤖 AI Prompts — Partner brainstorm:**
> Hãy sử dụng prompt sau để brainstorm các bài toán thực tế nếu bạn chưa có ý tưởng:
> *"Tôi là AI Engineer tại Vin Smart Future (Vingroup). Tôi đang tìm kiếm các pain point vận hành cụ thể có thể tối ưu bằng AI cho mảng [Chọn một: VinFast / Xanh SM / Vinhomes / Vinmec]. Hãy gợi ý cho tôi 5 quy trình nghiệp vụ thủ công, tốn nhiều thời gian và gây rò rỉ hiệu suất kèm con số thống kê ước tính về tổn thất."*

### 📝 List bài toán của tôi:
| # | Subsidiary (VinFast/Xanh SM...) | Lens | Mô tả ngắn bài toán |
|---|----------------------------------|------|---------------------|
| 1 | VinFast | Time-consuming | Nhân viên tiếp nhận bảo dưỡng phải đọc mô tả lỗi xe của khách hàng, phân loại sự cố và chuyển đến bộ phận kỹ thuật phù hợp. |
| 2 | Xanh SM | Stakeholder Pain | Điểm đón khách được hệ thống gợi ý có thể chưa chính xác tại chung cư nhiều cổng hoặc khu vực hạn chế dừng đỗ, khiến tài xế phải liên hệ khách hàng nhiều lần. |
| 3 | Vinhomes | Repetitive | Nhân viên chăm sóc cư dân phải đọc, phân loại và chuyển các phản ánh về điện, nước, vệ sinh, an ninh đến đúng bộ phận phụ trách. |
| 4 | Vinmec | Time-consuming | Nhân viên hành chính phải kiểm tra, đối chiếu và nhập thông tin từ nhiều loại giấy tờ trong quá trình tiếp nhận hồ sơ khám bệnh. |
| 5 | Vinpearl | AI-upgrade | Nhân viên chăm sóc khách hàng phải xử lý nhiều câu hỏi về đặt phòng, chính sách và dịch vụ bằng các ngôn ngữ khác nhau, cần tra cứu thông tin trước khi trả lời. |

---

# 🃏 Phase 2 — QUICK-ASSESS (Cá nhân, 30 min)

Chọn **top 3 bài toán** từ danh sách trên và hoàn thiện **3 Quick Problem Cards** dưới đây (10 phút/card).

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #1                                       │
│                                                             │
│ Bài toán (1 câu): Tự động phân loại và điều phối phản ánh    │
│ cư dân đến đúng bộ phận xử lý.                               │
│                                                             │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [x] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________   │
│                                                             │
│ Ai đang đau (Actor)? Nhân viên CSKH và cư dân.               │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Tiếp nhận phản ánh                                     │
│   ──> 2. Đọc nội dung                                       │
│   ──> 3. Phân loại vấn đề                                   │
│   ──> 4. Chuyển bộ phận xử lý                               │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2-3                    │
│ (⏱ 5 phút/lượt, giả định).                                  │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-3: LLM         │
│ tóm tắt phản ánh, phân loại và đề xuất bộ phận xử lý.       │
│                                                             │
│ Đo thành công bằng gì (Metric có số)? Giảm thời gian        │
│ phân loại từ 5 phút xuống dưới 1 phút/yêu cầu.              │
│ (Mục tiêu giả định, cần kiểm chứng khi thử nghiệm.)          │
│                                                             │
│ Quick Architecture: [ ] No AI  [x] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #2                                       │
│                                                             │
│ Bài toán (1 câu): Hỗ trợ phân loại mô tả lỗi xe để          │
│ rút ngắn thời gian tiếp nhận bảo dưỡng.                      │
│                                                             │
│ Công ty thành viên: [x] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [ ] Khác (Ghi rõ)________   │
│                                                             │
│ Ai đang đau (Actor)? Cố vấn dịch vụ, kỹ thuật viên          │
│ và chủ xe VinFast.                                          │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Khách hàng mô tả sự cố                                 │
│   ──> 2. Nhân viên đọc và làm rõ thông tin                   │
│   ──> 3. Phân loại nhóm lỗi                                 │
│   ──> 4. Chuyển yêu cầu đến bộ phận kỹ thuật                 │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 2-3                    │
│ (⏱ 6 phút/lượt, giả định).                                  │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 2-3: LLM         │
│ trích xuất triệu chứng, tóm tắt và đề xuất nhóm lỗi.        │
│ Nhân viên kiểm tra trước khi chuyển yêu cầu.                 │
│                                                             │
│ Đo thành công bằng gì (Metric có số)? Giảm thời gian        │
│ phân loại từ 6 phút xuống dưới 2 phút/yêu cầu.              │
│ (Mục tiêu giả định, cần kiểm chứng khi thử nghiệm.)          │
│                                                             │
│ Quick Architecture: [ ] No AI  [x] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

```text
┌─────────────────────────────────────────────────────────────┐
│ QUICK PROBLEM CARD #3                                       │
│                                                             │
│ Bài toán (1 câu): Hỗ trợ tự động trả lời câu hỏi của         │
│ khách hàng về dịch vụ Vinpearl bằng nhiều ngôn ngữ.          │
│                                                             │
│ Công ty thành viên: [ ] VinFast  [ ] Xanh SM  [ ] Vinhomes  │
│                     [ ] Vinmec   [x] Khác (Ghi rõ) Vinpearl │
│                                                             │
│ Ai đang đau (Actor)? Nhân viên CSKH và khách lưu trú.        │
│                                                             │
│ Workflow thủ công hiện tại (3-5 bước):                      │
│   1. Khách hàng gửi câu hỏi                                 │
│   ──> 2. Nhân viên đọc và xác định yêu cầu                   │
│   ──> 3. Tra cứu chính sách, thông tin dịch vụ              │
│   ──> 4. Soạn và gửi phản hồi                               │
│                                                             │
│ Bước nào tốn thời gian/lỗi nhất? Bước 3-4                    │
│ (⏱ 7 phút/lượt, giả định).                                  │
│                                                             │
│ AI có thể nhảy vào hỗ trợ ở bước nào? Bước 3-4: LLM         │
│ kết hợp RAG tra cứu tài liệu dịch vụ, tạo câu trả lời       │
│ theo ngôn ngữ khách hàng và chuyển người thật khi cần.      │
│                                                             │
│ Đo thành công bằng gì (Metric có số)? Giảm thời gian        │
│ soạn phản hồi từ 7 phút xuống dưới 2 phút/yêu cầu.          │
│ (Mục tiêu giả định, cần kiểm chứng khi thử nghiệm.)          │
│                                                             │
│ Quick Architecture: [ ] No AI  [ ] Rule  [x] LLM  [ ] Agent │
└─────────────────────────────────────────────────────────────┘
```

> [!TIP]
> **🤖 AI Prompts — Stress-Test thẻ bài toán:**
> Hãy dán nội dung thẻ bài toán của bạn vào LLM để nhận phản biện:
> *"Đây là một thẻ bài toán vận hành tôi đề xuất cho Vin Smart Future: [Dán nội dung]. Hãy đóng vai trò là một CFO và Trưởng phòng Vận hành cực kỳ khắt khe, chỉ ra cho tôi 3 điểm yếu về logic, metric, và giải thích vì sao rule-based code thông thường có thể giải quyết bài toán này tốt hơn là dùng AI."*

## 2.1. So sánh và lựa chọn bài toán

Chấm trên thang 1–5: điểm cao nghĩa là tác động kỳ vọng lớn, dễ chuẩn bị dữ liệu, dễ kiểm soát rủi ro hoặc dễ làm prototype. Đây là đánh giá thiết kế, chưa có stakeholder xác nhận. Điểm tổng = tác động × 35% + dữ liệu × 25% + kiểm soát rủi ro × 25% + prototype × 15%.

| Bài toán | Tác động | Dữ liệu | Kiểm soát rủi ro | Prototype | Điểm tổng |
|---|---:|---:|---:|---:|---:|
| Vinhomes: phân loại phản ánh | 4 | 3 | 4 | 5 | **3,90** |
| VinFast: phân loại mô tả lỗi xe | 4 | 2 | 2 | 3 | 2,85 |
| Vinpearl: nháp trả lời đa ngôn ngữ | 4 | 3 | 3 | 4 | 3,50 |

**Chọn Vinhomes:** Đầu ra có thể giới hạn vào danh mục nhỏ; không cần điều khiển thiết bị, chẩn đoán xe hoặc truy cập tồn kho thời gian thực. Có thể xây tập phản ánh giả lập để kiểm tra code và dùng HITL cho mọi đề xuất. Điểm dữ liệu 3 chỉ phản ánh khả năng tạo mẫu; chưa đồng nghĩa có quyền truy cập log thật. VinFast cần đánh giá an toàn chuyên môn; Vinpearl cần tài liệu chính sách có phiên bản và kiểm tra thông tin giá/phòng trước khi phản hồi.

## 2.2. Phản biện từ góc nhìn chi phí và vận hành

| Điểm yếu | Phản biện | Điều chỉnh trong scope |
|---|---|---|
| Chưa có baseline | Chưa thể khẳng định doanh nghiệp mất 5 phút mỗi lượt hoặc có 100 lượt/ngày. | Gắn nhãn giả định; thu thập timestamp đọc, phân loại, duyệt và chuyển trước khi tính ROI. |
| Rule có thể đủ tốt | Nếu phản ánh đã có biểu mẫu chọn loại rõ ràng, LLM có thể không tạo thêm giá trị. | So sánh baseline từ khóa/biểu mẫu với LLM trên cùng tập test; chỉ tiếp tục nếu LLM cải thiện chất lượng hoặc thời gian. |
| Duyệt có thể ăn hết phần tiết kiệm | Nhân viên phải đọc lại toàn bộ khi tóm tắt sai; còn có chi phí tích hợp và API. | Đo thời gian cả bước review, tỷ lệ sửa nhãn và số lần chuyển lại; không dùng riêng tốc độ sinh JSON làm ROI. |

Phạm vi MVP: phản ánh văn bản tiếng Việt, 6 nhóm `electric / water / cleaning / security / multiple / unknown`, chỉ hiển thị đề xuất nội bộ. Chưa xử lý ảnh, ghi âm, tự gửi tin, tự đóng yêu cầu hay điều phối sự cố thật.

Chi tiết: [báo cáo phân tích sâu](02-deep-dive-report.md), [prototype Vinhomes](starter-code/resident_prototype.py).

---
