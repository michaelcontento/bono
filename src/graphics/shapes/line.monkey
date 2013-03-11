Strict

Private

Import bono
Import mojo.graphics

Public

Class Line Extends BaseShape
    Private

    Field delta:Vector2D
    Field oldSize := New Vector2D()
    Field oldRotation:Float
    Field oldAlignment:Int

    Public

    Field width:Float = 1

    Method New()
        Throw New InvalidConstructorException("use New(Vector2D)")
    End

    Method New(size:Vector2D)
        Self.delta = size
        SetSize(New Vector2D())
    End

    Method OnRender:Void()
        oldSize.Set(GetSize())
        oldRotation = GetRotation()
        oldAlignment = GetAlignment()

        GetSize().Set(delta).Abs()
        SetRotation(ATan2(GetSize().y, GetSize().x) * -1)
        If delta.x < 0 And (oldAlignment & Align.LEFT Or oldAlignment & Align.RIGHT)
            SetAlignment((GetAlignment() ~ Align.LEFT) ~ Align.RIGHT)
        End
        If delta.y < 0 And (oldAlignment & Align.TOP Or oldAlignment & Align.BOTTOM)
            SetAlignment((GetAlignment() ~ Align.TOP) ~ Align.BOTTOM)
        End

        Super.OnRender()

        GetSize().Set(oldSize)
        SetRotation(oldRotation)
        SetAlignment(oldAlignment)
    End

    Method OnRenderShape:Void()
        DrawRect(
            (GetSize().x - GetSize().Length()) / 2,
            (width / -2) + (GetSize().y / 2),
            delta.Length(),
            width)
    End
End
