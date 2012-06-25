Strict

Private

Import bono

Public

Class Positionable Implements Renderable Abstract
    Field _pos:Vector2D
    Field _center:Vector2D
    Field _size:Vector2D

    Method pos:Vector2D() Property
        If _pos = Null Then Error("Position not set yet.")
        Return _pos
    End

    Method pos:Void(newPos:Vector2D) Property
        _pos = newPos
    End

    Method size:Vector2D() Property
        If _size = Null Then Error("Size not set yet.")
        Return _size
    End

    Method size:Void(newSize:Vector2D) Property
        _size = newSize
        _center = newSize.Copy().Div(2)
    End

    Method center:Vector2D() Property
        If _center = Null Then Error("No size set and center therefore unset.")
        Return _center
    End

    Method OnRender:Void() Abstract
    Method OnUpdate:Void() Abstract
End
