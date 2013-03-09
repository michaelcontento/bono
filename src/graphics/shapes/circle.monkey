Strict

Private

Import bono
Import mojo.graphics

Public

Class Circle Extends BaseShape
    Method New()
        Throw New InvalidConstructorException("use New(Float)")
    End

    Method New(radius:Float)
        SetSize(New Vector2D(radius * 2, radius * 2))
    End

    Method radius:Float() Property
        Return GetSize().x / 2
    End

    Method radius:Void(newRadius:Float) Property
        GetSize().Set(newRadius * 2, newRadius * 2)
    End

    Method OnRenderShape:Void()
        Translate(radius, radius)
        DrawCircle(0, 0, radius)
    End
End
