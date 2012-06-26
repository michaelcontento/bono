Strict

Private

Import mojo
Import color
Import deltatimer
Import displayobject
Import inputcontroller
Import scenemanager
Import util
Import vector2d

Public

Class Director Extends App
    Private

    Field deltaTimer:DeltaTimer
    Field _inputController:InputController = New InputController()
    Field _center:Vector2D
    Field _device:Vector2D
    Field _scale:Vector2D
    Field _size:Vector2D

    Public

    Field clearColor:Color = New Color(0, 0, 0)

    Field scenes:SceneManager

    Method New()
        Error("Please use New(Int, Int) with proper screen dimensions")
    End

    Method New(width:Int, height:Int)
        Super.New()
        scenes = New SceneManager(Self)
        _size = New Vector2D(width, height)
        _center = _size.Copy().Div(2)
    End

    Method OnCreate:Int()
        _device = New Vector2D(DeviceWidth(), DeviceHeight())
        _scale = _device.Copy().Div(_size)
        _inputController.scale = _scale

        Seed = GetTimestamp()

        deltaTimer = New DeltaTimer(30)
        SetUpdateRate(60)

        Return 0
    End

    Method OnLoading:Int()
        If scenes.scene Then scenes.scene.OnLoading()
        Return 0
    End

    Method OnUpdate:Int()
        deltaTimer.OnUpdate()
        If scenes.scene
            _inputController.OnUpdate(scenes.scene)
            scenes.scene.OnUpdate()
        End
        Return 0
    End

    Method OnResume:Int()
        If scenes.scene Then scenes.scene.OnResume()
        Return 0
    End

    Method OnSuspend:Int()
        If scenes.scene Then scenes.scene.OnSuspend()
        Return 0
    End

    Method OnRender:Int()
        If Not scenes.scene Then Return 0

        PushMatrix()
            Scale(_scale.x, _scale.y)
            SetScissor(0, 0, _device.x, _device.y)
            Cls(clearColor.red, clearColor.green, clearColor.blue)

            PushMatrix()
                scenes.scene.OnRender()
            PopMatrix()
        PopMatrix()

        Return 0
    End

    Method Run:Void(scene:String)
        scenes.Goto(scene)
    End

    Method CenterX:Void(entity:DisplayObject)
        entity.pos.x = _center.x - entity.center.x
    End

    Method CenterY:Void(entity:DisplayObject)
        entity.pos.y = _center.y - entity.center.y
    End

    Method Center:Void(entity:DisplayObject)
        entity.pos = _center.Copy().Sub(entity.center)
    End

    Method delta:Float() Property
        Return deltaTimer.delta
    End

    Method center:Vector2D() Property
        Return _center
    End

    Method device:Vector2D() Property
        Return _device
    End

    Method scale:Vector2D() Property
        Return _scale
    End

    Method size:Vector2D() Property
        Return _size
    End

    Method inputController:InputController() Property
        Return _inputController
    End
End
