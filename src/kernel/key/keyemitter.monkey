Strict

Private

Import bono
Import mojo.input

Public

Class KeyEmitter Implements Updateable, Suspendable
    Private

    Field keyboardEnabled:Bool
    Field event:KeyEvent = New KeyEvent()
    Field keyStates:Int[255]
    Field dirty:Bool

    Const OFF:Int  = %000
    Const HIT:Int  = $001
    Const DOWN:Int = $010
    Const UP:Int   = %100

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
        If active And handler
            If showKeyboard
                EnableKeyboard()
            Else
                DisableKeyboard()
            End

            UpdateKeykeyStates()
            DispatchKeyEvents()
        Else
            Reset()
            DisableKeyboard()
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

        For Local i:Int = 0 Until keyStates.Length()
            keyStates[i] = OFF
        End
    End

    Method UpdateKeykeyStates:Void()
        dirty = True

        For Local i:Int = 0 Until keyStates.Length()
            If keyStates[i] = OFF
                If KeyHit(i) Then keyStates[i] = DOWN | HIT
            ElseIf keyStates[i] & HIT
                If KeyDown(i)
                    keyStates[i] = DOWN
                Else
                    keyStates[i] = UP
                End
            Else
                If keyStates[i] & UP
                    keyStates[i] = OFF
                Else
                    If Not KeyDown(i) Then keyStates[i] = UP
                End
            End
        End
    End

    Method DispatchKeyEvents:Void()
        For Local i:Int = 0 Until keyStates.Length()
            If keyStates[i] = OFF Then Continue

            event.code = i
            If keyStates[i] & HIT  Then handler.OnKeyDown(event)
            If keyStates[i] & DOWN Then handler.OnKeyPress(event)
            If keyStates[i] & UP   Then handler.OnKeyUp(event)
        End
    End
End
