Strict

Private

Import app
Import bono.src.helper
Import bono.src.utils
Import contentscaler

Public

Class ContentScalerFull Implements ContentScaler
    Private

    Field scaleVec:Vector2D

    Public

    Method TranslateSpace:Void(app:App, vec:Vector2D)
        InitScaleVector(app)
        vec.Div(scaleVec)
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
