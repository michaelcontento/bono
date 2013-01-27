Strict

Private

Import bono

Public

Class Director
    Private

    Global instance:Director
    Field scenes:StringMap<Sceneable> = New StringMap<Sceneable>()
    Field currentScene:Sceneable
    Field currentSceneName:String
    Field previousScene:Sceneable
    Field previousSceneName:String
    Field app:App

    Public

    Function Shared:Director()
        If Not instance Then instance = New Director()
        Return instance
    End

    Function TranslateSpace:Vector2D(pos:Vector2D)
        Return Director.Shared().GetApp().TranslateSpace(pos)
    End

    Method SetApp:Void(app:App)
        Self.app = app
    End

    Method AddScene:Void(name:String, scene:Sceneable)
        If scenes.Contains(name)
            Error("There is already a scene named: " + name)
        End

        scenes.Set(name, scene)
    End

    Method GetScene:Sceneable(name:String)
        If Not scenes.Contains(name)
            Error("Unknown scene name given: " + name)
        End

        Return scenes.Get(name)
    End

    Method GotoScene:Void(name:String)
        If name = currentSceneName Then Return

        SwapCurrentAndPrevious(name)
        UpdateAppHandler(currentScene)

        If previousScene Then previousScene.OnSceneLeave()
        If currentScene Then currentScene.OnSceneEnter()
    End

    Method GetCurrentScene:Void()
        Return currentScene
    End

    Method GetCurrentSceneName:String()
        Return currentSceneName
    End

    Method GetPreviousScene:Void()
        Return previousScene
    End

    Method GetPreviousSceneName:String()
        Return previousSceneName
    End

    Method GetApp:App()
        Return app
    End

    Private

    Method SwapCurrentAndPrevious:Void(name:String)
        previousScene = currentScene
        previousSceneName = currentSceneName

        currentScene = GetScene(name)
        currentSceneName = name
    End

    Method UpdateAppHandler:Void(scene:Sceneable)
        If Renderable(scene)
            GetApp().renderable = Renderable(scene)
        Else
            GetApp().renderable = Null
        End

        If Suspendable(scene)
            GetApp().suspendable = Suspendable(scene)
        Else
            GetApp().suspendable = Null
        End

        If Updateable(scene)
            GetApp().updateable = Updateable(scene)
        Else
            GetApp().updateable = Null
        End
    End
End
