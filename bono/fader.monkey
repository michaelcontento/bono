Strict

Private

Import fanout
Import mojo.graphics
Import transition

Public

Interface FaderEffect
    Method OnPreRender:Void(value:Float)
    Method OnPostRender:Void(value:Float)
End

Class Fader Extends FanOut
    Private

    Field startValue:Float
    Field endValue:Float
    Field duration:Float
    Field animationTime:Float
    Field finished:Bool
    Field value:Float

    Public

    Field transition:Transition = New TransitionLinear()
    Field effect:FaderEffect

    Method New(startValue:Float, endValue:Float, duration:Float)
        Self.startValue = startValue
        Self.endValue = endValue
        Self.duration = duration
    End

    Method OnUpdate:Void(delta:Float, frameTime:Float)
        Super.OnUpdate(delta, frameTime)

        If finished Then Return
        animationTime += frameTime

        Local progress:Float = Min(1.0, animationTime / duration)
        Local t:Float = transition.Calculate(progress)
        value = (startValue * (1.0 - t)) + (endValue * t)

        If animationTime >= duration
            animationTime = duration
            finished = True
        End
    End

    Method OnRender:Void()
        If effect Then effect.OnPreRender(value)
        Super.OnRender()
        If effect Then effect.OnPostRender(value)
    End
End

Class FaderEffectAlpha Implements FaderEffect
    Method OnPreRender:Void(value:Float)
        PushMatrix()
            SetAlpha(value)
    End

    Method OnPostRender:Void(value:Float)
        PopMatrix()
    End
End
