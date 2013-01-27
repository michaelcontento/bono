Strict

Private

Import bono

Function OutBounce:Float(progress:Float)
    If progress < (1 / 2.75) Return 7.5625 * Pow(progress, 2)

    If progress < (2 / 2.75)
        progress -= 1.5 / 2.75
        Return 7.5625 * Pow(progress, 2) + 0.75
    End

    If progress < (2.5 / 2.75)
        progress -= 2.25 / 2.75
        Return 7.5625 * Pow(progress, 2) + 0.9375
    End

    progress -= 2.625 / 2.75
    Return 7.5625 * Pow(progress, 2) + 0.984375
End

Function InBounce:Float(progress:Float)
    Return 1 - OutBounce(1 - progress)
End

Public

Class TransitionInBounce Implements Transition
    Method Calculate:Float(progress:Float)
        Return InBounce(progress)
    End
End

Class TransitionOutBounce Implements Transition
    Method Calculate:Float(progress:Float)
        Return OutBounce(progress)
    End
End

Class TransitionInOutBounce Implements Transition
    Method Calculate:Float(progress:Float)
        progress *= 2
        If progress < 1 Then Return InBounce(progress) * 0.5

        Return OutBounce(progress - 1) * 0.5 + 0.5
    End
End
