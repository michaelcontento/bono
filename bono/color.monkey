Strict

Private

Import mojo.graphics

Public

Class Color
    Private

    Field oldColor:Color

    Public

    Field red:Float
    Field green:Float
    Field blue:Float
    Field alpha:Float

    Method New(red:Float=255, green:Float=255, blue:Float=255, alpha:Float=1)
        Self.red = red
        Self.green = green
        Self.blue = blue
        Self.alpha = alpha
    End

    Method Activate:Void()
        If Not oldColor Then oldColor = New Color(0, 0, 0, 0)

        Local colorStack:Float[] = GetColor()
        oldColor.red = colorStack[0]
        oldColor.green = colorStack[1]
        oldColor.blue = colorStack[2]
        oldColor.alpha = GetAlpha()

        Set(Self)
    End

    Method Deactivate:Void()
        If oldColor Then Set(oldColor)
    End

    Private

    Method Set:Void(color:Color)
        SetColor(color.red, color.green, color.blue)
        SetAlpha(color.alpha)
    End
End
