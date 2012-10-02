Strict

Private

Import bono.utils
Import color
Import colorable
Import positionable
Import sizeable

Public

Class BaseDisplayObject Implements Colorable, Positionable, Sizeable Abstract
    Private

    Field _color:Color
    Field _pos:Vector2D
    Field _size:Vector2D
    Field _center:Vector2D

    Public

    ' --- Colorable
    Method color:Void(color:Color) Property
        _color = color
    End

    Method color:Color() Property
        If Not _color Then _color = New Color()
        Return _color
    End

    ' --- Positionable
    Method pos:Vector2D() Property
        If _pos = Null Then Error("Position not set yet.")
        Return _pos
    End

    Method pos:Void(newPos:Vector2D) Property
        _pos = newPos
    End

    ' --- Sizeable
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
End
