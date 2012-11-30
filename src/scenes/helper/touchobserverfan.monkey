Strict

Private

Import bono.src.kernel
Import observerfan

Public

Class TouchObserverFan Extends ObserverFan Implements TouchObserver
    Method OnTouchDown:Void(event:TouchEvent)
        Local castedChild:TouchObserver
        For Local child:Object = EachIn Self
            castedChild = TouchObserver(child)
            If castedChild Then castedChild.OnTouchDown(event)
        End
    End

    Method OnTouchMove:Void(event:TouchEvent)
        Local castedChild:TouchObserver
        For Local child:Object = EachIn Self
            castedChild = TouchObserver(child)
            If castedChild Then castedChild.OnTouchMove(event)
        End
    End

    Method OnTouchUp:Void(event:TouchEvent)
        Local castedChild:TouchObserver
        For Local child:Object = EachIn Self
            castedChild = TouchObserver(child)
            If castedChild Then castedChild.OnTouchUp(event)
        End
    End
End
