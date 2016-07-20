Strict

Private

Import bono

Public

Class Director
    Private

    Global instance:Director
    Field scenes:StringMap<Sceneable> = New StringMap<Sceneable>()
    Field app:BonoApp
    Field currentScene:Sceneable
    Field currentSceneName:String
    Field previousScene:Sceneable
    Field previousSceneName:String
    Field defaultTransition:SceneTransition = New SceneTransitionInstant()
    Field lastTransition:SceneTransition

    Public

    Function Shared:Director()
        If Not instance Then instance = New Director()
        Return instance
    End

    ' --- APP

    Function TranslateSpace:Vector2D(pos:Vector2D)
        Return Director.Shared().GetApp().TranslateSpace(pos)
    End

    Method SetApp:Void(app:BonoApp)
        Self.app = app
    End

    Method GetApp:BonoApp()
        Return app
    End

    ' --- SCENE

    Method HasScene:Bool(name:String)
        Return scenes.Contains(name)
    End

    Method RemoveScene:Void(name:String)
        scenes.Remove(name)
    End

    Method AddScene:Void(name:String, scene:Sceneable)
        If HasScene(name)
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
        GotoScene(name, defaultTransition)
    End

    Method GotoScene:Void(name:String, transition:SceneTransition)
        If name = GetCurrentSceneName() Then Return

        If lastTransition Then lastTransition.Finish()
        lastTransition = transition

        GetApp().SetHandler(transition)
        SwapCurrentAndPrevious(name)
        transition.Switch(GetPreviousScene(), GetCurrentScene())
    End

    Method SetDefaultSceneTransition:Void(transition:SceneTransition)
        defaultTransition = transition
    End

    Method GetCurrentScene:Sceneable()
        Return currentScene
    End

    Method GetCurrentSceneName:String()
        Return currentSceneName
    End

    Method GetPreviousScene:Sceneable()
        Return previousScene
    End

    Method GetPreviousSceneName:String()
        Return previousSceneName
    End

    Private

    Method SwapCurrentAndPrevious:Void(name:String)
        previousScene = currentScene
        previousSceneName = currentSceneName

        currentScene = GetScene(name)
        currentSceneName = name
    End
End
