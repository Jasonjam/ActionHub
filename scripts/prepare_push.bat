@echo off
chcp 65001 >nul 
setlocal enabledelayedexpansion

:: 1. 設定絕對路徑：從腳本所在處 (scripts\) 往上一層找根目錄
set "ROOT_DIR=%~dp0.."
set "SRC_DIR=%ROOT_DIR%\src"
set "RESET_DIR=%SRC_DIR%\reset"

echo ============================================
echo [1/3] 正在檢查並重置檔案...
echo 來源目錄: %RESET_DIR%
echo 目標目錄: %SRC_DIR%

:: 確保 reset 目錄存在
if not exist "%RESET_DIR%" (
    echo [錯誤] 找不到 reset 資料夾，請確認路徑: %RESET_DIR%
    pause
    exit /b
)

:: 處理 action.ahk (從 reset 抓取)
if exist "%RESET_DIR%\default_action.ahk" (
    copy /y "%RESET_DIR%\default_action.ahk" "%SRC_DIR%\action.ahk" > nul
    copy /y "%RESET_DIR%\default_action.ahk" "%SRC_DIR%\action.ahk.template" > nul
    echo  - OK: action.ahk 與 .template 已重置
) else (
    echo  - 警告: 找不到 default_action.ahk
)

:: 處理 setting.ini (從 reset 抓取)
if exist "%RESET_DIR%\default_setting.ini" (
    copy /y "%RESET_DIR%\default_setting.ini" "%SRC_DIR%\setting.ini" > nul
    copy /y "%RESET_DIR%\default_setting.ini" "%SRC_DIR%\setting.ini.template" > nul
    echo  - OK: setting.ini 與 .template 已重置
) else (
    echo  - 警告: 找不到 default_setting.ini
)

echo.
echo [2/3] 正在清理編譯暫存檔...
if exist "%ROOT_DIR%\ActionHub_update.exe" (
    del /f /q "%ROOT_DIR%\ActionHub_update.exe"
    echo  - OK: 已清理 ActionHub_update.exe
)

echo.
echo [3/3] 準備就緒！
echo ============================================
pause