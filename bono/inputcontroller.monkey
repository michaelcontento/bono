Strict

Private

Import mojo
Import inputhandler
Import keyevent
Import touchevent
Import vector2d

Public

Class InputController
    Private

    Const FIRST_KEY:Int = KEY_BACKSPACE
    Const LAST_KEY:Int = KEY_QUOTES
    Const KEY_COUNT:Int = LAST_KEY - FIRST_KEY + 1

    Public

    Field _touchFingers:Int = MAX_TOUCH_FINGERS
    Field touchEvents:TouchEvent[MAX_TOUCH_FINGERS]
    Field isTouchUp:Bool[MAX_TOUCH_FINGERS]
    Field touchDownDispatched:Bool[MAX_TOUCH_FINGERS]
    Field keyEvents:KeyEvent[KEY_COUNT]
    Field isKeyUp:Bool[KEY_COUNT]
    Field keyDownDispatched:Bool[KEY_COUNT]

    Public

    Field trackTouch:Bool = True
    Field trackKeys:Bool = True
    Field touchRetainSize:Int = -1
    Field scale:Vector2D = New Vector2D(0, 0)
    Const MAX_TOUCH_FINGERS:Int = 31

    Method OnUpdate:Void(handler:InputHandler)
        If trackTouch
            ReadTouch()
            ProcessTouch(handler)
        End

        If trackKeys
            ReadKeys()
            ProcessKeys(handler)
        End
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

    Method ProcessKeys:Void(handler:InputHandler)
        For Local i:Int = 0 Until KEY_COUNT
            If keyEvents[i] = Null Then Continue

            If Not keyDownDispatched[i]
                handler.OnKeyDown(keyEvents[i])
                keyDownDispatched[i] = True
            ElseIf isKeyUp[i]
                handler.OnKeyUp(keyEvents[i])
                keyEvents[i] = Null
            Else
                handler.OnKeyPress(keyEvents[i])
            End
        End
    End

    Method ReadKeys:Void()
        Local lastKeyUp:Bool

        For Local i:Int = 0 Until KEY_COUNT
            lastKeyUp = isKeyUp[i]
            isKeyUp[i] = (Not KeyDown(FIRST_KEY + i))

            If isKeyUp[i] And lastKeyUp Then Continue

            If keyEvents[i] = Null
                keyDownDispatched[i] = False
                keyEvents[i] = New KeyEvent(FIRST_KEY + i)
            End
        End
    End

    Method ProcessTouch:Void(handler:InputHandler)
        For Local i:Int = 0 Until _touchFingers
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

        For Local i:Int = 0 Until _touchFingers
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