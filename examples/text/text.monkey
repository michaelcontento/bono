Strict

Import mojo.graphics
Import bono

Function Main:Int()
    Local text:Text = New Text("angel_verdana", New Vector2D(320, 240))
    text.text = "Hello World"
    text.align = Text.ALIGN_RIGHT
    text.color = New Color(255, 0, 0, 0.5)

    Local director:Director = New Director(640, 480)
    director.Run(text)

    Return 0
End
