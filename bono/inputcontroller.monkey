Strict

Private

Import directorevents
Import keyevent
Import mojo
Import touchevent
Import vector2d

Public

Class InputController
    Private

    Const FIRST_KEY:Int = KEY_BACKSPACE
    Const LAST_KEY:Int = KEY_QUOTES
    Const KEY_COUNT:Int = LAST_KEY - FIRST_KEY + 1
    Field _touchFingers:Int = DEFAULT_TOUCH_FINGERS
    Field isKeyDown:Bool[KEY_COUNT]
    Field isTouchDown:Bool[MAX_TOUCH_FINGERS]
    Field keyDownDispatched:Bool[KEY_COUNT]
    Field keyEvents:KeyEvent[KEY_COUNT]
    Field touchDownDispatched:Bool[MAX_TOUCH_FINGERS]
    Field touchEvents:TouchEvent[MAX_TOUCH_FINGERS]

    Public

    Field scale:Vector2D = New Vector2D(0, 0)
    Field touchMinDistance:Float = 5
    Field touchRetainSize:Int = -1
    Field trackKeys:Bool = True
    Field trackTouch:Bool = True
    Const DEFAULT_TOUCH_FINGERS:Int = 5
    Const MAX_TOUCH_FINGERS:Int = 31

    Method OnUpdate:Void(handler:DirectorEvents)
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

    Method ProcessKeys:Void(handler:DirectorEvents)
        For Local i:Int = 0 Until KEY_COUNT
            If keyEvents[i] = Null Then Continue

            If Not keyDownDispatched[i]
                handler.OnKeyDown(keyEvents[i])
                keyDownDispatched[i] = True
            ElseIf Not isKeyDown[i]
                handler.OnKeyUp(keyEvents[i])
                keyEvents[i] = Null
            Else
                handler.OnKeyPress(keyEvents[i])
            End
        End
    End

    Method ReadKeys:Void()
        Local lastKeyDown:Bool

        For Local i:Int = 0 Until KEY_COUNT
            lastKeyDown = isKeyDown[i]
            isKeyDown[i] = Bool(KeyDown(FIRST_KEY + i))

            If Not isKeyDown[i] And Not lastKeyDown Then Continue

            If keyEvents[i] = Null
                keyDownDispatched[i] = False
                keyEvents[i] = New KeyEvent(FIRST_KEY + i)
            End
        End
    End

    Method ProcessTouch:Void(handler:DirectorEvents)
        For Local i:Int = 0 Until _touchFingers
            If touchEvents[i] = Null Then Continue

            If Not touchDownDispatched[i]
                handler.OnTouchDown(touchEvents[i].Copy())
                touchDownDispatched[i] = True
            ElseIf Not isTouchDown[i]
                handler.OnTouchUp(touchEvents[i])
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

            If diffVector.Length() >= touchMinDistance
                touchEvents[i].Add(scaledVector)
                If touchRetainSize > -1 Then touchEvents[i].Trim(touchRetainSize)
            End
        End
    End
End
