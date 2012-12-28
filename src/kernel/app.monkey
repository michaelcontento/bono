Strict

Private

Import bono.src.utils
Import brl.asyncevent
Import deltatimer
Import director
Import mojo.app
Import mojo.graphics
Import renderable
Import suspendable
Import updateable

Public

Class App Extends app.App Abstract
    Private

    Field timer:DeltaTimer
    Field scaleVec:Vector2D

    Public

    Const DEFAULT_FPS:Int = 60
    Field renderable:Renderable
    Field suspendable:Suspendable
    Field updateable:Updateable

    Method Run:Void() Abstract

    Method GetVirtualSize:Vector2D()
        Return Device.GetSize()
    End

    Method TranslateSpace:Void(vec:Vector2D)
        If Not scaleVec Then scaleVec = Device.GetSize().Div(GetVirtualSize())
        vec.Div(scaleVec)
    End

    Method GetTargetFps:Int()
        Return DEFAULT_FPS
    End

    Method OnCreate:Int()
        SetUpdateRate(GetTargetFps())
        timer = New DeltaTimer(GetTargetFps())

        Director.Shared().SetApp(Self)
        Run()
        Return 0
    End

    Method OnRender:Int()
        Cls(0, 0, 0)
        UpdateAsyncEvents()
        If renderable Then renderable.OnRender()
        Return 0
    End

    Method OnUpdate:Int()
        timer.OnUpdate()
        If updateable Then updateable.OnUpdate(timer)
        Return 0
    End

    Method OnResume:Int()
        timer.Play()
        If suspendable Then suspendable.OnResume()
        Return 0
    End

    Method OnSuspend:Int()
        timer.Pause()
        If suspendable Then suspendable.OnSuspend()
        Return 0
    End

    Method GetDirector:Director()
        Return Director.Shared()
    End
End
