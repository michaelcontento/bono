Strict

Private

Import bono

Public

Class TransitionInElastic Implements Transition
    Private

    Const P:Float = 0.3
    Const S:Float = P / 4

    Public

    Method Calculate:Float(progress:Float)
        If progress = 1 Then Return 1
        progress -= 1

        Return -(Pow(2, 10 * progress) * Sinr((progress - S) * TWOPI / P))
    End
End

Class TransitionOutElastic Implements Transition
    Private

    Const P:Float = 0.3
    Const S:Float = P / 4

    Public

    Method Calculate:Float(progress:Float)
        If progress = 1 Then Return 1
        Return Pow(2, -10 * progress) * Sinr((progress - S) * TWOPI / P) + 1
    End
End

Class TransitionInOutElastic Implements Transition
    Private

    Const P:Float = 0.45
    Const S:Float = P / 4

    Public

    Method Calculate:Float(progress:Float)
        progress *= 2
        If progress = 2 Then Return 1

        If progress < 1 Then
            progress -= 1
            Return -0.5 * (Pow(2, 10 * progress) * Sinr((progress - S) * TWOPI / P))
        Else
            progress -= 1
            Return Pow(2, -10 * progress) * Sinr((progress - S) * TWOPI / P) * 0.5 + 1
        End
    End
End
