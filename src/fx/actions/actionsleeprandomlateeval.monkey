Strict

Private

Import bono

Public

Class ActionSleepRandomLateEval Extends BaseAction
    Private

    Field minDuration:Float
    Field maxDuration:Float

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Float, Float)")
    End

    Method New(minDuration:Float, maxDuration:Float)
        Self.minDuration = minDuration
        Self.maxDuration = maxDuration
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        SetDuration(Rnd(minDuration, maxDuration))
    End

    Method OnActionUpdate:Void(progress:Float)
    End
End
