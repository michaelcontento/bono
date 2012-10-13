Strict

Private

Import bono.kernel
Import observerfan

Public

Class KeyObserverFan Extends ObserverFan Implements KeyObserver
    Method OnKeyDown:Void(event:KeyEvent)
        Local castedChild:KeyObserver
        For Local child:Object = EachIn Self
            castedChild = KeyObserver(child)
            If castedChild Then castedChild.OnKeyDown(event)
        End
    End

    Method OnKeyPress:Void(event:KeyEvent)
        Local castedChild:KeyObserver
        For Local child:Object = EachIn Self
            castedChild = KeyObserver(child)
            If castedChild Then castedChild.OnKeyPress(event)
        End
    End

    Method OnKeyUp:Void(event:KeyEvent)
        Local castedChild:KeyObserver
        For Local child:Object = EachIn Self
            castedChild = KeyObserver(child)
            If castedChild Then castedChild.OnKeyUp(event)
        End
    End
End
