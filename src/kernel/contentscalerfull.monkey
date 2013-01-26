Strict

Private

Import app
Import bono.src.helper
Import contentscaler
Import mojo.graphics
Import bono.src.utils

Public

Class ContentScalerFull Implements ContentScaler
    Private

    Field usedScale:Vector2D

    Public

    Method OnRenderPre:Void(app:App)
        If Not usedScale
            usedScale = Device.GetSize().Copy()
            usedScale.Div(app.GetVirtualSize())
        End

        MatrixHelper.Scale(usedScale)
    End

    Method OnRenderPost:Void(app:App)
    End
End
