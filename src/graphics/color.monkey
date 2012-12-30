Strict

Private

Import mojo.graphics

Public

Class Color
    Private

    Field oldColor:Color
    Field _red:Float
    Field _green:Float
    Field _blue:Float
    Field _alpha:Float

    Public

    Const MIN:Float = 0.0
    Const MAX:Float = 255.0

    Method New(red:Float=MAX, green:Float=MAX, blue:Float=MAX, alpha:Float=MAX)
        Self._red = red
        Self._green = green
        Self._blue = blue
        Self._alpha = alpha
        UpdateBounds()
    End

    Method Reset:Void()
        _red = MAX
        _green = MAX
        _blue = MAX
        _alpha = MAX
    End

    Method Randomize:Void()
        _red = MAX * Rnd()
        _green = MAX * Rnd()
        _blue = MAX * Rnd()
        _alpha = MAX * Rnd()
    End

    Method Activate:Void()
        If Not oldColor Then oldColor = New Color(MIN, MIN, MIN, MIN)

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
        Return New Color(_red, _green, _blue, _alpha)
    End

    Method Equals:Bool(color:Color)
        If Not (color.red = _red) Then Return False
        If Not (color.green = _green) Then Return False
        If Not (color.blue = _blue) Then Return False
        If Not (color.alpha = _alpha) Then Return False
        Return True
    End

    Method ToString:String()
        Return "(Red: " + _red + " Green: " + _green + " Blue: " + _blue + " Alpha: " + alphaFloat + ")"
    End

    Method red:Float() Property
        Return _red
    End

    Method red:Void(value:Float) Property
        _red = value
        UpdateBounds()
    End

    Method redFloat:Float() Property
        Return _red / MAX
    End

    Method redFloat:Void(value:Float) Property
        _red = MAX * value
        UpdateBounds()
    End

    Method green:Float() Property
        Return _green
    End

    Method green:Void(value:Float) Property
        _green = value
        UpdateBounds()
    End

    Method greenFloat:Float() Property
        Return _green / MAX
    End

    Method greenFloat:Void(value:Float) Property
        _green = MAX * value
        UpdateBounds()
    End

    Method blue:Float() Property
        Return _blue
    End

    Method blue:Void(value:Float) Property
        _blue = value
        UpdateBounds()
    End

    Method blueFloat:Float() Property
        Return _blue / MAX
    End

    Method blueFloat:Void(value:Float) Property
        _blue = MAX * value
        UpdateBounds()
    End

    Method alpha:Float() Property
        Return _alpha
    End

    Method alpha:Void(value:Float) Property
        _alpha = value
        UpdateBounds()
    End

    Method alphaFloat:Float() Property
        Return _alpha / MAX
    End

    Method alphaFloat:Void(value:Float) Property
        _alpha = MAX * value
        UpdateBounds()
    End

    Private

    Method UpdateBounds:Void()
        _red = Clamp(_red, MIN, MAX)
        _green = Clamp(_green, MIN, MAX)
        _blue = Clamp(_blue, MIN, MAX)
        _alpha = Clamp(_alpha, MIN, MAX)
    End

    Method Set:Void(color:Color)
        SetColor(color.red, color.green, color.blue)
        SetAlpha(color.alphaFloat)
    End
End
