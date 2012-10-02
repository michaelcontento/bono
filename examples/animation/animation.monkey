Strict

Import bono

Function Main:Int()
    Local text:Text = New Text("angel_verdana", New Vector2D(200, 100))
    text.text = "Hello World"

    Local logo:Sprite = New Sprite("monkey64.png")

    Local effect:EffectColorAlpha = New EffectColorAlpha(0, 1)
    effect.AddLast(text)
    effect.AddLast(logo)

    Local anim:Animation = New Animation(5000, New TransitionInOutQuad())
    anim.AddLast(effect)
    anim.Start()

    Local appEmitter:AppEmitter = New AppEmitter()
    appEmitter.AddObserver(text)
    appEmitter.AddObserver(logo)
    appEmitter.AddObserver(anim)
    appEmitter.Run()

    Return 0
End
