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

Function Add:Void(pool:FanOut, text:String, effect:Fader, transition:Transition)
    Local duration:Float = Ceil(8000 * Rnd())
    Local fader:Animation = New Animation(0, 1, duration)
    fader.effect = effect
    fader.transition = transition
    fader.Add(New Text(text + " (" + (duration / 1000) + " sec)"))

    pool.Add(fader)
End

Function Main:Int()
    Local pool:FanOut = New FanOut()
    Add(pool, "Alpha InQuad", New FaderAlpha(), New TransitionInQuad())
    Add(pool, "Alpha OutQuad", New FaderAlpha(), New TransitionOutQuad())
    Add(pool, "Alpha InCubic", New FaderAlpha(), New TransitionInCubic())
    Add(pool, "Alpha OutCubic", New FaderAlpha(), New TransitionOutCubic())
    Add(pool, "Alpha InOutCubic", New FaderAlpha(), New TransitionInOutCubic())
    Add(pool, "Alpha InQuart", New FaderAlpha(), New TransitionInQuart())
    Add(pool, "Alpha OutQuart", New FaderAlpha(), New TransitionOutQuart())
    Add(pool, "Alpha InOutQuart", New FaderAlpha(), New TransitionInOutQuart())
    Add(pool, "Alpha InSine", New FaderAlpha(), New TransitionInSine())
    Add(pool, "Alpha OutSine", New FaderAlpha(), New TransitionOutSine())
    Add(pool, "Alpha InOutSine", New FaderAlpha(), New TransitionInOutSine())
    Add(pool, "Alpha InExpo", New FaderAlpha(), New TransitionInExpo())
    Add(pool, "Alpha OutExpo", New FaderAlpha(), New TransitionOutExpo())
    Add(pool, "Alpha InOutExpo", New FaderAlpha(), New TransitionInOutExpo())
    Add(pool, "Alpha InCirc", New FaderAlpha(), New TransitionInCirc())
    Add(pool, "Alpha OutCirc", New FaderAlpha(), New TransitionOutCirc())
    Add(pool, "Alpha InOutCirc", New FaderAlpha(), New TransitionInOutCirc())
    Add(pool, "Alpha InElastic", New FaderAlpha(), New TransitionInElastic())
    Add(pool, "Alpha OutElastic", New FaderAlpha(), New TransitionOutElastic())
    Add(pool, "Alpha InOutElastic", New FaderAlpha(), New TransitionInOutElastic())
    Add(pool, "Alpha InBack", New FaderAlpha(), New TransitionInBack())
    Add(pool, "Alpha OutBack", New FaderAlpha(), New TransitionOutBack())
    Add(pool, "Alpha InOutBack", New FaderAlpha(), New TransitionInOutBack())
    Add(pool, "Alpha InBounce", New FaderAlpha(), New TransitionInBounce())
    Add(pool, "Alpha OutBounce", New FaderAlpha(), New TransitionOutBounce())
    Add(pool, "Alpha InOutBounce", New FaderAlpha(), New TransitionInOutBounce())
    Add(pool, "Alpha InOutBack", New FaderAlpha(), New TransitionInOutBack())

    Local director:Director = New Director(640, 480)
    director.Run(pool)

    Return 0
End
