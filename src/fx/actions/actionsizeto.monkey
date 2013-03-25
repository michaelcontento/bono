Strict

Private

Import bono

Public

Class ActionSizeTo Extends BaseAction
    Private

    Field obj:Sizeable
    Field endSize := New Vector2D()
    Field startSize := New Vector2D()
    Field distance := New Vector2D()
    Field currentSize := New Vector2D()

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Sizeable, Vector2D)")
    End

    Method New(obj:Sizeable, size:Vector2D)
        Self.obj = obj
        Self.endSize.Set(size)
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        startSize.Set(obj.GetSize())
        distance.Set(endSize).Sub(startSize)
    End

    Method OnActionUpdate:Void(progress:Float)
        currentSize.Set(distance).Mul(progress).Add(startSize)
        obj.GetSize().Set(currentSize)
    End
End
