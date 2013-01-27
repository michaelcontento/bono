Strict

Private

Import bono.src.kernel
Import bono.src.utils

Public

Interface ContentScaler
    Method TranslateSpace:Void(app:App, vec:Vector2D)
    Method OnRenderPre:Void(app:App)
    Method OnRenderPost:Void(app:App)
End
