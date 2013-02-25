Strict

Private

Import bono

Public

Class ActionRotate Extends BaseAction
    Private

    Field obj:Rotateable
    Field endAngel:Float
    Field startAngel:Float

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Rotateable, Float)")
    End

    Method New(obj:Rotateable, angel:Float)
        Self.obj = obj
        Self.endAngel = angel
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        startAngel = obj.GetRotation()
    End

    Method OnActionUpdate:Void(progress:Float)
        obj.SetRotation(startAngel + (endAngel * progress))
    End
End
