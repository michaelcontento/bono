Strict

Private

Import mojo
Import vector2d
Import director
Import inputhandler

Public

Class InputController
    Private

    Field touchEvents:TouchEvent[MAX_TOUCH_FINGERS]
    Field touchFingers_:Int = MAX_TOUCH_FINGERS
    Field isTouchUp:Bool[MAX_TOUCH_FINGERS]
    Field touchDownDispatched:Bool[MAX_TOUCH_FINGERS]

    Public

    Field trackTouch:Bool = True
    Field touchRetainSize:Int = -1
    Field scale:Vector2D = New Vector2D(0, 0)
    Const MAX_TOUCH_FINGERS:Int = 31

    Method OnUpdate:Void(handler:InputHandler)
        If trackTouch Then
            ReadTouch()
            ProcessTouch(handler)
        End
    End

    Method touchFingers:Void(number:Int) Property
        If number > MAX_TOUCH_FINGERS
            Error("Only " + MAX_TOUCH_FINGERS + " can be tracked.")
        End
        If Not number > 0
            Error("Number of fingers must be greater than 0.")
        End

        touchFingers_ = number
    End

    Private

    Method ProcessTouch:Void(handler:InputHandler)
        For Local i:Int = 0 To touchFingers_ - 1
            If touchEvents[i] = Null Then Continue

            If Not touchDownDispatched[i]
                handler.OnTouchDown(touchEvents[i].Copy())
                touchDownDispatched[i] = True
            ElseIf isTouchUp[i]
                handler.OnTouchUp(touchEvents[i])
                touchEvents[i] = Null
            Else
                handler.OnTouchMove(touchEvents[i])
            End
        End
    End

    Method ReadTouch:Void()
        Local scaledVector:Vector2D
        Local lastTouchUp:Bool

        For Local i:Int = 0 To touchFingers_ - 1
            lastTouchUp = isTouchUp[i]
            isTouchUp[i] = (Not TouchDown(i))

            If isTouchUp[i] And lastTouchUp Then Continue

            If touchEvents[i] = Null
                touchDownDispatched[i] = False
                touchEvents[i] = New TouchEvent(i)
            End

            scaledVector = New Vector2D(TouchX(i), TouchY(i)).Div(scale)
            touchEvents[i].Add(scaledVector)
            If touchRetainSize > -1 Then touchEvents[i].Trim(touchRetainSize)
        End
    End
End
