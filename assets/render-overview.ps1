# Render a project illustration using only Windows System.Drawing.
Add-Type -AssemblyName System.Drawing
$outputPath = Join-Path $PSScriptRoot 'project-overview.png'
$bitmap = New-Object System.Drawing.Bitmap 1800, 880
$graphics = [System.Drawing.Graphics]::FromImage($bitmap)
$graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::AntiAlias
$graphics.TextRenderingHint = [System.Drawing.Text.TextRenderingHint]::AntiAliasGridFit
$graphics.Clear([System.Drawing.ColorTranslator]::FromHtml('#10243D'))
$titleFont = New-Object System.Drawing.Font('Arial', 43, [System.Drawing.FontStyle]::Bold)
$headingFont = New-Object System.Drawing.Font('Arial', 26, [System.Drawing.FontStyle]::Bold)
$bodyFont = New-Object System.Drawing.Font('Arial', 22)
$labelFont = New-Object System.Drawing.Font('Arial', 18, [System.Drawing.FontStyle]::Bold)

function Write-Label($text, $font, $color, $x, $y, $width, $height) {
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($color))
    $rect = New-Object System.Drawing.RectangleF($x, $y, $width, $height)
    $graphics.DrawString($text, $font, $brush, $rect)
    $brush.Dispose()
}

function Fill-Panel($color, $x, $y, $width, $height) {
    $brush = New-Object System.Drawing.SolidBrush([System.Drawing.ColorTranslator]::FromHtml($color))
    $graphics.FillRectangle($brush, $x, $y, $width, $height)
    $brush.Dispose()
}

Write-Label 'LAB 02  /  AI PRODUCT SCOPING' $labelFont '#7BDAC0' 80 55 1630 45
Write-Label 'Từ phản ánh đến đề xuất xử lý' $titleFont '#FFFFFF' 80 120 1640 85
Write-Label 'Bản mẫu trợ lý chăm sóc cư dân • Bối cảnh Vinhomes • Dữ liệu giả lập' $bodyFont '#B8C9DD' 84 225 1630 55

Fill-Panel '#FFFFFF' 80 345 485 290
Fill-Panel '#DFE9FF' 655 345 485 290
Fill-Panel '#DDF5EB' 1230 345 485 290

Write-Label '01 / PHẢN ÁNH' $labelFont '#506780' 110 375 425 40
Write-Label 'Cư dân mô tả vấn đề' $headingFont '#172F50' 110 430 425 85
Write-Label '“Vòi nước khu sinh hoạt chung bị rò, nhờ kiểm tra.”' $bodyFont '#405572' 110 525 425 100

Write-Label '02 / ĐỀ XUẤT AI' $labelFont '#4969CC' 685 375 425 40
Write-Label 'Tóm tắt và phân loại' $headingFont '#172F50' 685 430 425 85
Write-Label 'Nhóm: water / technical' $bodyFont '#344C8A' 685 525 425 48
Write-Label 'Trạng thái: chỉ bản nháp' $bodyFont '#344C8A' 685 575 425 48

Write-Label '03 / NGƯỜI DUYỆT' $labelFont '#267B5F' 1260 375 425 40
Write-Label 'Nhân viên quyết định' $headingFont '#173E31' 1260 430 425 85
Write-Label 'Đọc bản gốc, sửa đề xuất và phê duyệt trước xử lý.' $bodyFont '#315F50' 1260 525 425 100

$pen = New-Object System.Drawing.Pen([System.Drawing.ColorTranslator]::FromHtml('#7BDAC0')), 5
$pen.CustomEndCap = New-Object System.Drawing.Drawing2D.AdjustableArrowCap(5, 6)
$graphics.DrawLine($pen, 580, 490, 635, 490)
$graphics.DrawLine($pen, 1155, 490, 1210, 490)
Fill-Panel '#1B3855' 80 700 1635 100
Write-Label 'LLM + RULE' $labelFont '#FFFFFF' 110 733 420 40
Write-Label 'MỌI ĐỀ XUẤT CẦN DUYỆT' $labelFont '#7BDAC0' 570 733 620 40
Write-Label 'LỖI → THỦ CÔNG' $labelFont '#FFFFFF' 1270 733 420 40

$bitmap.Save($outputPath, [System.Drawing.Imaging.ImageFormat]::Png)
$pen.Dispose()
$titleFont.Dispose()
$headingFont.Dispose()
$bodyFont.Dispose()
$labelFont.Dispose()
$graphics.Dispose()
$bitmap.Dispose()
Write-Output $outputPath
