Strict

Private

Import directorevents
Import fader
Import fanout
Import transition

Public

Class Animation Extends FanOut
    Private

    Field startValue:Float
    Field endValue:Float
    Field duration:Float
    Field animationTime:Float
    Field finished:Bool
    Field _value:Float

    Public

    Field transition:Transition = New TransitionLinear()
    Field effect:Fader

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
        _value = (startValue * (1.0 - t)) + (endValue * t)

        If animationTime >= duration
            animationTime = duration
            finished = True
        End
    End

    Method OnRender:Void()
        If Not effect
            Super.OnRender()
            Return
        End

        If Count() = 0 Then Return
        effect.PreRender(_value)

        For Local obj:DirectorEvents = EachIn Self
            effect.PreNode(_value, obj)
            obj.OnRender()
            effect.PostNode(_value, obj)
        End

        effect.PostRender(_value)
    End

    Method value:Float() Property
        Return _value
    End
End
