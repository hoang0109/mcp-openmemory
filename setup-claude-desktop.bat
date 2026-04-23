@echo off
REM Cấu hình Claude Desktop để sử dụng MCP OpenMemory Server
REM Script này tạo hoặc cập nhật cấu hình MCP trong Claude Desktop

setlocal enabledelayedexpansion

echo.
echo ⚙️  Cấu hình Claude Desktop для MCP OpenMemory Server
echo.

REM Kiểm tra xem Claude Desktop có được cài đặt không
set CLAUDE_CONFIG=%APPDATA%\Claude\claude_desktop_config.json

REM Lấy đường dẫn tuyệt đối đến server.js
for /f "delims=" %%A in ('cd /d "%~dp0" && cd') do set SERVER_PATH=%%A\server.js

REM Thay thế backslash bằng forward slash cho JSON
set SERVER_PATH=%SERVER_PATH:\=/%

echo 📄 Tất vị Claude Desktop: %CLAUDE_CONFIG%
echo 🔧 MCP Server: %SERVER_PATH%

REM Kiểm tra xem thư mục %APPDATA%\Claude có tồn tại không
if not exist "%APPDATA%\Claude" (
    echo 📁 Tạo thư mục Claude...
    mkdir "%APPDATA%\Claude"
)

REM Tạo hoặc cập nhật cấu hình
echo Cập nhật cấu hình Claude Desktop...

REM Sử dụng PowerShell để tạo JSON có cấu trúc đúng
powershell -Command ^
    "$config = @{mcpServers=@{}};" ^
    "if (Test-Path '%CLAUDE_CONFIG%') { $config = Get-Content '%CLAUDE_CONFIG%' | ConvertFrom-Json; }" ^
    "$config.mcpServers.openmemory = @{command='node'; args=@('%SERVER_PATH%'); disabled=$false};" ^
    "$config | ConvertTo-Json -Depth 10 | Out-File '%CLAUDE_CONFIG%' -Encoding UTF8;" ^
    "Write-Host '✅ Cấu hình đã được cập nhật'"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ✅ Cấu hình thành công!
    echo.
    echo 📋 Các bước tiếp theo:
    echo 1. Đóng Claude Desktop đang chạy (nếu có)
    echo 2. Mở lại Claude Desktop
    echo 3. MCP OpenMemory Server sẽ tự động khởi động
    echo.
    echo 💡 Để xem bộ nhớ hỏi Claude:
    echo "Cho tôi biết những bộ nhớ bạn lưu trữ về PhanMemCaNhan"
    echo.
) else (
    echo ❌ Có lỗi khi cấu hình. Vui lòng kiểm tra quyền truy cập vào %APPDATA%\Claude
)

pause
