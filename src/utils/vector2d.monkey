Strict

Private

Import bono

Public

Class Vector2D
    Field x:Float
    Field y:Float

    Method New(x:Float=0, y:Float=0)
        Self.x = x
        Self.y = y
    End

    Method IsZero:Bool()
        Return (x = 0 And y = 0)
    End

    Method Length:Float()
        Return Sqrt(x * x + y * y)
    End

    Method DotProduct:Float(v2:Vector2D)
        Return (x * v2.x) + (y * v2.y)
    End

    Method CrossProduct:Float(v2:Vector2D)
        Return (x * v2.y) - (y * v2.x)
    End

    Method Distance:Float(v2:Vector2D)
        Return Sqrt(Pow(v2.x - x, 2.0) + Pow(v2.y - y, 2.0))
    End

    Method Equal:Bool(v2:Vector2D)
        Return (x = v2.x And y = v2.y)
    End

    Method Copy:Vector2D()
        Return New Vector2D(x, y)
    End

    Method Reset:Vector2D()
        x = 0
        y = 0

        Return Self
    End

    Method Round:Vector2D()
        x = MathHelper.Round(x)
        y = MathHelper.Round(y)

        Return Self
    End

    Method Ceil:Vector2D()
        x = monkey.Ceil(x)
        y = monkey.Ceil(y)

        Return Self
    End

    Method Floor:Vector2D()
        x = monkey.Floor(x)
        y = monkey.Floor(y)

        Return Self
    End

    Method Set:Vector2D(v2:Vector2D)
        x = v2.x
        y = v2.y

        Return Self
    End

    Method Normalize:Vector2D()
        Local length:Float = Length()
        If length = 0 Then Return Self

        x /= length
        y /= length

        Return Self
    End

    Method Rotate:Vector2D(angle:Float)
        Local tmpX:Float = (x * Cos(angle)) - (y * Sin(angle))
        Local tmpY:Float = (y * Cos(angle)) - (x * Sin(angle))

        x = tmpX
        y = tmpY

        Return Self
    End

    Method Revert:Vector2D()
        x *= -1
        y *= -1

        Return Self
    End

    Method Add:Vector2D(x:Float, y:Float)
        Self.x += x
        Self.y += y
        Return Self
    End

    Method Add:Vector2D(v2:Vector2D)
        x += v2.x
        y += v2.y
        Return Self
    End

    Method Add:Vector2D(factor:Float)
        x += factor
        y += factor
        Return Self
    End

    Method Sub:Vector2D(x:Float, y:Float)
        Self.x -= x
        Self.y -= y
        Return Self
    End

    Method Sub:Vector2D(v2:Vector2D)
        x -= v2.x
        y -= v2.y
        Return Self
    End

    Method Sub:Vector2D(factor:Float)
        x -= factor
        y -= factor
        Return Self
    End

    Method Mul:Vector2D(v2:Vector2D)
        x *= v2.x
        y *= v2.y
        Return Self
    End

    Method Mul:Vector2D(factor:Float)
        x *= factor
        y *= factor
        Return Self
    End

    Method Div:Vector2D(v2:Vector2D)
        If v2.x = 0 Or v2.y = 0
            Throw New InvalidArgumentException("Division by zero: " + v2)
        End

        x /= v2.x
        y /= v2.y
        Return Self
    End

    Method Div:Vector2D(factor:Float)
        If factor = 0
            Throw New InvalidArgumentException("Division by zero")
        End

        y /= factor
        x /= factor
        Return Self
    End

    Method ToString:String()
        Return "(" + x + ", " + y + ")"
    End
End
