Strict

Private

Import app
Import bono.src.scenes
Import key
Import suspendable
Import suspendablefan
Import touch
Import updateable
Import updateablefan

Public

Class Director
    Private

    Global instance:Director
    Field sceneManager:SceneManager = New SceneManager()
    Field keyhandlerFan:StringMap<KeyhandlerFan> = New StringMap<KeyhandlerFan>()
    Field suspendableFan:StringMap<SuspendableFan> = New StringMap<SuspendableFan>()
    Field touchableFan:StringMap<TouchableFan> = New StringMap<TouchableFan>()
    Field updateableFan:StringMap<UpdateableFan> = New StringMap<UpdateableFan>()

    Public

    Field app:App

    Function Shared:Director()
        If Not instance Then instance = New Director()
        Return instance
    End

    Method AddScene:Void(name:String, scene:Sceneable)
        sceneManager.Add(name, scene)

        If Not updateableFan.Contains(name)
            keyhandlerFan.Set(name, New KeyhandlerFan())
            suspendableFan.Set(name, New SuspendableFan())
            touchableFan.Set(name, New TouchableFan())
            updateableFan.Set(name, New UpdateableFan())
        End
    End

    Method GotoScene:Void(name:String)
        If Not app Then Error("Please set Director.Shared().app first!")
        sceneManager.Goto(name)
        app.keyhandler = keyhandlerFan.Get(sceneManager.currentName)
        app.renderable = sceneManager
        app.suspendable = suspendableFan.Get(sceneManager.currentName)
        app.touchable = touchableFan.Get(sceneManager.currentName)
        app.updateable = updateableFan.Get(sceneManager.currentName)
    End

    Method AddUpdateable:Void(obj:Updateable)
        EnsureActiveScene()
        updateableFan.Get(sceneManager.currentName).Add(obj)
    End

    Method RemoveUpdatable:Void(obj:Updateable)
        EnsureActiveScene()
        updateableFan.Get(sceneManager.currentName).Remove(obj)
    End

    Method AddSuspendable:Void(obj:Suspendable)
        EnsureActiveScene()
        suspendableFan.Get(sceneManager.currentName).Add(obj)
    End

    Method RemoveSuspendable:Void(obj:Suspendable)
        EnsureActiveScene()
        suspendableFan.Get(sceneManager.currentName).Remove(obj)
    End

    Method AddTouchable:Void(obj:Touchable)
        EnsureActiveScene()
        touchableFan.Get(sceneManager.currentName).Add(obj)
    End

    Method RemoveTouchable:Void(obj:Touchable)
        EnsureActiveScene()
        touchableFan.Get(sceneManager.currentName).Remove(obj)
    End

    Method AddKeyhandler:Void(obj:Keyhandler)
        EnsureActiveScene()
        keyhandlerFan.Get(sceneManager.currentName).Add(obj)
    End

    Method RemoveKeyhandler:Void(obj:Keyhandler)
        EnsureActiveScene()
        keyhandlerFan.Get(sceneManager.currentName).Remove(obj)
    End

    Private

    Method EnsureActiveScene:Void()
        If Not sceneManager.currentName
            Error("Please activate a scene with Director.Shared().GotoScene() first!")
        End
    End
End
