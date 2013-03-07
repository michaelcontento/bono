Strict

Private

Import bono
Import mojo.graphics

Public

Class MatrixHelper Abstract
    Private

    Global matrix:Float[] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

    Public

    Const AXIS_BOTH:Int = 0
    Const AXIS_X:Int = 1
    Const AXIS_Y:Int = 2

    Function SetScissorRelative:Void(x:Float, y:Float, width:Float, height:Float)
        Local scale:Vector2D = GetScale()
        Local translate:Vector2D = GetTranslate()

        graphics.SetScissor(
            (scale.x * x) + translate.x,
            (scale.y * y) + translate.y,
            scale.x * width,
            scale.y * height)
    End

    Function SetScissorRelative:Void(pos:Vector2D, size:Vector2D)
        SetScissorRelative(pos.x, pos.y, size.x, size.y)
    End

    Function SetScissor:Void(pos:Vector2D, size:Vector2D)
        graphics.SetScissor(pos.x, pos.y, size.x, size.y)
    End

    Function Scale:Void(size:Vector2D)
        graphics.Scale(size.x, size.y)
    End

    Function PushMatrixReset:Void(axis:Int=AXIS_BOTH)
        ' TODO: Reset all other properties (scale, ..) too
        Local newScale := New Vector2D(1, 1)
        newScale.Div(MatrixHelper.GetScale())

        Select axis
        Case AXIS_X
            newScale.y = 1.0
        Case AXIS_Y
            newScale.x = 1.0
        End

        PushMatrix()
        MatrixHelper.Scale(newScale)
    End

    Function Translate:Void(offset:Vector2D)
        graphics.Translate(offset.x, offset.y)
    End

    Function GetTranslate:Vector2D()
        GetMatrix(matrix)
        Return New Vector2D(matrix[4], matrix[5])
    End

    Function GetScale:Vector2D()
        GetMatrix(matrix)
        Return New Vector2D(matrix[0], matrix[3])
    End
End
