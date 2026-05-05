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

; === 毒塔 ===
PoisonTower(*) {
    Send("4")
    Sleep(3000)
    __SleepTimer(15000, A_ThisFunc, "Wait Horse")

    Send("{Space down}")
    __SleepTimer(1800, A_ThisFunc, "Space 1")
    Send("{Space up}")

    Send("{Space}")
    __SleepTimer(2500, A_ThisFunc, "Space 2")

    Send("q")
    Sleep(1000)
    Send("q")
    Sleep(1000)

    __OneShotDone(A_ThisFunc)
}
; === 毒塔結束 ===

; === 超級凌雲踏 ===
UltraJump(*) {
    Send("{Esc}")
    Sleep(200)

    Send("5")
    Sleep(1050)

    Click("Right", "Down")
    Sleep(300)
    Click()
    Sleep(300)

    Send("{F3}")
    __SleepTimer(10000, A_ThisFunc, "CD 10s")
}
; === 超級凌雲踏結束 ===

; === 搶煙火 ===
Firework(*) {
    Click()
    Sleep(100)

    Send("{Space}")
    Sleep(100)
}
; === 搶煙火結束 ===

; === 木樁測DPS ===
; 無名劍心法5重用
DPS_Sword_Lv5(*) {
    actionName := A_ThisFunc

    __Spear(actionName)

    __ThreeSwordQi(actionName)

    Send("1")
    __SleepTimer(2500, A_ThisFunc, "Ride 11111")
    __SwordQi(actionName)
    Sleep(500)

    __Spear(actionName)
    __SwordQi(actionName)
    Send("6")
    __SleepTimer(1300, A_ThisFunc, "Frog 1")
    Send("e")
    __SleepTimer(500, A_ThisFunc, "e")
    __SwordQi(actionName)

    Send("1")
    __SleepTimer(2500, A_ThisFunc, "Ride 22222")
    __SwordQi(actionName)
    Sleep(900)

    __Spear(actionName)
    Sleep(200)
    __SwordQi(actionName)
    __SwordQi(actionName)

    Send("1")
    __SleepTimer(2500, A_ThisFunc, "Ride 33333")
    __SwordQi(actionName)
    Sleep(650)

    __Spear(actionName)
    __SwordQi(actionName)
    Send("6")
    __SleepTimer(1500, A_ThisFunc, "Frog 2")
    Send("e")
    __SleepTimer(200, A_ThisFunc, "e")
    __SwordQi(actionName)

    Send("1")
    __SleepTimer(2400, A_ThisFunc, "Ride 4")
    __SwordQi(actionName)

    __Spear(actionName)
    __SwordQi(actionName)
    Sleep(500)
    __SwordQi(actionName)
    Sleep(500)

    Send("4")
    __SleepTimer(10000, actionName, "4")

    __OneShotDone(A_ThisFunc)
}

; DPS_Sword_Lv6() {
;     ; 6 級的無名劍心法，之後再調整
; }

; --- DPS 通用FN ---
__ThreeSwordQi(actionFnName) {
    Send("{r down}")
    __SleepTimer(1550, actionFnName, "R 1")
    Send("{r up}")
    __SleepTimer(800, actionFnName, "R 1 end")

    Send("{r down}")
    __SleepTimer(1550, actionFnName, "R 2")
    Send("{r up}")
    __SleepTimer(800, actionFnName, "R 2 end")

    Send("{r down}")
    __SleepTimer(1550, actionFnName, "R 3")
    Send("{r up}")
    __SleepTimer(900, actionFnName, "R 3 end")
}

__SwordQi(actionFnName) {
    Send("{r down}")
    __SleepTimer(1600, actionFnName, "R")
    Send("{r up}")
    __SleepTimer(900, actionFnName, "R end")
}

__Spear(actionName) {
    Send("{WheelDown 1}")
    __SleepTimer(200, actionName, "W down")

    Send("q")
    __SleepTimer(300, actionName, "q")

    Send("e")
    __SleepTimer(200, actionName, "e")

    Send("{WheelDown 1}")
    __SleepTimer(200, actionName, "W down")
}
; === 木樁測DPS結束 ===

; === 滑鼠座標 ===
MouseCoord(*) {
    MouseGetPos(&x, &y)
    MsgBox("滑鼠座標: " . x . ", " . y)
}
; === 滑鼠座標結束 ===
