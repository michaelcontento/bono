Strict

Private

Import bono

Public

Class ActionScale Extends BaseAction
    Private

    Field obj:Sprite
    Field scale := New Vector2D()
    Field scaleToAdd := New Vector2D()
    Field scaleAlreadyApplied := New Vector2D()

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Sprite, Vector2D)")
    End

    Method New(obj:Sprite, scale:Vector2D)
        Self.obj = obj
        Self.scale.Set(scale)
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        scaleAlreadyApplied.Reset()
    End

    Method OnActionUpdate:Void(progress:Float)
        scaleToAdd.Set(scale).Mul(progress).Sub(scaleAlreadyApplied)

        scaleAlreadyApplied.Add(scaleToAdd)
        obj.scale.Add(scaleToAdd)
    End
End
