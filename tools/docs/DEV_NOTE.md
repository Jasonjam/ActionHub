# DEV NOTE

## 開發流程

初始 Repository 為 Template 狀態。 ( 都以 setting.ini 為例 )

執行 `build.bat` 後：

- `.template` 轉為實際使用檔案。
- `.template` 消失屬正常狀態。
- Git 顯示 `.template` Deleted 屬正常狀態。
- 自動初始化 `.githooks/pre-push`。

開發期間：

- 直接執行 `main.ahk`。
- 可使用 Hot Reload。
- `commit` 作為小階段紀錄。
- `push` 代表一個較完整開發階段完成。

## Push 流程 (.githook/pre-push)

執行 `git push` 時，會先執行 `pre-push`：

1. `pre-push`會先檢查目前是否已為 .Template 狀態且無 Runtime檔。  
   若已準備完成，直接進行 Push。
1. 將 Runtime 檔案還原為 `.template`。
1. 清除 `setting.ini.template` 的 Runtime 設定值，其中 `[default-hotkey]` 會繼續保留範例內容。
1. 檢查 `.template` 與 `/reset/default.setting.ini` 的 `Section / Key` 一致性，若有不同會發出提示並中止 Push。
1. 將 `pre-push` 產生的 Template 也建立成一個 commit。 chore: convert templates
1. 中止這次 Push。

完成後再次執行：

git push

第二次才會正式 Push。

## Hot Reload

這裡記錄 Hot Reload 的運作方式、觸發方式及相關檔案。

例如：

- 哪個檔案負責監控。
- 哪些檔案變更會觸發 Reload。
- Reload 後哪些狀態會保留。
- 開發時需要注意的限制。
