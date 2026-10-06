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
; Backup
BackupSettingsHandler(*) {
    global APP_ROOT, iniFilePath, actionFilePath

    ; 不需要備份的 INI Section
    excludeSections := ["default-hotkey", "System"]

    ; --- Setting ---
    settingsJson := ""
    sectionList := IniRead(iniFilePath)

    for section in StrSplit(sectionList, "`n", "`r") {
        section := Trim(section)

        if (section == "")
            continue

        ; 排除不需要備份的 Section
        skipSection := false

        for excludeSection in excludeSections {
            if (section == excludeSection) {
                skipSection := true
                break
            }
        }

        if (skipSection)
            continue

        ; 讀取 Section 內容
        sectionData := IniRead(iniFilePath, section)

        sectionJson := ""

        for line in StrSplit(sectionData, "`n", "`r") {
            line := Trim(line)

            if (line == "")
                continue

            equalPos := InStr(line, "=")

            if (equalPos == 0)
                continue

            key := Trim(SubStr(line, 1, equalPos - 1))
            value := Trim(SubStr(line, equalPos + 1))

            if (sectionJson != "")
                sectionJson .= ",`n"

            sectionJson .= '            "' JsonEscape(key) '": "' JsonEscape(value) '"'
        }

        if (settingsJson != "")
            settingsJson .= ",`n"

        settingsJson .= '        "' JsonEscape(section) '": {`n'
        . sectionJson '`n'
        . '        }'
    }

    ; --- Action ---
    actionContent := FileRead(actionFilePath, "UTF-8")

    ; --- Backup JSON ---
    backupJson := '{`n'
        . '    "backupVersion": 1,`n'
        . '    "settings": {`n'
        . settingsJson '`n'
        . '    },`n'
        . '    "action": "' JsonEscape(actionContent) '"`n'
        . '}'

    ; --- Backup 路徑 ---
    backupDir := APP_ROOT "\backup"

    if !DirExist(backupDir)
        DirCreate(backupDir)

    backupName := "ActionHub-Backup-" FormatTime(, "yyyyMMdd-HHmm") ".json"
    backupPath := backupDir "\" backupName

    ; --- 寫入 Backup ---
    try {
        file := FileOpen(backupPath, "w", "UTF-8")
        file.Write(backupJson)
        file.Close()

        MsgBox("Backup 完成。`n請至 backup 資料夾查看。", "Backup", 64)
    } catch as err {
        MsgBox("Backup 失敗：`n" err.Message, "Backup", 16)
    }
}

; 將字串轉成可安全寫入 JSON 的格式
JsonEscape(value) {
    value := StrReplace(value, "\", "\\")
    value := StrReplace(value, '"', '\"')
    value := StrReplace(value, "`r", "\r")
    value := StrReplace(value, "`n", "\n")
    value := StrReplace(value, "`t", "\t")

    return value
}

RestoreSettingsHandler(*) {
    MsgBox("Restore")
}
