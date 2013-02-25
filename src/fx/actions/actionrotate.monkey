Strict

Private

Import bono

Public

Class ActionRotate Extends BaseAction
    Private

    Field obj:Rotateable
    Field endRotation:Float
    Field startRotation:Float

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Rotateable, Float)")
    End

    Method New(obj:Rotateable, rotation:Float)
        Self.obj = obj
        Self.endRotation = rotation
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        startRotation = obj.GetRotation()
    End

    Method OnActionUpdate:Void(progress:Float)
        obj.SetRotation(startRotation + (endRotation * progress))
    End
End
