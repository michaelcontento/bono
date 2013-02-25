Strict

Private

Import bono

Public

Class TransitionInCubic Implements Transition
    Method Calculate:Float(progress:Float)
        Return Pow(progress, 3)
    End
End

Class TransitionOutCubic Implements Transition
    Method Calculate:Float(progress:Float)
        progress -= 1
        Return Pow(progress, 3) + 1
    End
End

Class TransitionInOutCubic Implements Transition
    Method Calculate:Float(progress:Float)
        progress *= 2
        If progress < 1 Then Return 0.5 * Pow(progress, 3)

        progress -= 2
        Return 0.5 * (Pow(progress, 3) + 2)
    End
End
