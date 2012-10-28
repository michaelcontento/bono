Strict

Import bono

Function Main:Int()
    Local appEmitter:AppEmitter = New AppEmitter()

    Local text:Text = New Text("angel_verdana", New Vector2D(320, 240))
    text.text = "Hello World"
    text.halign = Align.RIGHT
    text.SetColor(New Color(255, 0, 0, 0.5))
    appEmitter.AddObserver(text)

    Return 0
End
