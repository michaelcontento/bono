Strict

Private

Import bono

Public

Class TransitionInQuad Implements Transition
    Method Calculate:Float(progress:Float)
        Return Pow(progress, 2)
    End
End

Class TransitionOutQuad Implements Transition
    Method Calculate:Float(progress:Float)
        Return -1 * progress * (progress - 2)
    End
End

Class TransitionInOutQuad Implements Transition
    Method Calculate:Float(progress:Float)
        progress *= 2
        If progress < 1 Then Return 0.5 * Pow(progress, 2)

        progress -= 1
        Return -0.5 * (progress * (progress - 2) - 1)
    End
End
