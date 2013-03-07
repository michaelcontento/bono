Strict

Private

Import bono

Public

Class Animation Extends List<Effect> Implements Updateable
    Private

    Field animationTime:Float
    Field duration:Float
    Field finished:Bool = True
    Field transition:Transition

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Float, Transition)")
    End

    Method New(duration:Float, transition:Transition)
        Super.New()
        Self.duration = duration
        Self.transition = transition
    End

    Method GetTransition:Transition()
        Return transition
    End

    Method GetDuration:Float()
        Return duration
    End

    Method Pause:Void()
        finished = True
    End

    Method Start:Void()
        finished = False
    End

    Method Stop:Void()
        Pause()
        animationTime = duration
        SetProgress(1)
    End

    Method Restart:Void()
        animationTime = 0
        SetProgress(0)
        Start()
    End

    Method IsPlaying:Bool()
        Return (Not finished)
    End

    Method OnUpdate:Void(deltaTimer:DeltaTimer)
        If Not finished Then UpdateProgress(deltaTimer.frameTime)
    End

    Private

    Method SetProgress:Void(progress:Float)
        For Local effect:Effect = EachIn Self
            effect.OnProgress(progress)
        End
    End

    Method UpdateProgress:Void(frameTime:Float)
        animationTime = Min(duration, animationTime + frameTime)

        If animationTime = duration
            Pause()
            SetProgress(1)
        Else
            Local progress:Float = Min(1.0, animationTime / duration)
            Local t:Float = transition.Calculate(progress)
            SetProgress((0 * (1.0 - t)) + (1 * t))
        End
    End
End
