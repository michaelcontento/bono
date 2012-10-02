Strict

Import bono

Function Main:Int()
    Local text:Text = New Text("angel_verdana", New Vector2D(320, 240))
    text.text = "Hello World"
    text.align = Text.ALIGN_RIGHT
    text.color = New Color(255, 0, 0, 0.5)

    Local appEmitter:AppEmitter = New AppEmitter()
    appEmitter.AddObserver(text)
    appEmitter.Run()

    Return 0
End
