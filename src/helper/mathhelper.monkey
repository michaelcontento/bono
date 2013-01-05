Strict

Public

Class MathHelper Abstract
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
End
