Strict

Public

Class MathHelper Abstract
    Function Round:Int(given:Float)
        If given > 0.5 Then Return Floor(given)
        Return Ceil(given)
    End
End
