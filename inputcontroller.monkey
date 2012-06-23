Strict

Private

Import mojo
Import vector2d
Import director
Import inputhandler

Public

Class InputController
    Private

    ' TODO: Resize those arrays to touchFingers_ to save memory
    Field touchDown:Int[MAX_TOUCH_FINGERS]
    Field touchUp:Int[MAX_TOUCH_FINGERS]
    Field touchPos:Vector2D[MAX_TOUCH_FINGERS]
    Field touchFingers_:Int = MAX_TOUCH_FINGERS

    Public

    Field trackTouch:Bool = True
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

        touchFingers_ = number
    End

    Private

    Method ProcessTouch:Void(handler:InputHandler)
        For Local i:Int = 0 To touchFingers_ - 1
            If touchDown[i] Then handler.OnTouchDown(i, touchPos[i])
            If touchUp[i] Then handler.OnTouchUp(i, touchPos[i])
        End
    End

    Method ReadTouch:Void()
        Local newTouchDown:Bool
        For Local i:Int = 0 To touchFingers_ - 1
            ' TODO: Reuse the last vector2d instance
            touchPos[i] = New Vector2D(TouchX(i), TouchY(i)).Div(scale)

            newTouchDown = Bool(TouchDown(i))
            touchUp[i] = (touchDown[i] And Not newTouchDown)
            touchDown[i] = newTouchDown
        End
    End
End
