Strict

Private

Import bono

Public

Class BaseAction Implements Action Abstract
    Private

    Field duration:Float
    Field elapsed:Float
    Field transition:Transition = New TransitionLinear()

    Public

    Method OnActionUpdate:Void(progress:Float) Abstract

    Method OnActionStart:Void()
        elapsed = 0
    End

    Method OnActionEnd:Void()
    End


    Method IsFinished:Bool()
        Return (elapsed >= duration)
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        elapsed += timer.frameTime
        elapsed = Min(elapsed, duration)

        Local progress := transition.Calculate(elapsed / duration)
        OnActionUpdate(progress)
    End

    Method SetDuration:BaseAction(duration:Float)
        Self.duration = duration
        Return Self
    End

    Method GetDuration:Float()
        Return duration
    End

    Method SetTransition:BaseAction(transition:Transition)
        Self.transition = transition
        Return Self
    End

    Method GetTransition:Transition()
        If Not transition Then transition = New TransitionLinear()
        Return transition
    End
End
