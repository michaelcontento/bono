Strict

Private

Import bono.src.helper
Import bono.src.utils
Import bono.src.kernel
Import mojo.input
Import touchable
Import touchevent

Public

Class TouchEmitter Implements Updateable, Suspendable
    Private

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
    Field handler:Touchable

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
        For Local i:Int = 0 Until _touchFingers
            touchEvents[i] = Null
        End
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        If Not active Then Return
        If Not handler Then Return

        scale = MatrixHelper.GetScale()
        ReadTouch()
        ProcessTouch()
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
                handler.OnTouchDown(touchEvents[i].Copy())
                touchDownDispatched[i] = True
            ElseIf Not isTouchDown[i]
                handler.OnTouchUp(touchEvents[i].Copy())
                touchEvents[i] = Null
            Else
                handler.OnTouchMove(touchEvents[i])
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
End