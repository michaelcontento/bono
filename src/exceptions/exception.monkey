Strict

Private

#REFLECTION_FILTER="*exception"
Import reflection

Public

Class Exception Extends Throwable
    Private

    Field _message:String
    Field _classNameFull:String
    Field _className:String

    Public

    Method New(message:String)
        _message = message

        Local ci:ClassInfo = GetClass(Object(Self))
        If ci
            _classNameFull = ci.Name
            If _classNameFull.Contains(".")
                _className = _classNameFull[_classNameFull.FindLast(".") + 1..]
            End
        Else
            _classNameFull = "--UNKNOWN--"
            _className = _classNameFull
        End
    End

    Method ToString:String()
        Return "Uncaught exception '" + _className + "' with message:~n" +
            _message + "~n" +
            "~nStack trace:"
    End

    Method className:String() Property
        Return _className
    End

    Method classNameFull:String() Property
        Return _classNameFull
    End

    Method message:String() Property
        Return _message
    End
End
