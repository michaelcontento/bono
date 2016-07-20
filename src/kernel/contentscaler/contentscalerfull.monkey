Strict

Private

Import bono

Public

Class ContentScalerFull Implements ContentScaler
    Private

    Field scaleVec:Vector2D

    Public

    Method TranslateSpace:Vector2D(app:BonoApp, vec:Vector2D)
        InitScaleVector(app)
        Return vec.Div(scaleVec)
    End

    Method OnRenderPre:Void(app:BonoApp)
        InitScaleVector(app)
        MatrixHelper.Scale(scaleVec)
    End

    Method OnRenderPost:Void(app:BonoApp)
    End

    Private

    Method InitScaleVector:Void(app:BonoApp)
        If Not scaleVec
            scaleVec = Device.GetSize().Div(app.GetVirtualSize())
        End
    End
End
