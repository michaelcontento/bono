Strict

Private

Import bono
Import mojo.graphics

Public

Class Ellipse Extends BaseShape
    Method New()
        Throw New InvalidConstructorException("use New(Float, Float)")
    End

    Method New(radiusX:Float, radiusY:Float)
        SetSize(New Vector2D(radiusX * 2, radiusY * 2))
    End

    Method radiusX:Float() Property
        Return GetSize().x / 2
    End

    Method radiusX:Void(newRadiusX:Float) Property
        GetSize().x = newRadiusX * 2
    End

    Method radiusY:Float() Property
        Return GetSize().y / 2
    End

    Method radiusY:Void(newRadiusY:Float) Property
        GetSize().y = newRadiusY * 2
    End

    Method OnRenderShape:Void()
        Translate(radiusX, radiusY)
        DrawEllipse(0, 0, radiusX, radiusY)
    End
End
