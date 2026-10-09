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

## Build BAT 編碼與換行規範

### 問題

從 GitHub 下載 Source ZIP 後，直接執行 `build.bat` 可能出現 CMD 指令解析錯誤，例如：

- `'EC' 不是內部或外部命令`
- `'嚜濃echo' 不是內部或外部命令`
- 中文亂碼、指令被截斷
- Build 視窗閃退，無法產生 EXE

原因與 Windows CMD 對批次檔編碼、換行格式的相容性有關。

### 格式規範

`build.bat` 必須符合：

- 編碼：UTF-8（無 BOM）
- 換行：CRLF
- 保留 `chcp 65001 >nul`

### Git 規則

根目錄 `.gitattributes`：

- `*.bat -text`：保留 BAT 原始換行，避免 Git 正規化為 LF。
- `*.cmd -text`：同樣處理 CMD 檔案。
- `.githooks/* text eol=lf`：Git Hook 使用 LF。

注意：`.gitattributes` 不會自動將錯誤格式轉成正確格式。

### pre-push 檢查

Push 前檢查即將上傳的 `build.bat`：

1. 必須是有效 UTF-8。
2. 不得包含 UTF-8 BOM。
3. 換行必須全部為 CRLF。
4. 不符合規範時中止 Push，要求修正。

此檢查只負責驗證，不自動修改檔案。

### VS Code 修改方式

1. 開啟 `build.bat`。
2. 使用 **Save with Encoding → UTF-8**。
3. 使用 **Change End of Line Sequence → CRLF**。
4. 儲存並重新測試 Build。

### 驗證

完成修改後：

1. 確認 pre-push 檢查通過。
2. 確認 GitHub 儲存庫中的 BAT 保留 CRLF。
3. 下載 GitHub Source ZIP，解壓縮後直接執行 `build.bat`。
4. 確認可正常產生 `ActionHub.exe`。
