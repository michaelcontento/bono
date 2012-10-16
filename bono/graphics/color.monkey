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
    Field _alpha:Float

    Method New(red:Float=255, green:Float=255, blue:Float=255, alpha:Float=1)
        Self.red = red
        Self.green = green
        Self.blue = blue
        Self.alpha = alpha
    End

    Method Reset:Void()
        red = 255
        green = 255
        blue = 255
        alpha = 1.0
    End

    Method Randomize:Void()
        red = 255 * Rnd()
        green = 255 * Rnd()
        blue = 255 * Rnd()
        alpha = Rnd()
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
        If Not oldColor Then Return
        Set(oldColor)
        oldColor = Null
    End

    Method Copy:Color()
        Return New Color(red, green, blue, alpha)
    End

    Method alpha:Void(alpha:Int) Property
        _alpha = alpha
        If _alpha > 1 Then _alpha = 1 / 255 * _alpha
    End

    Method alpha:Void(alpha:Float) Property
        _alpha = alpha
        If _alpha > 1 Then _alpha = 1 / 255 * _alpha
    End

    Method alpha:Float() Property
        Return _alpha
    End

    Private

    Method Set:Void(color:Color)
        SetColor(color.red, color.green, color.blue)
        SetAlpha(color.alpha)
    End
End
