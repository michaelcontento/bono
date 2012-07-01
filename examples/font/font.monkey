Strict

Import mojo.graphics
Import bono

Function Main:Int()
    Local font:Font = New Font("angel_verdana", New Vector2D(320, 240))
    font.text = "Hello World"
    font.align = Font.RIGHT
    font.color = New Color(255, 0, 0, 0.5)

    Local director:Director = New Director(640, 480)
    director.Run(font)

    Return 0
End
