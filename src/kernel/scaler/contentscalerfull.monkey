Strict

Private

Import bono

Public

Class ContentScalerFull Implements ContentScaler
    Private

    Field scaleVec:Vector2D

    Public

    Method TranslateSpace:Vector2D(app:App, vec:Vector2D)
        InitScaleVector(app)
        Return vec.Copy().Div(scaleVec)
    End

    Method OnRenderPre:Void(app:App)
        InitScaleVector(app)
        MatrixHelper.Scale(scaleVec)
    End

    Method OnRenderPost:Void(app:App)
    End

    Private

    Method InitScaleVector:Void(app:App)
        If Not scaleVec
            scaleVec = Device.GetSize().Div(app.GetVirtualSize())
        End
    End
End
