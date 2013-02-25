Strict

Private

Import bono

Public

Class TransitionInExpo Implements Transition
    Method Calculate:Float(progress:Float)
        If progress = 0 Then Return 0
        Return Pow(2, 10 * (progress - 1.0))
    End
End

Class TransitionOutExpo Implements Transition
    Method Calculate:Float(progress:Float)
        If progress = 1 Then Return 1
        Return -Pow(2, -10 * progress) + 1
    End
End

Class TransitionInOutExpo Implements Transition
    Method Calculate:Float(progress:Float)
        If progress = 0 Then Return 0
        If progress = 1 Then Return 1

        progress *= 2
        If progress < 1 Then Return 0.5 * Pow(2, 10 * (progress - 1.0))

        progress -= 1
        Return 0.5 * (-Pow(2, -10 * progress) + 2)
    End
End
