Strict

Public

Class MathHelper Abstract
    Private

    Const HEX_CHARS:String = "0123456789ABCDEF"

    Public

    ' http://msdn.microsoft.com/en-us/library/4hwaceh6(v=vs.80).aspx
    Const E:Float = 2.718281828459045
    Const LOG2E:Float = 1.44269504088896340736
    Const LOG10E:Float = 0.434294481903251827651
    Const LN2:Float = 0.693147180559945309417
    Const LN10:Float = 2.30258509299404568402
    Const PI:Float = 3.14159265358979323846
    Const PI_2:Float = 1.57079632679489661923
    Const PI_4:Float = 0.785398163397448309616
    Const _1_PI:Float = 0.318309886183790671538
    Const _2_PI:Float = 0.636619772367581343076
    Const _2_SQRTPI:Float = 1.12837916709551257390
    Const SQRT2:Float = 1.4142135623730951
    Const SQRT1_2:Float = 0.707106781186547524401

    Function Round:Int(given:Float)
        If (given - Int(given)) >= 0.5 Then Return Ceil(given)
        Return Floor(given)
    End

    Function ModF:Float(left:Float, right:Float)
        Return left - right * Floor(left / right)
    End

    Function HexToInt:Int(hex:String)
        Local result:Int
        Local hexLen:Int = hex.Length() - 1
        hex = hex.ToUpper()

        For Local i:Int = 0 To hexLen
            If hex[i] >= 48 And hex[i] <= 57
                result += (hex[i] - 48) * Pow(16, hexLen - i)
            Else
                result += (hex[i] - 55) * Pow(16, hexLen - i)
            End
        End

        Return result
    End

    Function IntToHex:String(value:Int)
        If value < 9 Then Return "" + value

        Local result:String

        While value > 0
            result = String.FromChar(HEX_CHARS[(value Mod 16)]) + result
            value /= 16
        End

        Return result
    End
End
