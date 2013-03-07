Strict

Private

Import bono

Public

Class ActionMoveTo Extends BaseAction
    Private

    Field obj:Positionable
    Field endPos := New Vector2D()
    Field startPos := New Vector2D()
    Field distance := New Vector2D()
    Field currentPos := New Vector2D()

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Positionable, Vector2D)")
    End

    Method New(obj:Positionable, pos:Vector2D)
        Self.obj = obj
        Self.endPos.Set(pos)
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        startPos.Set(obj.GetPosition())
        distance.Set(endPos).Sub(startPos)
    End

    Method OnActionUpdate:Void(progress:Float)
        currentPos.Set(distance).Mul(progress).Add(startPos)
        obj.GetPosition().Set(currentPos)
    End
End
