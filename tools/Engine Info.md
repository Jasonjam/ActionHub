# ActionHub 開發環境與引擎紀錄

最後更新日期: 2026/04/19

---

### 版本來源

- AutoHotkey v1.1.37.02 (Official Portable Version)
- Ahk2Exe (Latest from GitHub Source)

---

### v1 執行引擎 (Runtime)

> 用於執行編譯器腳本 (Ahk2Exe.ahk) 或其他 V1 工具。

| 檔案名稱          | 說明                                       |
| :---------------- | :----------------------------------------- |
| AutoHotkeyA32.exe | ANSI 32-bit                                |
| AutoHotkeyU32.exe | Unicode 32-bit                             |
| AutoHotkeyU64.exe | Unicode 64-bit (目前 build.bat 使用的核心) |

---

### v1 編譯模板 (Compiler Bins)

> 用於 Ahk2Exe 自編譯或產出 V1 程式時的底層。

- ANSI 32-bit.bin
- Unicode 32-bit.bin (自編譯 Ahk2Exe.exe 的標準底層)
- Unicode 64-bit.bin

---

### v2 產品核心 (Product Base)

> 作為 ActionHub.exe 的執行底層。

- AutoHotkey32.exe: v2 32-bit 引擎
- AutoHotkey64.exe: v2 64-bit 引擎 (目前 ActionHub 產品使用的 Base)

---

### Compiler 資料夾結構

- 來源: https://github.com/AutoHotkey/Ahk2Exe。
- 說明: 包含 Ahk2Exe.ahk 原始碼及其依賴的 Lib 函式庫。
- 配置: 比照官方 GitHub 結構，確保 A_ScriptDir 引用路徑正確。

---
