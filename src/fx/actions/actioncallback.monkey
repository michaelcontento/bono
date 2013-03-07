Strict

Private

Import bono

Public

Class ActionCallback Extends BaseAction
    Private

    Field obj:Object
    Field name:String
    Field cb:ActionsCallback

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Object, String, ActionCallback)")
    End

    Method New(obj:Object, name:String, cb:ActionsCallback)
        Self.obj = obj
        Self.name = name
        Self.cb = cb
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        cb.OnActionCallback(obj, name)
    End

    Method OnActionUpdate:Void(progress:Float)
    End
End
