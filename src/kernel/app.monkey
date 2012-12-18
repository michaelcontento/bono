Strict

Private

Import deltatimer
Import director
Import key
Import mojo.app
Import mojo.graphics
Import renderable
Import suspendable
Import touch
Import updateable

Public

Class App Extends app.App Abstract
    Private

    Field timer:DeltaTimer
    Field touchEmitter:TouchEmitter
    Field keyEmitter:KeyEmitter

    Public

    Field renderable:Renderable
    Field suspendable:Suspendable
    Field updateable:Updateable

    Method Run:Void() Abstract

    Method OnCreate:Int()
        SetUpdateRate(60)
        timer = New DeltaTimer(60)
        touchEmitter = New TouchEmitter()
        keyEmitter = New KeyEmitter()

        Director.Shared().app = Self
        Run()
        Return 0
    End

    Method OnRender:Int()
        Cls(0, 0, 0)
        If renderable Then renderable.OnRender()
        Return 0
    End

    Method OnUpdate:Int()
        timer.OnUpdate()
        touchEmitter.OnUpdate(timer)
        keyEmitter.OnUpdate(timer)
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

    Method touchable:Touchable() Property
        Return touchEmitter.handler
    End

    Method touchable:Void(handler:Touchable) Property
        touchEmitter.handler = handler
    End

    Method keyhandler:Keyhandler() Property
        Return keyEmitter.handler
    End

    Method keyhandler:Void(handler:Keyhandler) Property
        keyEmitter.handler = handler
    End
End
