Strict

Private

Import bono.src.utils
Import bono.src.exceptions
Import brl.asyncevent
Import contentscaler
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
    Field contentScaler:ContentScaler

    Public

    Const DEFAULT_FPS:Int = 60
    Field renderable:Renderable
    Field suspendable:Suspendable
    Field updateable:Updateable

    Method Run:Void() Abstract

    Method GetContentScaler:ContentScaler()
        Return Null
    End

    Method GetVirtualSize:Vector2D()
        Return Device.GetSize()
    End

    Method TranslateSpace:Void(vec:Vector2D)
        If contentScaler Then contentScaler.TranslateSpace(Self, vec)
    End

    Method GetTargetFps:Int()
        Return DEFAULT_FPS
    End

    Method OnCreate:Int()
        Try
            SetUpdateRate(GetTargetFps())
            timer = New DeltaTimer(GetTargetFps())
            contentScaler = GetContentScaler()

            Director.Shared().SetApp(Self)
            Run()
        Catch ex:Exception
            Error ex
        End
        Return 0
    End

    Method OnRender:Int()
        Try
            Cls(0, 0, 0)
            UpdateAsyncEvents()
            If contentScaler Then contentScaler.OnRenderPre(Self)
            If renderable Then renderable.OnRender()
            If contentScaler Then contentScaler.OnRenderPost(Self)
        Catch ex:Exception
            Error ex
        End
        Return 0
    End

    Method OnUpdate:Int()
        Try
            timer.OnUpdate()
            If updateable Then updateable.OnUpdate(timer)
        Catch ex:Exception
            Error ex
        End
        Return 0
    End

    Method OnResume:Int()
        Try
            timer.Play()
            If suspendable Then suspendable.OnResume()
        Catch ex:Exception
            Error ex
        End
        Return 0
    End

    Method OnSuspend:Int()
        Try
            timer.Pause()
            If suspendable Then suspendable.OnSuspend()
        Catch ex:Exception
            Error ex
        End
        Return 0
    End

    Method GetDirector:Director()
        Return Director.Shared()
    End
End
