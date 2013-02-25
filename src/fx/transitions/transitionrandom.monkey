Strict

Private

Import bono

Public

Class TransitionRandom Implements Transition
    Private

    Field transition:Transition
    Field minDiviation:Float
    Field maxDiviation:Float
    Field maxDiviationHalf:Float

    Public

    Method New(minDiviation:Float=0, maxDiviation:Float=1, transition:Transition)
        Self.minDiviation = minDiviation
        Self.maxDiviation = maxDiviation
        Self.transition = transition
        maxDiviationHalf = maxDiviation / 2

        If minDiviation >= maxDiviation
            Error("minDiviation must be geater than maxDiviation")
        End
    End

    Method Calculate:Float(progress:Float)
        If progress >= 1 Then Return progress
        If progress <= 0 Then Return progress
        If Not transition Then Return Rnd(0, 1)

        progress = transition.Calculate(progress)

        Local diviation:Float
        Repeat
            diviation = Rnd(maxDiviationHalf * -1, maxDiviationHalf)
        Until diviation > minDiviation Or diviation < (minDiviation * -1)

        Return progress + diviation
    End
End
