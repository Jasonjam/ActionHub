; === Setting Handlers ===
; 套用 Setting 狀態到目前程式
ApplySettings() {
    global currentAot

    aotOption := (currentAot == "ON") ? "+AlwaysOnTop" : "-AlwaysOnTop"
    mainGui.Opt(aotOption)
}
; Always On Top的開關
ChangeAOT(chkObj, *) {
    global currentAot

    if (chkObj.Value == 1) {
        currentAot := "ON"
        IniWrite(currentAot, iniFilePath, "Window", "AlwaysOnTop")
        return
    }

    if (chkObj.Value == 0) {
        currentAot := "OFF"
        IniWrite(currentAot, iniFilePath, "Window", "AlwaysOnTop")
        return
    }
}
; Close To Tray
ChangeTray(chkObj, *) {
    global currentTray

    if (chkObj.Value == 1) {
        currentTray := "ON"
        IniWrite(currentTray, iniFilePath, "Tray", "CloseToTray")
        return
    }

    if (chkObj.Value == 0) {
        currentTray := "OFF"
        IniWrite(currentTray, iniFilePath, "Tray", "CloseToTray")
        return
    }
}

; === Backup ===
; 將目前使用者資料完整備份至時間戳資料夾
; Backup 內容:
; - setting.ini: 完整備份
; - action.ahk: 完整備份
; Restore 時再決定哪些 Setting Section / Key 可以還原
BackupSettingsHandler(settingGui, *) {
    global APP_ROOT, iniFilePath, actionFilePath

    ; --- Backup 根目錄 ---
    backupRoot := APP_ROOT "\backup"

    if !DirExist(backupRoot)
        DirCreate(backupRoot)

    ; --- 建立本次 Backup 資料夾 ---
    backupName := "ActionHub-Backup-" FormatTime(, "yyyyMMdd-HHmm")
    backupDir := backupRoot "\" backupName

    ; 避免同一分鐘內重複 Backup 覆蓋舊資料
    if DirExist(backupDir) {
        CustomPopupBox(
            settingGui,
            "Backup",
            "此分鐘已建立過 Backup。",
            "請稍後再試。",
            "error"
        )
        return
    }

    try {
        DirCreate(backupDir)

        ; --- Backup Setting ---
        FileCopy(
            iniFilePath,
            backupDir "\setting.ini"
        )

        ; --- Backup Action ---
        FileCopy(
            actionFilePath,
            backupDir "\action.ahk"
        )

        CustomPopupBox(
            settingGui,
            "Backup",
            "Backup 完成。",
            "請至 backup 資料夾查看。"
        )
    } catch as err {
        CustomPopupBox(
            settingGui,
            "Backup",
            "Backup 失敗。",
            err.Message,
            "error"
        )
    }
}

; === Restore ===
; action.ahk:
; - 完整覆蓋目前檔案
;
; setting.ini:
; - 以目前版本的 INI 結構為基準
; - Backup 與目前版本都有的 Key 才還原
; - 新版本新增的 Key 保留目前值
; - 舊 Backup 多出的 Key 不還原
; - [default-hotkey] / [System] 不還原
; - [Hotkey] 屬於使用者資料，獨立完整還原
RestoreSettingsHandler(settingGui, *) {
    global APP_ROOT, iniFilePath, actionFilePath

    ; --- 選擇 Backup 資料夾 ---
    selectedDir := DirSelect(
        APP_ROOT "\backup",
        0,
        "選擇要還原的 Backup 資料夾"
    )

    ; 使用者取消選擇
    if (selectedDir == "")
        return

    backupIniPath := selectedDir "\setting.ini"
    backupActionPath := selectedDir "\action.ahk"

    ; --- 檢查 Backup 檔案 ---
    if !FileExist(backupIniPath) {
        CustomPopupBox(
            settingGui,
            "Restore",
            "找不到 setting.ini。",
            "請確認選擇的是正確的 Backup 資料夾。",
            "error"
        )
        return
    }
    if !FileExist(backupActionPath) {
        CustomPopupBox(
            settingGui,
            "Restore",
            "找不到 action.ahk。",
            "請確認選擇的是正確的 Backup 資料夾。",
            "error"
        )
        return
    }

    ; --- 取得 Backup 資料夾名稱 ---
    SplitPath(selectedDir, &backupName)

    if !CustomPopupBox(
        settingGui,
        "Restore",
        "確定要還原此 Backup？",
        backupName,
        "confirm"
    )
        return

    try {
        ; 不需要 Restore 的 INI Section
        excludeSections := ["default-hotkey", "System", "Hotkey"]

        ; ==================================================
        ; Restore Setting
        ; ==================================================

        ; 以目前版本的 setting.ini 為基準
        currentSectionList := IniRead(iniFilePath)
        ; Backup 沒有這個 Section 就保留目前設定
        backupSectionList := IniRead(backupIniPath)

        for section in StrSplit(currentSectionList, "`n", "`r") {
            section := Trim(section)

            if (section == "")
                continue

            ; --- 排除不需要 Restore 的 Section ---
            skipSection := false

            for excludeSection in excludeSections {
                if (section == excludeSection) {
                    skipSection := true
                    break
                }
            }

            if (skipSection)
                continue

            if !IniSectionExists(backupSectionList, section)
                continue

            ; 讀取目前版本 Section
            currentSectionData := IniRead(iniFilePath, section)

            for line in StrSplit(currentSectionData, "`n", "`r") {
                line := Trim(line)

                if (line == "")
                    continue

                equalPos := InStr(line, "=")

                if (equalPos == 0)
                    continue

                key := Trim(SubStr(line, 1, equalPos - 1))

                ; Backup 沒有這個 Key 就保留目前設定
                backupValue := IniRead(
                    backupIniPath,
                    section,
                    key,
                    "__ACTIONHUB_KEY_NOT_FOUND__"
                )

                if (backupValue == "__ACTIONHUB_KEY_NOT_FOUND__")
                    continue

                ; 目前版本與 Backup 都存在此 Key，還原 Backup 值
                IniWrite(
                    backupValue,
                    iniFilePath,
                    section,
                    key
                )
            }
        }

        ; ==================================================
        ; Restore Hotkey
        ; ==================================================

        ; Hotkey 屬於使用者資料，因此不做逐 Key Merge
        ; Backup 有 Hotkey Section 時，完整還原使用者 Hotkey
        if (IniSectionExists(backupSectionList, "Hotkey")) {
            ; 清除目前 Hotkey，避免留下 Backup 中不存在的舊綁定
            IniDelete(iniFilePath, "Hotkey")

            ; 將 Backup Hotkey 完整寫回
            backupHotkeyData := IniRead(backupIniPath, "Hotkey")

            for line in StrSplit(backupHotkeyData, "`n", "`r") {
                line := Trim(line)

                if (line == "")
                    continue

                equalPos := InStr(line, "=", , -1)

                if (equalPos == 0)
                    continue

                key := Trim(SubStr(line, 1, equalPos - 1))
                value := Trim(SubStr(line, equalPos + 1))

                IniWrite(
                    value,
                    iniFilePath,
                    "Hotkey",
                    key
                )
            }
        }

        ; ==================================================
        ; Restore Action
        ; ==================================================

        ; action.ahk 為完整使用者資料，直接覆蓋目前檔案
        FileCopy(
            backupActionPath,
            actionFilePath,
            true
        )

        CustomPopupBox(
            settingGui,
            "Restore",
            "Restore 完成。",
            "ActionHub 將重新載入。"
        )

        ; Action 已被替換，需要重新編譯
        HotReload()

    } catch as err {
        CustomPopupBox(
            settingGui,
            "Restore",
            "Restore 失敗。",
            err.Message,
            "error"
        )
    }
}

; 檢查 INI Section 是否存在
IniSectionExists(sectionList, targetSection) {
    for section in StrSplit(sectionList, "`n", "`r") {
        if (Trim(section) == targetSection)
            return true
    }

    return false
}
