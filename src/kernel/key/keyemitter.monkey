Strict

Private

Import bono.src.kernel
Import keyevent
Import keyhandler
Import mojo.input

Public

Class KeyEmitter Implements Updateable, Suspendable
    Private

    Field keyboardEnabled:Bool
    Field keyEvents:IntMap<KeyEvent> = New IntMap<KeyEvent>()
    Field keysActive:IntSet = New IntSet()
    Field dispatchedKeyEvents:IntSet = New IntSet()

    Public

    Field active:Bool = True
    Field handler:Keyhandler

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
        Reset()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        If Not handler Then Return

        If Not active
            DisableKeyboard()
        Else
            EnableKeyboard()
            ReadKeys()
            ProcessKeys()
        End
    End

    Private

    Method DisableKeyboard:Void()
        If Not keyboardEnabled Then Return

        keyboardEnabled = False
        input.DisableKeyboard()
        Reset()
    End

    Method Reset:Void()
        keysActive.Clear()
        keyEvents.Clear()
        dispatchedKeyEvents.Clear()
    End

    Method EnableKeyboard:Void()
        If keyboardEnabled Then Return

        keyboardEnabled = True
        input.EnableKeyboard()
    End

    Method ProcessKeys:Void()
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
End
