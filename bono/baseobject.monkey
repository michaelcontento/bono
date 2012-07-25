Strict

Private

Import color
Import colorable
Import partial
Import positionable
Import sizeable
Import vector2d

Public

Class BaseObject Extends Partial Implements Positionable, Sizeable, Colorable Abstract
    Private

    Field _pos:Vector2D
    Field _center:Vector2D
    Field _size:Vector2D
    Field _color:Color

    Public

    Method CenterX:Void(entity:Sizeable)
        pos.x = entity.center.x - center.x
    End

    Method CenterY:Void(entity:Sizeable)
        pos.y = entity.center.y - center.y
    End

    Method Center:Void(entity:Sizeable)
        pos = entity.center.Copy().Sub(center)
    End

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

    Method color:Void(color:Color) Property
        _color = color
    End

    Method color:Color() Property
        If Not _color Then _color = New Color()
        Return _color
    End
End
