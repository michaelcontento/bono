Strict

Private

Import mojo
Import scenemanager
Import vector2d
Import deltatimer

Global globalDirectorInstance:Director

Public

Function CurrentDirector:Director()
    If Not globalDirectorInstance Then globalDirectorInstance = New Director()
    Return globalDirectorInstance
End

Function CurrentDirectorReset:Void()
    globalDirectorInstance = Null
End

Class Director Extends App
    Private

    Field deltaTimer:DeltaTimer

    Public

    Field scenes:SceneManager = New SceneManager()
    Field center:Vector2D
    Field device:Vector2D
    Field scale:Vector2D
    Field size:Vector2D

    Method New()
        size = New Vector2D(640, 960)
        center = size.Copy().Div(2)
    End

    Method OnCreate:Int()
        Seed = Millisecs()
        SetUpdateRate(60)
        deltaTimer = New DeltaTimer(30)
        device = New Vector2D(DeviceWidth(), DeviceHeight())
        scale = device.Copy().Div(size)
        Return 0
    End

    Method delta:Float() Property
        Return deltaTimer.delta
    End

    Method OnLoading:Int()
        If scenes.current Then scenes.current.OnLoading()
        Return 0
    End

    Method OnUpdate:Int()
        deltaTimer.OnUpdate()
        If scenes.current Then scenes.current.OnUpdate()
        Return 0
    End

    Method OnResume:Int()
        If scenes.current Then scenes.current.OnResume()
        Return 0
    End

    Method OnSuspend:Int()
        If scenes.current Then scenes.current.OnSuspend()
        Return 0
    End

    Method OnRender:Int()
        If Not scenes.current Then Return 0

        PushMatrix()
            Scale(scale.x, scale.y)
            SetScissor(0, 0, device.x, device.y)

            PushMatrix()
                scenes.current.OnRender()
            PopMatrix()
        PopMatrix()

        Return 0
    End

    Method Run:Void()
        If Not scenes.current Then Error("No scenes found!")
        scenes.Goto(scenes.current.name)
    End
End
