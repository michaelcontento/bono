Strict

Private

Import directorevents
Import deltatimer
Import effect
Import partial
Import transition

Public

Class Animation Extends List<Effect>
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

    Method OnUpdate:Void(deltaTimer:DeltaTimer)
        If Not finished Then UpdateProgress(deltaTimer.frameTime)
    End

    Method ToDirectorEvents:DirectorEvents()
        Return New AnimationUpdater(Self)
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

Class AnimationUpdater Extends Partial
    Private

    Field animation:Animation

    Public

    Method New(animation:Animation)
        Self.animation = animation
    End

    Method OnUpdate:Void(deltaTimer:DeltaTimer)
        animation.OnUpdate(deltaTimer)
    End
End
