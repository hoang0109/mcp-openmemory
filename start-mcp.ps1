# Khởi động MCP OpenMemory Server
# Script này khởi động máy chủ MCP để quản lý bộ nhớ dài hạn

param(
    [switch]$NoExit = $false
)

Write-Host "🚀 Khởi động MCP OpenMemory Server..." -ForegroundColor Cyan

$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
Set-Location $scriptPath

# Kiểm tra Node.js
if (-not (Get-Command "node" -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Node.js không được cài đặt. Vui lòng cài đặt Node.js từ https://nodejs.org/" -ForegroundColor Red
    exit 1
}

# Kiểm tra npm modules
if (-not (Test-Path "node_modules")) {
    Write-Host "📦 Cài đặt dependencies..." -ForegroundColor Yellow
    npm install
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Lỗi cài đặt dependencies" -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Khởi động máy chủ..." -ForegroundColor Green
Write-Host "Server sẽ lắng nghe trên stdio (để sử dụng với Claude Desktop)" -ForegroundColor Cyan

node server.js

if ($NoExit) {
    Read-Host "Nhấn Enter để thoát"
}
