Strict

Private

Import keyevent
Import observer

Public

Interface KeyObserver Extends Observer
    Method OnKeyDown:Void(event:KeyEvent)
    Method OnKeyPress:Void(event:KeyEvent)
    Method OnKeyUp:Void(event:KeyEvent)
End
