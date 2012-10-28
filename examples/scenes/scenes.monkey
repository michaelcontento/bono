Strict

Import bono

Class MenuScene Extends BaseScene Implements TouchObserver
    Method OnTouchDown:Void(event:TouchEvent)
        GetSceneManager().Goto("game")
    End

    Method OnTouchMove:Void(event:TouchEvent)
    End

    Method OnTouchUp:Void(event:TouchEvent)
    End

    Method OnSceneEnter:Void()
        Print "OnSceneEnter: MenuScene"
        Super.OnSceneEnter()
    End

    Method OnSceneLeave:Void()
        Print "OnSceneLeave: MenuScene"
        Super.OnSceneLeave()
    End
End

Class GameScene Extends BaseScene Implements KeyObserver
    Method OnKeyDown:Void(event:KeyEvent)
        GetSceneManager().Goto("menu")
    End

    Method OnKeyPress:Void(event:KeyEvent)
    End

    Method OnKeyUp:Void(event:KeyEvent)
    End
End

Function Main:Int()
    Local manager:SceneManager = New SceneManager()
    manager.Add("menu", New MenuScene())
    manager.Add("game", New GameScene())
    manager.Goto("menu")

    Return 0
End
