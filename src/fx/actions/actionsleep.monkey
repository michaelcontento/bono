Strict

Private

Import bono

Public

Class ActionSleep Extends BaseAction
    Method New()
        Throw New InvalidConstructorException("use New(Float)")
    End

    Method New(duration:Float)
        SetDuration(duration)
    End

    Method OnActionUpdate:Void(progress:Float)
    End
End
