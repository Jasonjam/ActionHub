# ActionHub

此工具讓使用者在執行AHK熱鍵時方便監控熱鍵狀態

# 快速開始

1. **初始化**  
   首次使用或需要重新建立執行檔時，請執行根目錄下的 `build.bat`

2. **建置**  
   請依照命令提示字元（黑窗）內的說明進行操作。

3. **成品**  
   編譯完成後，系統將自動於根目錄產出 `ActionHub.exe`

## 功能介紹

### 主頁面(Main UI)

- **Action (動作設定)**
    - **Hotkey**：自定義熱鍵，請遵循格式規範

        > **格式規範：** [位置][修飾鍵 Modifiers] & [觸發主鍵 Trigger Key]  
        > **位置：** 左 (L)、右 (R) 或 不限 (空)  
        > **修飾鍵：** Alt、Ctrl、Shift  
        > **觸發主鍵：** 修飾鍵以外的任意按鍵 (如 A-Z, 0-9, F1, Space, Enter)  
        > **範例：** LCtrl & F1 (代表左邊的 Ctrl 加上 F1)

    - **Action Function**：選擇熱鍵觸發的動作。可透過系統托盤的「編輯 Action」修改 action.ahk 內的自定義動作。

- **Reload (重新整理)**
    - **用途**：重新載入 ActionHub 與目前設定。當 `action.ahk` 有變更時，會重新編譯並載入最新動作。
    - **強制 Reload 快捷鍵**：`Right Ctrl` + `F5` (右 Ctrl)，此為 Hot Reload。
- **Setting (設定頁)**
    - **Always On Top**：設定 ActionHub 視窗是否保持在最上層。
    - **Close To Tray**：設定關閉主視窗時，是否縮小至系統托盤。
    - **Backup**：備份目前的 setting.ini 與 action.ahk。
    - **Restore**：從 Backup 資料夾中還原使用者設定、Hotkey 與 Action。

### Backup / Restore

Backup 會於根目錄的 backup 資料夾建立備份：

```
backup/
└─ ActionHub-Backup-YYYYMMDD-HHmm/
   ├─ setting.ini
   └─ action.ahk
```

Restore 可選擇先前建立的 Backup 資料夾進行還原。

- 還原目前版本仍支援的設定。
- 還原使用者自定義 Hotkey。
- 還原 action.ahk 自定義動作。
- 新版本新增但舊 Backup 不存在的設定將保留目前預設值。
- 系統執行狀態與預設 Hotkey 不會被舊 Backup 覆蓋。

### 系統托盤 (System Tray)

右鍵點擊工作列圖示可進行進階管理：

- **編輯 Action / 設定檔**：手動調整腳本動作與全域配置
- **重置 Action / 設定檔**：將內容恢復至初始預設值（**請慎用**，執行後將覆蓋現有自定義內容）
