Strict

Private

Import bono
Import brl.asyncevent
Import mojo.app
Import mojo.graphics

Public

Class BonoApp Extends App Abstract
    Private

    Field timer:DeltaTimer
    Field contentScaler:ContentScaler

    Public

    Const DEFAULT_FPS:Int = 60
    Field renderable:Renderable
    Field suspendable:Suspendable
    Field updateable:Updateable

    Method Run:Void() Abstract

    Method TranslateSpace:Vector2D(vec:Vector2D)
        If Not contentScaler Then Return vec.Copy()
        Return contentScaler.TranslateSpace(Self, vec.Copy())
    End

    Method GetDirector:Director()
        Return Director.Shared()
    End

    Method SetHandler:Void(obj:Object)
        renderable = Renderable(obj)
        suspendable = Suspendable(obj)
        updateable = Updateable(obj)
    End

    ' --- CONFIG

    Method GetTargetFps:Int()
        Return DEFAULT_FPS
    End

    Method GetContentScaler:ContentScaler()
        Return Null
    End

    Method GetVirtualSize:Vector2D()
        Return Device.GetSize()
    End

    ' --- MONKEY APP

    Method OnCreate:Int()
        Try
            SetUpdateRate(GetTargetFps())
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
        If Not timer Then timer = New DeltaTimer(GetTargetFps())

        Try
            timer.OnUpdate()
            If timer.delta <> 0 And updateable Then updateable.OnUpdate(timer)
        Catch ex:Exception
            Error ex
        End
        Return 0
    End

    Method OnResume:Int()
        Try
            If timer Then timer.Play()
            If suspendable Then suspendable.OnResume()
        Catch ex:Exception
            Error ex
        End
        Return 0
    End

    Method OnSuspend:Int()
        Try
            If timer Then timer.Pause()
            If suspendable Then suspendable.OnSuspend()
        Catch ex:Exception
            Error ex
        End
        Return 0
    End
End
