; === 編輯區，在此區間可新增/編輯動作===

; --- 預設動作範例，此段可刪除 ---
test__SleepTimer(*) {
    ; 1. 執行長達 5 秒的倒數
    ; 傳入 A_ThisFunc 讓 __SleepTimer 監控這個函式的開關狀態
    __SleepTimer(5000, A_ThisFunc, "測試倒數")

    ; 3. 如果是 OneShot，記得關閉 GUI 狀態
    __OneShotDone(A_ThisFunc)
}

test__MsgBox(*) {
    MsgBox("This is an test message box")
}
; --- 預設動作範例結束 ---

test_msgbox1(*){
    msgbox("這是測試動作1")
}

; === 編輯區，結束 ===
