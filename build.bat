@echo off
chcp 65001 >nul 

:: 取得目前批次檔所在的絕對路徑 (結尾帶 \)
set "BASEDIR=%~dp0"

:: --- 核心路徑鎖定 (全部轉為絕對路徑) ---
set "V1_ENGINE=%BASEDIR%tools\AHK_V1_Engine.exe"
set "COMPILER_SCRIPT=%BASEDIR%tools\Ahk2Exe\Ahk2Exe.ahk"
set "V2_BASE_BIN=%BASEDIR%tools\AutoHotkey64_v2.exe"
set "ICON_FILE=%BASEDIR%assets\app_icon.ico"
set "OUT_EXE=%BASEDIR%ActionHub.exe"
set "SOURCE=%BASEDIR%Launcher.ahk2"

echo [1/2] 清理舊檔案...
if exist "%OUT_EXE%" del "%OUT_EXE%"

echo [2/2] 正在進行靜默編譯...

:: 使用引號包覆所有路徑，並確保參數順序正確
"%V1_ENGINE%" "%COMPILER_SCRIPT%" /in "%SOURCE%" /out "%OUT_EXE%" /icon "%ICON_FILE%" /base "%V2_BASE_BIN%"

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