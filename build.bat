@echo off
chcp 65001 >nul 

:: 取得目前批次檔所在的絕對路徑 (結尾帶 \)
cd /d "%~dp0"

:: --- 核心路徑鎖定 (全部轉為絕對路徑) ---
set "V1_ENGINE=tools\AHK_V1_Engine.exe"
set "COMPILER=tools\Ahk2Exe\Ahk2Exe.ahk"
set "V2_BASE=tools\AutoHotkey64_v2.exe"
set "ICON=assets\app_icon.ico"
set "OUT_EXE=.\ActionHub.exe"
set "SOURCE=src\main.ahk"


:: 訊息輸出設定
echo ===========================
echo     ActionHub  編譯器
echo     ActionHub Compiler
echo ===========================
echo.
echo   遇到黃色警告 Warning，請按確定
echo   If yellow warnings appear, click OK.
echo.
echo.

:: 延遲1秒
timeout /t 2 /nobreak >nul

echo [1/2] 找尋並清理舊的 exe 檔案...
echo       Search old version exe and delete it.
echo.
if exist "%OUT_EXE%" del "%OUT_EXE%"

:: 延遲1秒
timeout /t 1 /nobreak >nul

echo [2/2] 編譯中...，黃色 Warning，請按確定
echo       Compiling... If yellow warnings appear, click OK.
echo.

:: 延遲1秒
timeout /t 1 /nobreak >nul

:: 使用引號包覆所有路徑，並確保參數順序正確
"%V1_ENGINE%" "%COMPILER%" /in "%SOURCE%" /out "%OUT_EXE%" /icon "%ICON%" /base "%V2_BASE%"

if %ERRORLEVEL% EQU 0 (
    echo.
    echo ========================================
    echo    編譯成功! 產出檔案: ActionHub.exe
    echo    Success! Created: ActionHub.exe
    echo ========================================
    echo.
    echo 按下任何鍵可關閉
) else (
    echo.
    echo [錯誤] 編譯失敗，錯誤代碼: %ERRORLEVEL%
    echo [Error] Compilation failed. Code: %ERRORLEVEL%
)
pause