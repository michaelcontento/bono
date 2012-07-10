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

    Field _touchFingers:Int = 1
    Field isTouchDown:Bool[MAX_TOUCH_FINGERS]
    Field touchDownDispatched:Bool[MAX_TOUCH_FINGERS]
    Field touchEvents:TouchEvent[MAX_TOUCH_FINGERS]
    Field keyboardEnabled:Bool
    Field keyEvents:IntMap<KeyEvent> = New IntMap<KeyEvent>()
    Field keysActive:IntSet = New IntSet()
    Field dispatchedKeyEvents:IntSet = New IntSet()

    Public

    Const MAX_TOUCH_FINGERS:Int = 31
    Const RETAIN_UNLIMITED:Int = -1
    Field scale:Vector2D = New Vector2D(0, 0)
    Field trackKeys:Bool = False
    Field trackTouch:Bool = False
    Field touchMinDistance:Float = 5
    Field touchRetainSize:Int = 5

    Method OnUpdate:Void(handler:DirectorEvents)
        If trackTouch
            ReadTouch()
            ProcessTouch(handler)
        End

        If trackKeys
            If Not keyboardEnabled
                keyboardEnabled = True
                EnableKeyboard()
            End
            ReadKeys()
            ProcessKeys(handler)
        Else
            If keyboardEnabled
                keyboardEnabled = False
                DisableKeyboard()
                keysActive.Clear()
                keyEvents.Clear()
                dispatchedKeyEvents.Clear()
            End
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
        For Local event:KeyEvent = EachIn keyEvents.Values()
            If Not dispatchedKeyEvents.Contains(event.code)
                handler.OnKeyDown(event)
                dispatchedKeyEvents.Insert(event.code)
                Continue
            End

            If Not keysActive.Contains(event.code)
                handler.OnKeyUp(event)
                dispatchedKeyEvents.Remove(event.code)
                keyEvents.Remove(event.code)
            Else
                handler.OnKeyPress(event)
            End
        End
    End

    Method ReadKeys:Void()
        keysActive.Clear()
        Local charCode:Int

        Repeat
            charCode = GetChar()
            If Not charCode Then Return

            keysActive.Insert(charCode)
            If Not keyEvents.Contains(charCode)
                keyEvents.Add(charCode, New KeyEvent(charCode))
                dispatchedKeyEvents.Remove(charCode)
            End
        Forever
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
