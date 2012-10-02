Strict

Import bono

Class MenuScene Extends BaseScene
    Method OnTouchDown:Void(event:TouchEvent)
        sceneManager.Goto("game")
    End

    Method OnSceneEnter:Void()
        Print "OnSceneEnter: MenuScene"
    End

    Method OnSceneLeave:Void()
        Print "OnSceneLeave: MenuScene"
    End
End

Class GameScene Extends BaseScene
    Method OnKeyDown:Void(event:KeyEvent)
        sceneManager.Goto("menu")
    End
End

Function Main:Int()
    Local manager:SceneManager = New SceneManager()
    manager.Add("menu", New MenuScene())
    manager.Add("game", New GameScene())
    manager.Goto("menu")

    Return 0
End
