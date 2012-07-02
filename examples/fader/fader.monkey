Strict

' WANING: This is NOT finished and just my personal test while implementing all
'         the fader and transition stuff!

Import mojo.graphics
Import bono

Class Text Extends Partial
    Private

    Field pos:Vector2D
    Field text:String

    Public

    Method New(text:String)
        Self.text = text
    End

    Method OnCreate:Void(director:Director)
        pos = New Vector2D(director.size.x * Rnd(), director.size.y * Rnd())
    End

    Method OnRender:Void()
        DrawText(text, pos.x, pos.y)
    End
End

Function AddFader:Void(pool:FanOut, text:String, effect:FaderEffect, transition:Transition)
    Local duration:Float = Ceil(8000 * Rnd())
    Local fader:Fader = New Fader(0, 1, duration)
    fader.effect = effect
    fader.transition = transition
    fader.Add(New Text(text + " (" + (duration / 1000) + " sec)"))

    pool.Add(fader)
End

Function Main:Int()
    Local pool:FanOut = New FanOut()
    AddFader(pool, "Alpha InQuad", New FaderEffectAlpha(), New TransitionInQuad())
    AddFader(pool, "Alpha OutQuad", New FaderEffectAlpha(), New TransitionOutQuad())
    AddFader(pool, "Alpha InCubic", New FaderEffectAlpha(), New TransitionInCubic())
    AddFader(pool, "Alpha OutCubic", New FaderEffectAlpha(), New TransitionOutCubic())
    AddFader(pool, "Alpha InOutCubic", New FaderEffectAlpha(), New TransitionInOutCubic())
    AddFader(pool, "Alpha InQuart", New FaderEffectAlpha(), New TransitionInQuart())
    AddFader(pool, "Alpha OutQuart", New FaderEffectAlpha(), New TransitionOutQuart())
    AddFader(pool, "Alpha InOutQuart", New FaderEffectAlpha(), New TransitionInOutQuart())
    AddFader(pool, "Alpha InSine", New FaderEffectAlpha(), New TransitionInSine())
    AddFader(pool, "Alpha OutSine", New FaderEffectAlpha(), New TransitionOutSine())
    AddFader(pool, "Alpha InOutSine", New FaderEffectAlpha(), New TransitionInOutSine())
    AddFader(pool, "Alpha InExpo", New FaderEffectAlpha(), New TransitionInExpo())
    AddFader(pool, "Alpha OutExpo", New FaderEffectAlpha(), New TransitionOutExpo())
    AddFader(pool, "Alpha InOutExpo", New FaderEffectAlpha(), New TransitionInOutExpo())
    AddFader(pool, "Alpha InCirc", New FaderEffectAlpha(), New TransitionInCirc())
    AddFader(pool, "Alpha OutCirc", New FaderEffectAlpha(), New TransitionOutCirc())
    AddFader(pool, "Alpha InOutCirc", New FaderEffectAlpha(), New TransitionInOutCirc())
    AddFader(pool, "Alpha InElastic", New FaderEffectAlpha(), New TransitionInElastic())
    AddFader(pool, "Alpha OutElastic", New FaderEffectAlpha(), New TransitionOutElastic())
    AddFader(pool, "Alpha InOutElastic", New FaderEffectAlpha(), New TransitionInOutElastic())
    AddFader(pool, "Alpha InBack", New FaderEffectAlpha(), New TransitionInBack())
    AddFader(pool, "Alpha OutBack", New FaderEffectAlpha(), New TransitionOutBack())
    AddFader(pool, "Alpha InOutBack", New FaderEffectAlpha(), New TransitionInOutBack())
    AddFader(pool, "Alpha InBounce", New FaderEffectAlpha(), New TransitionInBounce())
    AddFader(pool, "Alpha OutBounce", New FaderEffectAlpha(), New TransitionOutBounce())
    AddFader(pool, "Alpha InOutBounce", New FaderEffectAlpha(), New TransitionInOutBounce())
    AddFader(pool, "Alpha InOutBack", New FaderEffectAlpha(), New TransitionInOutBack())

    Local director:Director = New Director(640, 480)
    director.Run(pool)

    Return 0
End
