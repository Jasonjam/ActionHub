# Build BAT 編碼與換行規範

## 問題

從 GitHub 下載 Source ZIP 後，直接執行 `build.bat` 可能出現 CMD 指令解析錯誤，例如：

- `'EC' 不是內部或外部命令`
- `'嚜濃echo' 不是內部或外部命令`
- 中文亂碼、指令被截斷
- Build 視窗閃退，無法產生 EXE

原因與 Windows CMD 對批次檔編碼、換行格式的相容性有關。

## 格式規範

`build.bat` 必須符合：

- 編碼：UTF-8（無 BOM）
- 換行：CRLF
- 保留 `chcp 65001 >nul`

## Git 規則

根目錄 `.gitattributes`：

- `*.bat -text`：保留 BAT 原始換行，避免 Git 正規化為 LF。
- `*.cmd -text`：同樣處理 CMD 檔案。
- `.githooks/* text eol=lf`：Git Hook 使用 LF。

注意：`.gitattributes` 不會自動將錯誤格式轉成正確格式。

## pre-push 檢查

Push 前檢查目前 HEAD Commit 中的 `build.bat`：

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

## 驗證

完成修改後：

1. 確認 pre-push 檢查通過。
2. 確認 GitHub 儲存庫中的 BAT 保留 CRLF。
3. 下載 GitHub Source ZIP，解壓縮後直接執行 `build.bat`。
4. 確認可正常產生 `ActionHub.exe`。
