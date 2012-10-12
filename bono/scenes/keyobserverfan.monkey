Strict

Private

Import bono.kernel
Import observerfan

Public

Class KeyObserverFan Implements KeyObserver, ObserverFan
    Private

    Field childs:List<Object> = New List<Object>()

    Public

    Method Add:Void(child:Object)
        childs.AddLast(child)
    End

    Method Remove:Void(child:Object)
        childs.RemoveEach(child)
    End

    Method OnKeyDown:Void(event:KeyEvent)
        Local castedChild:KeyObserver
        For Local child:Object = EachIn childs
            castedChild = KeyObserver(child)
            If castedChild Then castedChild.OnKeyDown(event)
        End
    End

    Method OnKeyPress:Void(event:KeyEvent)
        Local castedChild:KeyObserver
        For Local child:Object = EachIn childs
            castedChild = KeyObserver(child)
            If castedChild Then castedChild.OnKeyPress(event)
        End
    End

    Method OnKeyUp:Void(event:KeyEvent)
        Local castedChild:KeyObserver
        For Local child:Object = EachIn childs
            castedChild = KeyObserver(child)
            If castedChild Then castedChild.OnKeyUp(event)
        End
    End
End
