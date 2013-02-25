Strict

Private

Import bono

Public

Class TransitionInSine Implements Transition
    Method Calculate:Float(progress:Float)
        Return -1 * Cosr(progress * HALFPI) + 1
    End
End

Class TransitionOutSine Implements Transition
    Method Calculate:Float(progress:Float)
        Return Sinr(progress * HALFPI)
    End
End

Class TransitionInOutSine Implements Transition
    Method Calculate:Float(progress:Float)
        Return -0.5 * (Cosr(progress * PI) - 1.0)
    End
End
