Strict

Private

Import bono

Public

Class TransitionInBack Implements Transition
    Method Calculate:Float(progress:Float)
        Return Pow(progress, 2) * (2.70158 * progress - 1.70158)
    End
End

Class TransitionOutBack Implements Transition
    Method Calculate:Float(progress:Float)
        progress -= 1
        Return Pow(progress, 2) * (2.70158 * progress + 1.70158) + 1
    End
End

Class TransitionInOutBack Implements Transition
    Private

    Const S:Float = 1.70158 * 1.525

    Public

    Method Calculate:Float(progress:Float)
        progress *= 2
        If progress < 1 Then Return 0.5 * (Pow(progress, 2) * ((S + 1) * progress - S))

        progress -= 2
        Return 0.5 * (Pow(progress, 2) * ((S + 1) * progress + S) + 2)
    End
End
