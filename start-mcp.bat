@echo off
REM Khởi động MCP OpenMemory Server - Windows Batch Wrapper
setlocal enabledelayedexpansion

echo.
echo 🚀 Khởi động MCP OpenMemory Server...
echo.

cd /d "%~dp0"

REM Kiểm tra Node.js
where node >nul 2>nul
if %ERRORLEVEL% NEQ 0 (
    echo ❌ Node.js không được cài đặt. Vui lòng cài đặt từ https://nodejs.org/
    pause
    exit /b 1
)

REM Kiểm tra node_modules
if not exist "node_modules" (
    echo 📦 Cài đặt dependencies...
    call npm install
    if %ERRORLEVEL% NEQ 0 (
        echo ❌ Lỗi cài đặt dependencies
        pause
        exit /b 1
    )
)

echo ✅ Khởi động máy chủ...
echo Server sẽ lắng nghe trên stdio (để sử dụng với Claude Desktop)
echo.

node server.js

pause
