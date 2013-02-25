Strict

Private

Import bono

Public

Class ActionMoveTo Extends BaseAction
    Private

    Field endPos:Vector2D
    Field startPos:Vector2D
    Field distance:Vector2D
    Field obj:Positionable

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Positionable, Vector2D)")
    End

    Method New(obj:Positionable, pos:Vector2D)
        Self.obj = obj
        Self.endPos = pos
    End

    Method OnActionStart:Void()
        Super.OnActionStart()

        startPos = obj.GetPosition().Copy()
        distance = endPos.Copy().Sub(startPos)
    End

    Method OnActionUpdate:Void(progress:Float)
        obj.GetPosition().Set(startPos.Copy().Add(distance.Copy().Mul(progress)))
    End
End
