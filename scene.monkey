Strict

Private

Import animationable
Import layer

Public

Class Scene Implements Animationable Abstract
    Field created:Bool = False
    Field name:String
    Field layer:Layer = New Layer()

    Method OnLoading:Void()
    End

    Method OnUpdate:Void()
        layer.OnUpdate()
    End

    Method OnRender:Void()
        layer.OnRender()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnCreate:Void()
    End

    Method OnEnter:Void()
    End

    Method OnLeave:Void()
    End
End
