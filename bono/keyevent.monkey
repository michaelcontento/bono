Strict

Private

Import mojo

Public

Class KeyEvent
    Private

    Field _code:Int

    Public

    Method New(code:Int)
        _code = code
    End

    Method code:Int() Property
        Return _code
    End
End
