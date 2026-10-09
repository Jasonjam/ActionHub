# Pre Push 流程 (.githook/pre-push)

執行 `git push` 時，會自動執行 `pre-push`，先檢查：

## 檢查 BAT 的編碼問題

確保 BAT 檔案，不會因為格式問題，被人下載後，因編碼格式導致無法執行 [build bat詳細說明](pre-push-build-bat.md)

## 檢查 Runtime檔案

1. `pre-push`會先檢查目前是否已為 .Template 狀態且無 Runtime檔。  
   若已為 Template 狀態，則跳過 Runtime 轉換，但仍執行後續檢查。
1. 將 Runtime 檔案還原為 `.template`。
1. 清除 `setting.ini.template` 的 Runtime 設定值，其中 `[default-hotkey]` 會繼續保留範例內容。
1. 檢查 `.template` 與 `/reset/default.setting.ini` 的 `Section / Key` 一致性，若有不同會發出提示並中止 Push。
1. 若 `.template` 相關檔案存在 Staged 變更，則自動建立 `chore: convert templates Commit`，並中止本次 Push。
1. 中止這次 Push。

完成後再次執行：

git push

第二次才會正式 Push。
