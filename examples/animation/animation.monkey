Strict

Import mojo.graphics
Import bono

Function Main:Int()
    Local director:Director = New Director(640, 480)

    Local text:Text = New Text("angel_verdana", New Vector2D(200, 100))
    text.text = "Hello World"

    Local logo:Sprite = New Sprite("monkey64.png")
    logo.OnCreate(director)
    logo.pos = director.size.Copy().Sub(logo.size)

    Local effect:EffectColorAlpha = New EffectColorAlpha(0, 1)
    effect.AddLast(text)
    effect.AddLast(logo)

    Local anim:Animation = New Animation(5000, New TransitionInOutQuad())
    anim.AddLast(effect)
    anim.Start()

    Local pool:FanOut = New FanOut()
    pool.Add(anim.ToDirectorEvents())
    pool.Add(logo)
    pool.Add(text)

    director.Run(pool)
    Return 0
End
