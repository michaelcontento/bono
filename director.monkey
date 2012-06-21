Strict

Private

Import mojo
Import deltatimer
Import scenemanager
Import util
Import vector2d

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
    Field scenes_:SceneManager = New SceneManager()
    Field center_:Vector2D
    Field device_:Vector2D
    Field scale_:Vector2D
    Field size_:Vector2D

    Public

    Method delta:Float() Property
        Return deltaTimer.delta
    End

    Method scenes:SceneManager() Property
        Return scenes_
    End

    Method center:Vector2D() Property
        Return center_
    End

    Method device:Vector2D() Property
        Return device_
    End

    Method scale:Vector2D() Property
        Return scale_
    End

    Method size:Vector2D() Property
        Return size_
    End

    Method New()
        size_ = New Vector2D(640, 960)
        center_ = size_.Copy().Div(2)
    End

    Method OnCreate:Int()
        Seed = GetTimestamp()
        SetUpdateRate(60)
        deltaTimer = New DeltaTimer(30)
        device_ = New Vector2D(DeviceWidth(), DeviceHeight())
        scale_ = device_.Copy().Div(size_)
        Return 0
    End

    Method OnLoading:Int()
        If scenes_.current Then scenes_.current.OnLoading()
        Return 0
    End

    Method OnUpdate:Int()
        deltaTimer.OnUpdate()
        If scenes_.current Then scenes_.current.OnUpdate()
        Return 0
    End

    Method OnResume:Int()
        If scenes_.current Then scenes_.current.OnResume()
        Return 0
    End

    Method OnSuspend:Int()
        If scenes_.current Then scenes_.current.OnSuspend()
        Return 0
    End

    Method OnRender:Int()
        If Not scenes_.current Then Return 0

        PushMatrix()
            Scale(scale_.x, scale_.y)
            SetScissor(0, 0, device_.x, device_.y)

            PushMatrix()
                scenes_.current.OnRender()
            PopMatrix()
        PopMatrix()

        Return 0
    End

    Method Run:Void()
        If Not scenes_.current Then Error("No scenes_ found!")
        scenes_.Goto(scenes_.current.name)
    End
End
