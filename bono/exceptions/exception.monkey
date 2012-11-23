Strict

Public

Class Exception Extends Throwable
    Private

    Field message:String

    Public

    Method New(message:String)
        Self.message = message
    End

    Method ToString:String()
        Return message
    End
End
