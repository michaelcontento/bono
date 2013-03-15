Strict

Private

Import bono
Import mojo

Public

Class RectTest Extends AppTestCase
    Method TestInheritsBaseShape:Void()
        AssertNotNull(BaseShape(New Rect(New Vector2D(10, 10))))
    End

    Method TestRenderColorized:Void()
        Local rect := New Rect(New Vector2D(10, 10))

        rect.GetColor().Set("#ff0000")
        RenderRect(rect)
        AssertScreenEquals("graphics/shapes/rect-01.png")

        rect.GetColor().Set("#00ff00")
        RenderRect(rect)
        AssertScreenEquals("graphics/shapes/rect-02.png")

        rect.GetColor().Set("#0000ff")
        RenderRect(rect)
        AssertScreenEquals("graphics/shapes/rect-03.png")
    End

    Method TestRenderSizes:Void()
        Local rect := New Rect(New Vector2D())
        rect.GetColor().Set("#ff0000")

        rect.GetSize().Set(10, 10)
        RenderRect(rect)
        AssertScreenEquals("graphics/shapes/rect-10.png")

        rect.GetSize().Set(15, 10)
        RenderRect(rect)
        AssertScreenEquals("graphics/shapes/rect-11.png")

        rect.GetSize().Set(10, 15)
        RenderRect(rect)
        AssertScreenEquals("graphics/shapes/rect-12.png")

        rect.GetSize().Set(15, 15)
        RenderRect(rect)
        AssertScreenEquals("graphics/shapes/rect-13.png")
    End

    Method RenderRect:Void(rect:Rect)
        Cls()
        rect.OnRender()
    End
End
