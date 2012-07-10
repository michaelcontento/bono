Strict

Class KeyEvent
    Private

    Field _code:Int
    Field _char:String

    Public

    Method New(code:Int)
        _code = code
        _char = String.FromChar(_code)
    End

    Method code:Int() Property
        Return _code
    End

    Method char:String() Property
        Return _char
    End
End
