Strict

' All transitions where ported from the Kivy project
' See: https://github.com/kivy/kivy/blob/master/kivy/animation.py#L366

Interface Transition
    Method Calculate:Float(progress:Float)
End

Class TransitionLinear Implements Transition
    Method Calculate:Float(progress:Float)
        Return progress
    End
End

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

Class TransitionInSine Implements Transition
    Method Calculate:Float(progress:Float)
        Return -1 * Cos(progress * HALFPI) + 1.0
    End
End

Class TransitionOutSine Implements Transition
    Method Calculate:Float(progress:Float)
        Return Sin(progress * HALFPI)
    End
End

Class TransitionInOutSine Implements Transition
    Method Calculate:Float(progress:Float)
        Return -0.5 * (Cos(progress * PI) - 1.0)
    End
End

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

Class TransitionInElastic Implements Transition
    Private

    Const P:Float = 0.3
    Const S:Float = P / 4

    Public

    Method Calculate:Float(progress:Float)
        If progress = 1 Then Return 1
        progress -= 1

        Return -(Pow(2, 10 * progress) * Sin((progress - S) * TWOPI / P))
    End
End

Class TransitionOutElastic Implements Transition
    Private

    Const P:Float = 0.3
    Const S:Float = P / 4

    Public

    Method Calculate:Float(progress:Float)
        If progress = 1 Then Return 1
        progress -= 1

        Return Pow(2, -10 * progress) * Sin((progress - S) * TWOPI / P) + 1
    End
End

Class TransitionInOutElastic Implements Transition
    Private

    Const P:Float = 0.45
    Const S:Float = P / 4

    Public

    Method Calculate:Float(progress:Float)
        If progress = 1 Then Return 1

        progress = progress * 2 - 1
        If progress < 1 Then
            Return -0.5 * (Pow(2, 10 * progress) * Sin((progress - S) * TWOPI / P))
        End

        Return Pow(2, -10 * progress) * Sin((progress - S) * TWOPI / P) * 0.5 + 1
    End
End

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
