Strict

Private

Import bono.src.kernel
Import color
Import mojo.graphics

Public

Class ClearScene Implements Renderable
    Private

    Field color:Color

    Public

    Method New(color:Color=New Color())
        Self.color = color
    End

    Method OnRender:Void()
        Cls(color.red, color.green, color.blue)
    End
End
