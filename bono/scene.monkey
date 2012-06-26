Strict

Private

Import director
Import inputhandler
Import layer
Import renderable
Import scenemanager
Import touchevent

Public

Class Scene Implements Renderable, InputHandler Abstract
    Private

    Field _layer:Layer = New Layer()
    Field _name:String
    Field nameAlreadySet:Bool

    Public

    Field scenes:SceneManager

    Method OnLoading:Void()
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

    Method OnUpdate:Void()
        _layer.OnUpdate()
    End

    Method OnRender:Void()
        _layer.OnRender()
    End

    Method OnTouchDown:Void(event:TouchEvent)
    End

    Method OnTouchUp:Void(event:TouchEvent)
    End

    Method OnTouchMove:Void(event:TouchEvent)
    End

    Method director:Director() Property
        Return scenes.director
    End

    Method layer:Layer() Property
        Return _layer
    End

    Method name:String() Property
        Return _name
    End

    Method name:Void(name:String) Property
        If nameAlreadySet Then Error("Name already set.")
        nameAlreadySet = True
        _name = name
    End
End
