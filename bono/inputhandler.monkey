Strict

Private

Import touchevent
Import keyevent

Public

Interface InputHandler
    Method OnTouchDown:Void(event:TouchEvent)
    Method OnTouchUp:Void(event:TouchEvent)
    Method OnTouchMove:Void(event:TouchEvent)
    Method OnKeyDown:Void(event:KeyEvent)
    Method OnKeyUp:Void(event:KeyEvent)
    Method OnKeyPress:Void(event:KeyEvent)
End
