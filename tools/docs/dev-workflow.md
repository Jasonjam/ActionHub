# 開發流程

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

開發完畢：

- `git push`，會先自動執行 [Pre-push](pre-push.md) 檢查
- 依照 terminal 提示，看是否有東西需要修改，或是可以在 `push` 一次
