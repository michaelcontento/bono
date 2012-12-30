Strict

Private

Import bono.src.kernel
Import color
Import mojo.graphics

Public

Class ClearScene Implements Renderable
    Field color:Color

    Method New(color:Color=New Color())
        Self.color = color
    End

    Method OnRender:Void()
        If Not color Then Error("This should nerver happen")
        Cls(color.red, color.green, color.blue)
    End
End
