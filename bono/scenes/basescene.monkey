Strict

Private

Import bono.kernel
Import scenemanager

Public

Class BaseScene Implements AppObserver, TouchObserver, KeyObserver Abstract
    Field sceneManager:SceneManager

    ' --- AppObserver
    Method OnCreate:Void()
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
    End

    Method OnRender:Void()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    ' --- KeyObserver
    Method OnKeyDown:Void(event:KeyEvent)
    End

    Method OnKeyPress:Void(event:KeyEvent)
    End

    Method OnKeyUp:Void(event:KeyEvent)
    End

    ' --- TouchObserver
    Method OnTouchDown:Void(event:TouchEvent)
    End

    Method OnTouchMove:Void(event:TouchEvent)
    End

    Method OnTouchUp:Void(event:TouchEvent)
    End

    ' --- SceneManager
    Method OnSceneEnter:Void()
    End

    Method OnSceneLeave:Void()
    End
End
