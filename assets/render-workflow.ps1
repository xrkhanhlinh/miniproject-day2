# Rebuild the deterministic diagram without an image service or extra packages.
Add-Type -AssemblyName System.Drawing
$outputPath = Join-Path (Split-Path $PSScriptRoot -Parent) '04-workflow-diagram.png'
$bitmap = New-Object System.Drawing.Bitmap 1900, 1160
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$graphics.Clear([System.Drawing.ColorTranslator]::FromHtml('#F4F7FC'))
$titleFont = New-Object System.Drawing.Font('Arial', 35, [System.Drawing.FontStyle]::Bold)
$headingFont = New-Object System.Drawing.Font('Arial', 24, [System.Drawing.FontStyle]::Bold)
$bodyFont = New-Object System.Drawing.Font('Arial', 21)
$smallFont = New-Object System.Drawing.Font('Arial', 18)

function Draw-Text($text, $font, $color, $x, $y, $width, $height) {
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($color))
    $rect = New-Object System.Drawing.RectangleF($x, $y, $width, $height)
    $graphics.DrawString($text, $font, $brush, $rect)
    $brush.Dispose()
}

function Draw-Box($x, $number, $title, $actor, $minutes, $detail, $bottleneck) {
    $fill = if ($bottleneck) { '#FFF0EF' } else { '#FFFFFF' }
    $line = if ($bottleneck) { '#C53B3B' } else { '#9BAEC9' }
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($fill))
    $pen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml($line)), 3
    $graphics.FillRectangle($brush, $x, 310, 390, 340)
    $graphics.DrawRectangle($pen, $x, 310, 390, 340)
    Draw-Text "BƯỚC $number" $smallFont $line ($x + 24) 334 340 40
    Draw-Text $title $headingFont '#172F50' ($x + 24) 380 340 85
    Draw-Text $actor $bodyFont '#405572' ($x + 24) 478 340 40
    Draw-Text "$minutes phút / yêu cầu" $headingFont $line ($x + 24) 526 340 45
    Draw-Text $detail $smallFont '#405572' ($x + 24) 582 340 60
    $brush.Dispose()
    $pen.Dispose()
}

Draw-Text 'VINHOMES | Quy trình tiếp nhận phản ánh' $titleFont '#172F50' 70 55 1760 65
Draw-Text 'CURRENT STATE • Mô hình giả định phục vụ Lab 02 — chưa xác minh vận hành thực tế' $bodyFont '#526780' 70 138 1760 55
Draw-Text 'CƯ DÂN' $headingFont '#315E9E' 94 237 360 45
Draw-Text 'NHÂN VIÊN CHĂM SÓC CƯ DÂN' $headingFont '#315E9E' 544 237 1230 45

Draw-Box 70 1 'Gửi phản ánh' 'Cư dân' 2 'Nội dung qua kênh tiếp nhận' $false
Draw-Box 520 2 'Đọc và làm rõ' 'Nhân viên CSKH' 3 'Nội dung dài, thiếu thông tin' $true
Draw-Box 970 3 'Phân loại' 'Nhân viên CSKH' 2 'Nhóm vấn đề, đơn vị phụ trách' $true
Draw-Box 1420 4 'Ghi nhận và chuyển' 'Nhân viên CSKH' 3 'Đầu ra: yêu cầu được bàn giao' $false

$arrowPen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml('#315E9E')), 5
$arrowPen.CustomEndCap = New-Object System.Drawing.Drawing2D.AdjustableArrowCap(5, 6)
$graphics.DrawLine($arrowPen, 466, 470, 510, 470)
$graphics.DrawLine($arrowPen, 916, 470, 960, 470)
$graphics.DrawLine($arrowPen, 1366, 470, 1410, 470)
Draw-Text 'Handoff 1: Cư dân → CSKH' $smallFont '#315E9E' 70 680 720 40
Draw-Text 'Handoff 2: CSKH → Kỹ thuật / vệ sinh / an ninh' $smallFont '#315E9E' 970 680 860 65

Draw-Text '10 phút / yêu cầu' $titleFont '#172F50' 70 785 830 65
Draw-Text '2 + 3 + 2 + 3 phút; gồm cả bước cư dân gửi yêu cầu.' $bodyFont '#526780' 70 863 830 95
Draw-Text '5 phút tại điểm nghẽn' $titleFont '#BA3434' 970 785 860 65
Draw-Text 'Bước 2–3: đọc hiểu và phân loại. Mục tiêu < 1 phút, gồm nhân viên duyệt đề xuất AI.' $bodyFont '#526780' 970 863 850 110
Draw-Text 'Chú giải: ô viền đỏ = bottleneck • mũi tên = trình tự • Handoff = chuyển giao thông tin' $smallFont '#526780' 70 1015 1760 45
Draw-Text 'Mọi thời gian trong sơ đồ là giả định thiết kế, không phải số liệu được Vinhomes công bố.' $smallFont '#526780' 70 1070 1760 45
$bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
$arrowPen.Dispose()
$titleFont.Dispose()
$headingFont.Dispose()
$bodyFont.Dispose()
$smallFont.Dispose()
$graphics.Dispose()
$bitmap.Dispose()
Write-Output $outputPath
