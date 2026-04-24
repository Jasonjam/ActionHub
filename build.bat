@echo off
chcp 65001 >nul 

:: 取得目前批次檔所在的絕對路徑 (結尾帶 \)
cd /d "%~dp0"

:: --- 核心路徑鎖定 (全部轉為絕對路徑) ---
set "V1_ENGINE=tools\AutoHotkey\AutohotkeyU64.exe"
set "COMPILER=tools\AutoHotkey\Compiler\Ahk2Exe.ahk"
set "V2_BASE=tools\AutoHotkey\AutoHotkey64.exe"
set "ICON=assets\app_icon.ico"
set "OUT_EXE=.\ActionHub.exe"
set "SOURCE=src\main.ahk"

:: === 設定 Step 工具 ===
setlocal enabledelayedexpansion
:: 定義 總步驟數
set "TOTAL_STEPS=4"
set "CUR=0"


:: 訊息輸出
echo ===========================
echo     ActionHub  編譯器
echo     ActionHub Compiler
echo ===========================
echo.
echo   若有黃色警告 Warning，請按確定
echo   If yellow warnings appear, click OK.
echo.
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

:: === 檢查環境並初始化 ===
set "FIRST_BUILD=0"
call :step 檢查環境並初始化...
echo       Checking environment and initializing...
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

:: 檢查 action.ahk
echo       開始檢查設定檔 action.ahk...
echo       Starting to check config file action.ahk...
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

if not exist "src\action.ahk" (
    if exist "src\action.ahk.template" (
        move "src\action.ahk.template" "src\action.ahk" >nul
        echo       [+] 已將 action.ahk.template 轉為 action.ahk
        echo           Converted action.ahk.template to action.ahk
        echo.
        set "FIRST_BUILD=1"
        :: 延遲1秒
        timeout /t 1 /nobreak >nul
    )
)


:: 檢查 setting.ini
echo       開始檢查設定檔 setting.ini...
echo       Starting to check config file setting.ini...
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

if not exist "src\setting.ini" (
    if exist "src\setting.ini.template" (
        move "src\setting.ini.template" "src\setting.ini" >nul
        echo       [+] 已將 setting.ini.template 轉為 setting.ini
        echo           Converted setting.ini.template to setting.ini
        echo.
        set "FIRST_BUILD=1"
        :: 延遲1秒
        timeout /t 1 /nobreak >nul
    )
)

if "%FIRST_BUILD%"=="1" (
    echo       偵測為初次編譯，環境初始化完成
    echo       Detected first build, environment initialized.
) else (
    echo       環境檢查完畢，設定檔已存在
    echo       Environment check complete, config files exist.
)
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

:: === 檢查是否正在執行 ActionHub.exe ===
call :step 檢查 ActionHub.exe 是否正在執行...
echo       Checking if ActionHub.exe is running...
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

:WAIT_ACTIONHUB_CLOSE
tasklist /FI "IMAGENAME eq ActionHub.exe" | find /I "ActionHub.exe" >nul

if %ERRORLEVEL% EQU 0 (
    cls
    echo ----------------------------------------
    echo.
    echo     請先關閉正在執行的 ActionHub.exe
    echo     Please close ActionHub.exe first
    echo.
    echo ----------------------------------------
    echo.
    echo     關閉 ActionHub.exe 後將自動繼續編譯...
    echo     Build will continue automatically after ActionHub.exe closed
    echo.
    timeout /t 2 /nobreak >nul
    goto WAIT_ACTIONHUB_CLOSE
)

echo       已確認 ActionHub.exe 未執行
echo       Confirmed ActionHub.exe is not running.
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

:: === 清理舊的 exe 檔案 ===
call :step 找尋並清理舊的 exe 檔案...
echo       Search old version exe and delete it.
echo.
if exist "%OUT_EXE%" del "%OUT_EXE%"
echo.
:: 延遲1秒
timeout /t 1 /nobreak >nul

:: === 執行 AHK 編譯 ===
call :step 編譯中...
echo       Compiling...
:: 延遲1秒
timeout /t 1 /nobreak >nul

echo.
echo       若有黃色 Warning，請按確定
echo       If yellow warnings appear, click OK.
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

:: ===== step 子程序 =====
:step
set /a CUR+=1
:: 顯示格式: [當前/總數] + 文字
:: %* 代表 call 傳進來的整段字串
echo [!CUR!/%TOTAL_STEPS%] %*
exit /b