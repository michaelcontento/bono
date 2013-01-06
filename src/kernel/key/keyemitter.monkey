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
    Field event:KeyEvent = New KeyEvent()
    Field lastMode:Bool[255]

    Const UP:Int = 0
    Const DOWN:Int = 1
    Const PRESS:Int = 2

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
        For Local i:Int = 0 Until lastMode.Length()
            lastMode[i] = False
        End
    End

    Method EnableKeyboard:Void()
        If keyboardEnabled Then Return

        keyboardEnabled = True
        input.EnableKeyboard()
    End

    Method ProcessKeys:Void()
        Local mode:Bool
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
