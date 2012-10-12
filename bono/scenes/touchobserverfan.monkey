Strict

Private

Import bono.kernel
Import observerfan

Public

Class TouchObserverFan Implements TouchObserver, ObserverFan
    Private

    Field childs:List<Object> = New List<Object>()

    Public

    Method Add:Void(child:Object)
        childs.AddLast(child)
    End

    Method Remove:Void(child:Object)
        childs.RemoveEach(child)
    End

    Method OnTouchDown:Void(event:TouchEvent)
        Local castedChild:TouchObserver
        For Local child:Object = EachIn childs
            castedChild = TouchObserver(child)
            If castedChild Then castedChild.OnTouchDown(event)
        End
    End

    Method OnTouchMove:Void(event:TouchEvent)
        Local castedChild:TouchObserver
        For Local child:Object = EachIn childs
            castedChild = TouchObserver(child)
            If castedChild Then castedChild.OnTouchMove(event)
        End
    End

    Method OnTouchUp:Void(event:TouchEvent)
        Local castedChild:TouchObserver
        For Local child:Object = EachIn childs
            castedChild = TouchObserver(child)
            If castedChild Then castedChild.OnTouchUp(event)
        End
    End
End
