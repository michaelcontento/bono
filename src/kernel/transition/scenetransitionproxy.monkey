Strict

Private

Import bono

Public

Class SceneTransitionProxy Implements SceneTransition, Renderable, Suspendable, Updateable Abstract
    Field prevScene:Sceneable
    Field nextScene:Sceneable
    Field activeScene:Sceneable

    Method Switch:Void(prevScene:Sceneable, nextScene:Sceneable)
        Self.prevScene = prevScene
        Self.nextScene = nextScene
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If Updateable(activeScene) Then Updateable(activeScene).OnUpdate(timer)
    End

    Method OnRender:Void()
        If Renderable(activeScene) Then Renderable(activeScene).OnRender()
    End

    Method OnSuspend:Void()
        If Suspendable(activeScene) Then Suspendable(activeScene).OnSuspend()
    End

    Method OnResume:Void()
        If Suspendable(activeScene) Then Suspendable(activeScene).OnResume()
    End
End
