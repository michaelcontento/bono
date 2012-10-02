Strict

Private

Import bono.kernel
Import effect
Import transition

Public

Class Animation Extends List<Effect> Implements AppObserver
    Private

    Field animationTime:Float
    Field duration:Float
    Field finished:Bool = True
    Field transition:Transition

    Public

    Method New()
        Error("Wrong constructor. Use New(Float, Transition)")
    End

    Method New(duration:Float, transition:Transition)
        Super.New()
        Self.duration = duration
        Self.transition = transition
    End

    Method Pause:Void()
        finished = True
    End

    Method Start:Void()
        finished = False
    End

    Method Stop:Void()
        Pause()
        Restart()
    End

    Method Restart:Void()
        animationTime = 0
        SetProgress(0)
    End

    Method IsPlaying:Bool()
        Return (Not finished)
    End

    Method OnCreate:Void()
    End

    Method OnLoading:Void()
    End

    Method OnRender:Void()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
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
