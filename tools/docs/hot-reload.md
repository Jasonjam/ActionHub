# Hot Reload

ActionHub 的 Hot Reload 並非局部更新函式，而是重新載入整個腳本，或重新編譯並啟動 EXE。

## 觸發方式

- 主視窗的 `Reload` 按鈕：呼叫 `ReloadHandler()`。
- 系統托盤的「重新載入腳本」：呼叫 `ReloadHandler()`。
- `RCtrl + F5`：直接呼叫 `HotReload()`，強制重新編譯 EXE。
- 在 Action GUI 儲存熱鍵、重置設定檔或動作檔時，也會呼叫 `ReloadHandler()`。

## ReloadHandler 流程

`ReloadHandler()` 會比較 `src/user/action.ahk` 的最後修改時間與 `src/user/setting.ini` 中 `[System] LastActionTime` 的紀錄：

1. 若紀錄不為 `0`，且 `action.ahk` 的修改時間較新，呼叫 `HotReload()`。
2. 否則呼叫 AutoHotkey 的 `Reload()`，重新啟動目前腳本。

程式啟動時會重新記錄 `action.ahk` 的修改時間至 `LastActionTime`。

> 此機制不會持續監控檔案，也不是修改後立即自動觸發；必須透過上述操作呼叫 Reload。

## HotReload 流程

`HotReload()` 會：

1. 使用專案內的 AutoHotkey 編譯工具，以 `src/main.ahk` 為來源重新編譯。
2. 先輸出至系統暫存目錄的 `ActionHub_compile_tmp.exe`。
3. 若暫存 EXE 成功產生，啟動外部 CMD 工作，並結束目前程式。
4. CMD 等待後，將暫存 EXE 移至專案根目錄的 `ActionHub.exe`，再啟動新版 EXE。

## 注意事項

- 無論 `Reload()` 或重新編譯後啟動 EXE，都是整個程式重新啟動，並非保留目前執行中的函式、Timer 或 GUI 物件。
- 可從 INI 重新讀取已儲存的設定；執行中的暫存狀態不會自動保留。
- `RCtrl + F5` 會直接進入重新編譯流程，不會先比較 `action.ahk` 的修改時間。
- `ReloadHandler()` 只比較 `action.ahk` 的時間戳；修改其他檔案不會因此自動判定需要重新編譯。
