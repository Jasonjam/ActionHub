; #Requires AutoHotkey v2.0

; ;;;;;;; Dummy FPS Test Functional
__ThreeSwordQi(actionFnName) {
    Send("{r down}")
    __SleepTimer(1550, actionFnName, "R 1")
    Send("{r up}")
    Sleep(800)

    Send("{r down}")
    __SleepTimer(1550, actionFnName, "R 2")
    Send("{r up}")
    Sleep(800)

    Send("{r down}")
    __SleepTimer(1550, actionFnName, "R 3")
    Send("{r up}")
    Sleep(900)
}

__SwordQi(actionFnName) {
    Send("{r down}")
    __SleepTimer(1600, actionFnName, "R")
    Send("{r up}")
    Sleep(900)
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