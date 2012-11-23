Strict

Private

Import observer
Import touchevent

Public

Interface TouchObserver Extends Observer
    Method OnTouchDown:Void(event:TouchEvent)
    Method OnTouchMove:Void(event:TouchEvent)
    Method OnTouchUp:Void(event:TouchEvent)
End
