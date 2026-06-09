@echo off
title Slang Lens 安装
chcp 65001 >nul
echo.
echo   ╔══════════════════════════════╗
echo   ║   Slang Lens - 英语俚语翻译  ║
echo   ╚══════════════════════════════╝
echo.
echo   正在安装...
echo.

:: Set paths
set "INSTALL_DIR=%LOCALAPPDATA%\Slang Lens"
set "SOURCE=%~dp0Slang Lens.html"

:: Create install directory
if not exist "%INSTALL_DIR%" mkdir "%INSTALL_DIR%"

:: Copy the HTML file
copy /Y "%SOURCE%" "%INSTALL_DIR%\Slang Lens.html" >nul 2>&1
if %ERRORLEVEL% NEQ 0 (
    echo   [FAIL] 无法复制文件
    pause
    exit /b 1
)
echo   [OK] 文件已复制

:: Create desktop shortcut using PowerShell
powershell -Command ^
"$WshShell = New-Object -ComObject WScript.Shell; ^
$Shortcut = $WshShell.CreateShortcut([Environment]::GetFolderPath('Desktop') + '\Slang Lens.lnk'); ^
$Shortcut.TargetPath = 'C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe'; ^
$Shortcut.Arguments = '--app=\"file:///' + $env:LOCALAPPDATA.replace('\','/') + '/Slang%%20Lens/Slang%%20Lens.html\" --window-size=820,940'; ^
$Shortcut.WorkingDirectory = $env:LOCALAPPDATA + '\Slang Lens'; ^
$Shortcut.Description = 'Slang Lens - English Slang Translator'; ^
$Shortcut.IconLocation = $env:SystemRoot + '\System32\imageres.dll,168'; ^
$Shortcut.Save()" >nul 2>&1

if %ERRORLEVEL% EQU 0 (
    echo   [OK] 桌面快捷方式已创建
) else (
    echo   [WARN] 快捷方式创建失败，可以手动打开 HTML 文件
)

echo.
echo   ✅ 安装完成！
echo.
echo   双击桌面上的 [Slang Lens] 图标启动
echo   首次使用需设置 DeepSeek API Key（点右上角齿轮⚙）
echo   Key 获取: https://platform.deepseek.com
echo.
echo   按任意键打开 Slang Lens...
pause >nul

:: Try to open the app
start "" "%INSTALL_DIR%\Slang Lens.html"
