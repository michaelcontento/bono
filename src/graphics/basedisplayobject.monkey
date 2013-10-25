Strict

Private

Import bono

Public

Class BaseDisplayObject Implements Colorable, Positionable, Sizeable, Alignable Abstract
    Private

    Field color:Color
    Field pos:Vector2D
    Field size:Vector2D
    Field align:Int = Align.TOP | Align.LEFT
    Field tmpPos := New Vector2D()

    Public

    Method Collide:Bool(checkPos:Vector2D)
        tmpPos.Reset()
        Align.Align(tmpPos, Self, align)
        tmpPos.Revert().Add(checkPos)

        If tmpPos.x < GetPosition().x Or tmpPos.x > GetPosition().x + GetSize().x Then Return False
        If tmpPos.y < GetPosition().y Or tmpPos.y > GetPosition().y + GetSize().y Then Return False
        Return True
    End

    Function Copy:Void(from:BaseDisplayObject, dst:BaseDisplayObject)
        dst.SetAlignment(from.GetAlignment())
        dst.SetColor(from.GetColor().Copy())
        dst.SetPosition(from.GetPosition().Copy())
        dst.SetSize(from.GetSize().Copy())
    End

    ' --- Alignable
    Method SetAlignment:Void(align:Int)
        Self.align = align
    End

    Method GetAlignment:Int()
        Return align
    End

    ' --- Colorable
    Method SetColor:Void(newColor:Color)
        color = newColor
    End

    Method GetColor:Color()
        If Not color Then color = New Color()
        Return color
    End

    Method HasColor:Bool()
        Return (Not (Not color))
    End

    ' --- Positionable
    Method GetPosition:Vector2D()
        If pos = Null Then pos = New Vector2D(0, 0)
        Return pos
    End

    Method SetPosition:Void(newPos:Vector2D)
        pos = newPos
    End

    ' --- Sizeable
    Method GetSize:Vector2D()
        If size = Null Then Error("Size not set yet.")
        Return size
    End

    Method SetSize:Void(newSize:Vector2D)
        size = newSize
    End
End
