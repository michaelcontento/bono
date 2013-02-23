Strict

Private

Import bono

Public

Class SceneTransitionInstant Implements SceneTransition
    Method Switch:Void(prevScene:Sceneable, nextScene:Sceneable)
        If prevScene Then prevScene.OnSceneLeave()
        If nextScene Then nextScene.OnSceneEnter()

        Director.Shared().GetApp().SetHandler(nextScene)
    End

    Method Finish:Void()
    End
End
