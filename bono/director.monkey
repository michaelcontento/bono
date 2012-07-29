Strict

Private

Import deltatimer
Import directorevents
Import inputcontroller
Import mojo
Import sizeable
Import util
Import vector2d

Public

Class Director Extends App Implements Sizeable
    Private

    Field _center:Vector2D
    Field _device:Vector2D = New Vector2D(0, 0)
    Field _inputController:InputController = New InputController()
    Field _scale:Vector2D
    Field _size:Vector2D
    Field _handler:DirectorEvents
    Field onCreateDispatched:Bool
    Field appOnCreateCatched:Bool

    Public

    Field deltaTimer:DeltaTimer

    Method New(width:Int, height:Int)
        Super.New()
        size = New Vector2D(width, height)
    End

    Method OnCreate:Int()
        _device = New Vector2D(DeviceWidth(), DeviceHeight())
        If Not size Then size = _device.Copy()
        RecalculateScale()

        inputController.scale = scale
        Seed = GetTimestamp()

        deltaTimer = New DeltaTimer(30)
        SetUpdateRate(60)

        appOnCreateCatched = True
        DispatchOnCreate()
        Return 0
    End

    Method OnLoading:Int()
        If _handler Then _handler.OnLoading()
        Return 0
    End

    Method OnUpdate:Int()
        deltaTimer.OnUpdate()
        If _handler
            _handler.OnUpdate(deltaTimer)
            inputController.OnUpdate(_handler)
        End
        Return 0
    End

    Method OnResume:Int()
        If _handler Then _handler.OnResume(0)
        Return 0
    End

    Method OnSuspend:Int()
        If _handler Then _handler.OnSuspend()
        Return 0
    End

    Method OnRender:Int()
        PushMatrix()
            Scale(_scale.x, _scale.y)
            SetScissor(0, 0, _device.x, _device.y)
            Cls(0, 0, 0)

            PushMatrix()
                If _handler Then _handler.OnRender()
            PopMatrix()
        PopMatrix()
        Return 0
    End

    Method Run:Void(_handler:DirectorEvents)
        Self._handler = _handler
        DispatchOnCreate()
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

    Method size:Void(newSize:Vector2D) Property
        _size = newSize
        _center = _size.Copy().Div(2)
        RecalculateScale()
    End

    Method inputController:InputController() Property
        Return _inputController
    End

    Method handler:DirectorEvents() Property
        Return _handler
    End

    Private

    Method RecalculateScale:Void()
        _scale = _device.Copy().Div(_size)
    End

    Method DispatchOnCreate:Void()
        If onCreateDispatched Then Return
        If Not _handler Then Return
        If Not appOnCreateCatched Then Return

        _handler.OnCreate(Self)
        onCreateDispatched = True
    End
End
