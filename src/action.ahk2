; === 編輯區，在此區間可新增/編輯動作===

test__SleepTimer(*) {
    ; 1. 執行長達 5 秒的倒數
    ; 傳入 A_ThisFunc 讓 __SleepTimer 監控這個函式的開關狀態
    __SleepTimer(5000, A_ThisFunc, "測試倒數")

    ; 3. 如果是 OneShot，記得關閉 GUI 狀態
    __OneShotDone(A_ThisFunc)
}
; === Action區 ===
firework(*) {
    Click()
    Sleep(100)
    Send("{Space}")
    Sleep(100)
}

fish(*) {
    Send("{2}")
    __SleepTimer(22500, A_ThisFunc, "press 2")
}

pressF(*) {
    Send("{f}")
    sleep(100)
}

Boss_snakeBoss(*) {
    Send("{r}")
    Sleep(800)

    Click
    Sleep(1300)

    ; __OneShotDone(A_ThisFunc)
}
; === 編輯區，結束 ===
