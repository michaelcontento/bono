Strict

Private

Import bono
Import mojo.input

Public

Class KeyEmitter Implements Updateable, Suspendable
    Private

    Field keyboardEnabled:Bool
    Field event:KeyEvent = New KeyEvent()
    Field lastMode:Bool[255]
    Field dirty:Bool

    Const UP:Int = 0
    Const DOWN:Int = 1
    Const PRESS:Int = 2

    Public

    Field active:Bool = True
    Field handler:Keyhandler
    Field showKeyboard:Bool = True

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
        Reset()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
        If showKeyboard
            EnableKeyboard()
        Else
            DisableKeyboard()
        End

        If active And handler
            ProcessKeys()
        Else
            Reset()
        End
    End

    Private

    Method DisableKeyboard:Void()
        If Not keyboardEnabled Then Return
        keyboardEnabled = False

        input.DisableKeyboard()
    End

    Method EnableKeyboard:Void()
        If keyboardEnabled Then Return
        keyboardEnabled = True

        input.EnableKeyboard()
    End

    Method Reset:Void()
        If Not dirty Then Return
        dirty = False

        For Local i:Int = 0 Until lastMode.Length()
            lastMode[i] = False
        End
    End

    Method ProcessKeys:Void()
        Local mode:Bool
        dirty = True

        For Local i:Int = 0 Until lastMode.Length()
            mode = (KeyDown(i) = 1)

            If mode = lastMode[i]
                If mode Then DispatchEvent(i, PRESS)
            Else
                lastMode[i] = mode
                If mode
                    DispatchEvent(i, DOWN)
                Else
                    DispatchEvent(i, UP)
                End
            End
        End
    End

    Method DispatchEvent:Void(code:Int, mode:Int)
        event.code = code

        Select mode
        Case UP
            handler.OnKeyUp(event)
        Case DOWN
            handler.OnKeyDown(event)
        Case PRESS
            handler.OnKeyPress(event)
        End
    End
End
