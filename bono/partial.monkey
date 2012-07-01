Strict

Private

Import director
Import directorevents
Import keyevent
Import touchevent

Public

Class Partial Implements DirectorEvents Abstract
    Private

    Field _director:Director

    Public

    Method OnCreate:Void(director:Director)
        _director = director
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(delta:Float)
    End

    Method OnRender:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnResume:Void(delta:Int)
    End

    Method OnKeyDown:Void(event:KeyEvent)
    End

    Method OnKeyPress:Void(event:KeyEvent)
    End

    Method OnKeyUp:Void(event:KeyEvent)
    End

    Method OnTouchDown:Void(event:TouchEvent)
    End

    Method OnTouchMove:Void(event:TouchEvent)
    End

    Method OnTouchUp:Void(event:TouchEvent)
    End

    Method director:Director() Property
        Return _director
    End
End
