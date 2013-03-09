Strict

Private

Import bono
Import mojo.graphics

Public

Class Rect Extends BaseShape
    Method New()
        Throw New InvalidConstructorException("use New(Vector2D)")
    End

    Method New(size:Vector2D)
        SetSize(size)
    End

    Method OnRenderShape:Void()
        DrawRect(0, 0, GetSize().x, GetSize().y)
    End
End
