Strict

Private

Import director
Import keyevent
Import touchevent
Import deltatimer

Public

Interface DirectorEvents
    Method OnCreate:Void(director:Director)
    Method OnLoading:Void()
    Method OnUpdate:Void(deltatimer:DeltaTimer)
    Method OnRender:Void()
    Method OnSuspend:Void()
    Method OnResume:Void(delta:Int)
    Method OnKeyDown:Void(event:KeyEvent)
    Method OnKeyPress:Void(event:KeyEvent)
    Method OnKeyUp:Void(event:KeyEvent)
    Method OnTouchDown:Void(event:TouchEvent)
    Method OnTouchMove:Void(event:TouchEvent)
    Method OnTouchUp:Void(event:TouchEvent)
End
