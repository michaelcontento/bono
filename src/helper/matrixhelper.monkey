Strict

Private

Import bono
Import mojo.graphics

Public

Class MatrixHelper Abstract
    Private

    Global matrix:Float[] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]
    Global newScale := New Vector2D()

    Public

    Const AXIS_X:Int = 1
    Const AXIS_Y:Int = 2
    Const AXIS_BOTH:Int = AXIS_X | AXIS_Y

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

    Function Translate:Void(offset:Vector2D)
        graphics.Translate(offset.x, offset.y)
    End

    Function GetTranslate:Vector2D()
        GetMatrix(matrix)
        Return New Vector2D(matrix[4], matrix[5])
    End

    Function Scale:Void(size:Vector2D)
        graphics.Scale(size.x, size.y)
    End

    Function GetScale:Vector2D()
        GetMatrix(matrix)
        Return New Vector2D(matrix[0], matrix[3])
    End

    Function PushMatrixResetScale:Void(axis:Int=AXIS_BOTH)
        newScale.Set(1, 1).Div(MatrixHelper.GetScale())

        If axis & AXIS_X Then newScale.y = 1.0
        If axis & AXIS_Y Then newScale.x = 1.0

        PushMatrix()
        MatrixHelper.Scale(newScale)
    End
End
