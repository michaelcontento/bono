Strict

Private

Import appobserver
Import bono.utils
Import deltatimer
Import mojo.input
Import observable
Import touchevent
Import touchobserver

Public

Class TouchEmitter Implements Observable, AppObserver
    Private

    Const DOWN:Int = 0
    Const UP:Int = 1
    Const MOVE:Int = 2
    Field observers:List<TouchObserver> = New List<TouchObserver>()
    Field _touchFingers:Int = MAX_TOUCH_FINGERS
    Field isTouchDown:Bool[MAX_TOUCH_FINGERS]
    Field touchDownDispatched:Bool[MAX_TOUCH_FINGERS]
    Field touchEvents:TouchEvent[MAX_TOUCH_FINGERS]
    Field scale:Vector2D = New Vector2D(1, 1)

    Public

    Const MAX_TOUCH_FINGERS:Int = 31
    Const RETAIN_UNLIMITED:Int = -1
    Field minDistance:Float = 0
    Field retainSize:Int = RETAIN_UNLIMITED
    Field active:Bool = True

    Method OnLoading:Void()
    End

    Method OnRender:Void()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        If Not active Then Return

        scale = MatrixHelper.GetScale()
        ReadTouch()
        ProcessTouch()
    End

    Method AddObserver:Void(observer:TouchObserver)
        If observers.Contains(observer) Then Return
        observers.AddLast(observer)
    End

    Method RemoveObserver:Void(observer:TouchObserver)
        observers.RemoveEach(observer)
    End

    Method GetObservers:List<TouchObserver>()
        Return observers
    End

    Method touchFingers:Void(number:Int) Property
        If number > MAX_TOUCH_FINGERS
            Error("Only " + MAX_TOUCH_FINGERS + " can be tracked.")
        End
        If Not number > 0
            Error("Number of fingers must be greater than 0.")
        End

        _touchFingers = number
    End

    Private

    Method ProcessTouch:Void()
        For Local i:Int = 0 Until _touchFingers
            If touchEvents[i] = Null Then Continue

            If Not touchDownDispatched[i]
                NotifyTouch(DOWN, touchEvents[i].Copy())
                touchDownDispatched[i] = True
            ElseIf Not isTouchDown[i]
                NotifyTouch(UP, touchEvents[i])
                touchEvents[i] = Null
            Else
                NotifyTouch(MOVE, touchEvents[i])
            End
        End
    End

    Method ReadTouch:Void()
        Local scaledVector:Vector2D
        Local diffVector:Vector2D
        Local lastTouchDown:Bool

        For Local i:Int = 0 Until _touchFingers
            lastTouchDown = isTouchDown[i]
            isTouchDown[i] = Bool(TouchDown(i))

            If Not isTouchDown[i] And Not lastTouchDown Then Continue

            If touchEvents[i] = Null
                touchDownDispatched[i] = False
                touchEvents[i] = New TouchEvent(i)
            End

            scaledVector = New Vector2D(TouchX(i), TouchY(i)).Div(scale)
            diffVector = scaledVector.Copy().Sub(touchEvents[i].prevPos)

            If diffVector.Length() >= minDistance
                touchEvents[i].Add(scaledVector)
                If retainSize > -1 Then touchEvents[i].Trim(retainSize)
            End
        End
    End

    Method NotifyTouch:Void(mode:Int, event:TouchEvent)
        For Local observer:TouchObserver = EachIn GetObservers()
            Select mode
            Case DOWN
                observer.OnTouchDown(event)
            Case UP
                observer.OnTouchUp(event)
            Case MOVE
                observer.OnTouchMove(event)
            Default
                Error("Invalid mode " + mode + " for NotifyKey given")
            End
        End
    End
End
