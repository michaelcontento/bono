Strict

Private

Import mojo.graphics
Import vector2d

Public

Class MatrixHelper Abstract
    Private

    Global matrix:Float[] = [0.0, 0.0, 0.0, 0.0, 0.0, 0.0]

    Public

    Function SetScissorScaled:Void(x:Float, y:Float, width:Float, height:Float)
        Local scale:Vector2D = GetScale()
        graphics.SetScissor(x * scale.x, y * scale.y, width * scale.x, height * scale.y)
    End

    Function SetScissorScaled:Void(pos:Vector2D, size:Vector2D)
        SetScissorScaled(pos.x, pos.y, size.x, size.y)
    End

    Function SetScissor:Void(pos:Vector2D, size:Vector2D)
        graphics.SetScissor(pos.x, pos.y, size.x, size.y)
    End

    Function Scale:Void(size:Vector2D)
        graphics.Scale(size.x, size.y)
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
