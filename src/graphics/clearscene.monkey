Strict

Private

Import bono
Import mojo.graphics

Public

Class ClearScene Implements Renderable, Colorable
    Private

    Field color:Color

    Public

    Method New(color:Color=New Color())
        SetColor(color)
    End

    Method OnRender:Void()
        Cls(color.red, color.green, color.blue)
    End

    Method SetColor:Void(color:Color)
        Self.color = color
    End

    Method GetColor:Color()
        Return color
    End
End
