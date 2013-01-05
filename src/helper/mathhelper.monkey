Strict

Public

Class MathHelper Abstract
    Private

    Const HEX_CHARS:String = "0123456789ABCDEF"

    Public

    Function Round:Int(given:Float)
        If given > 0.5 Then Return Ceil(given)
        Return Floor(given)
    End

    Function ModF:Float(left:Float, right:Float)
        Return left - right * Floor(left / right)
    End

    Function ModI:Int(left:Int, right:Int)
        Return left Mod right
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
