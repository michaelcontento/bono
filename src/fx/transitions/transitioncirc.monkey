Strict

Private

Import bono

Public

Class TransitionInCirc Implements Transition
    Method Calculate:Float(progress:Float)
        Return -1 * (Sqrt(1 - Pow(progress, 2)) - 1)
    End
End

Class TransitionOutCirc Implements Transition
    Method Calculate:Float(progress:Float)
        progress -= 1
        Return Sqrt(1 - Pow(progress, 2))
    End
End

Class TransitionInOutCirc Implements Transition
    Method Calculate:Float(progress:Float)
        progress *= 2
        If progress < 1 Then Return -0.5 * (Sqrt(1 - Pow(progress, 2)) - 1)

        progress -= 2
        Return 0.5 * (Sqrt(1 - Pow(progress, 2)) + 1)
    End
End
