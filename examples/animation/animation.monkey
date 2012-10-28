Strict

Import bono

Function Main:Int()
    Local appEmitter:AppEmitter = New AppEmitter()

    Local text:Text = New Text("angel_verdana", New Vector2D(200, 100))
    text.text = "Hello World"
    appEmitter.AddObserver(text)

    Local logo:Sprite = New Sprite("monkey64.png")
    appEmitter.AddObserver(logo)

    Local effect:EffectColorAlpha = New EffectColorAlpha(0, 1)
    effect.AddLast(text)
    effect.AddLast(logo)

    Local anim:Animation = New Animation(5000, New TransitionInOutQuad())
    anim.AddLast(effect)
    anim.Start()
    appEmitter.AddObserver(anim)

    Return 0
End
