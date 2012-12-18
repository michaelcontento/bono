Strict

Private

Import touchable
Import touchevent

Public

Class TouchableFan Implements Touchable
    Private

    Field pool:List<Touchable> = New List<Touchable>()

    Public

    Method OnTouchDown:Void(event:TouchEvent)
        For Local obj:Touchable = EachIn pool
            obj.OnTouchDown(event)
        End
    End

    Method OnTouchMove:Void(event:TouchEvent)
        For Local obj:Touchable = EachIn pool
            obj.OnTouchMove(event)
        End
    End

    Method OnTouchUp:Void(event:TouchEvent)
        For Local obj:Touchable = EachIn pool
            obj.OnTouchUp(event)
        End
    End

    Method Add:Void(obj:Touchable)
        If Not pool.Contains(obj) Then pool.AddLast(obj)
    End

    Method Remove:Void(obj:Touchable)
        pool.RemoveEach(obj)
    End
End
