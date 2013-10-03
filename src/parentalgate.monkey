Strict

Private

Import bono

Public

Interface ParentalGateCallback
    Method OnParentalGate:Void()
End

Class ParentalGate Implements AlertCallback
    Private

    Const DISABLED:Int = -1
    Global instance:ParentalGate
    Field callback:ParentalGateCallback
    Field rightIndex := DISABLED

    Public

    Function Show:Void(cb:ParentalGateCallback)
        If Target.IS_IOS
            Shared().callback = cb
            Shared().ShowAlert()
        Else
            cb.OnParentalGate()
        End
    End

    Method OnAlertCallback:Void(index:Int, title:String)
        If rightIndex = DISABLED Then Return
        If (index > 0) And (index = rightIndex)
            callback.OnParentalGate()
        End
        rightIndex = DISABLED
    End

    Private

    Function Shared:ParentalGate()
        If Not instance Then instance = New ParentalGate()
        Return instance
    End

    Method ShowAlert:Void()
        Local a:Int = Floor(Rnd() * 4) + 1
        Local b:Int = Floor(Rnd() * 4) + 1
        Local c:Int = a + b
        rightIndex = 1

        Local w:Int = Floor(Rnd() * 9) + 1
        While (w = c)
            w = Floor(Rnd() * 9) + 1
        End

        If (Rnd() > 0.5)
            Local tmp := c
            c = w
            w = tmp
            rightIndex = 2
        End

        If Device.GetLanguage() = "de"
            Device.ShowAlert(
                "Kindersicherung",
                a + " + " + b + " = ?",
                ["Abbrechen", c, w],
                Self)
        Else
            Device.ShowAlert(
                "Are You An Adult?",
                a + " + " + b + " = ?",
                ["Cancel", c, w],
                Self)
        End
    End
End
