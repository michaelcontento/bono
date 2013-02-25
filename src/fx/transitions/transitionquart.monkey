Strict

Private

Import bono

Public

Class TransitionInQuart Implements Transition
    Method Calculate:Float(progress:Float)
        Return Pow(progress, 4)
    End
End

Class TransitionOutQuart Implements Transition
    Method Calculate:Float(progress:Float)
        progress -= 1
        Return -1 * (Pow(progress, 4) - 1)
    End
End

Class TransitionInOutQuart Implements Transition
    Method Calculate:Float(progress:Float)
        progress *= 2
        If progress < 1 Then Return 0.5 * Pow(progress, 4)

        progress -= 2
        Return -0.5 * (Pow(progress, 4) - 2)
    End
End
