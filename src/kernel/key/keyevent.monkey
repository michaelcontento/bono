Strict

Class KeyEvent
    Private

    Field _code:Int
    Field _char:String

    Public

    Method New(code:Int)
        Self.code = code
    End

    Method code:Void(newCode:Int) Property
        _code = newCode
        _char = String.FromChar(newCode)
    End

    Method code:Int() Property
        Return _code
    End

    Method char:String() Property
        Return _char
    End
End
