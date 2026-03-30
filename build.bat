@echo off
chcp 65001 >nul 

:: 取得目前批次檔所在的絕對路徑 (結尾帶 \)
cd /d "%~dp0"

:: --- 核心路徑鎖定 (全部轉為絕對路徑) ---
set "V1_ENGINE=tools\AHK_V1_Engine.exe"
set "COMPILER=tools\Ahk2Exe\Ahk2Exe.ahk"
set "V2_BASE=tools\AutoHotkey64_v2.exe"
set "ICON=assets\app_icon.ico"
set "OUT_EXE=ActionHub.exe"
set "SOURCE=main.ahk2"

echo [1/2] 找尋並清理舊exe檔案...
if exist "%OUT_EXE%" del "%OUT_EXE%"

echo [2/2] 正在進行靜默編譯...，黃色Warning，按下確定即可

:: 使用引號包覆所有路徑，並確保參數順序正確
"%V1_ENGINE%" "%COMPILER%" /in "%SOURCE%" /out "%OUT_EXE%" /icon "%ICON%" /base "%V2_BASE%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo   編譯成功！產出檔案: ActionHub.exe
    echo ========================================
) else (
    echo.
    echo [錯誤] 編譯失敗，錯誤代碼: %ERRORLEVEL%
)
pause