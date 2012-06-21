Strict

Private

Import animationable
Import layer

Public

Class Scene Implements Animationable Abstract
    Private

    Field layer_:Layer = New Layer()
    Field created_:Bool = False
    Field name_:String
    Field nameAlreadySet:Bool

    Public

    Method layer:Layer() Property
        Return layer_
    End

    Method created:Bool() Property
        Return created_
    End

    Method created:Void(flag:Bool) Property
        If created_ Then Error("Scene already created.")
        created_ = flag
    End

    Method name:String() Property
        Return name_
    End

    Method name:Void(name:String) Property
        If nameAlreadySet Then Error("Name already set.")
        nameAlreadySet = True

        name_ = name
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void()
        layer_.OnUpdate()
    End

    Method OnRender:Void()
        layer_.OnRender()
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
