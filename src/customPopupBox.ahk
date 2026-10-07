; === Custom Popup Box ===
; 自訂訊息視窗，顯示在 Owner GUI 的右下偏移位置

CustomPopupBox(ownerGui, title, message, detail := "", type := "info") {
    result := false

    ; --- Popup 設定 ---
    popupW := 290
    popupH := 135
    popupOffsetX := 20
    popupOffsetY := 30
    paddingX := 20
    textW := popupW - (paddingX * 2)

    ; --- 建立 Popup ---
    popupGui := Gui(
        "+Owner" ownerGui.Hwnd " -MinimizeBox -MaximizeBox",
        title
    )

    popupGui.SetFont("s10", "Microsoft JhengHei")

    ; --- 主要訊息 ---
    popupGui.Add(
        "Text",
        Format(
            "x{:d} y20 w{:d} Center",
            paddingX,
            textW
        ),
        message
    )

    ; --- 詳細訊息 ---
    if (detail != "") {
        popupGui.Add(
            "Text",
            Format(
                "x{:d} y50 w{:d} Center",
                paddingX,
                textW
            ),
            detail
        )
    }

    ; --- Confirm ---
    if (type == "confirm") {
        btnConfirm := popupGui.Add(
            "Button",
            "x50 y90 w90 h28 Default",
            "Restore"
        )

        btnCancel := popupGui.Add(
            "Button",
            "x150 y90 w90 h28",
            "Cancel"
        )

        btnConfirm.OnEvent("Click", (*) => ClosePopup(true))
        btnCancel.OnEvent("Click", (*) => ClosePopup(false))
    }

    ; --- Info / Error ---
    if (type != "confirm") {
        btnOK := popupGui.Add(
            "Button",
            "x100 y90 w90 h28 Default",
            "OK"
        )

        btnOK.OnEvent("Click", (*) => ClosePopup(true))
    }

    ; 右上角 X 視為取消
    popupGui.OnEvent("Close", (*) => ClosePopup(false))

    ; --- 取得 Owner 左上角位置 ---
    ownerGui.GetPos(&ownerX, &ownerY)

    ; 從 Owner 左上角往右下偏移
    popupX := ownerX + popupOffsetX
    popupY := ownerY + popupOffsetY

    popupGui.Show(
        Format(
            "x{:d} y{:d} w{:d} h{:d}",
            popupX,
            popupY,
            popupW,
            popupH
        )
    )

    ; 等待使用者操作
    WinWaitClose("ahk_id " popupGui.Hwnd)

    return result

    ; --- 關閉 Popup ---
    ClosePopup(closeResult) {
        result := closeResult
        popupGui.Destroy()
    }
}
