Strict

Private

Import bono

Public

Class TouchableFan Implements Touchable
    Private

    Field pool:List<Touchable> = New List<Touchable>()

    Public

    Method OnTouchDown:Bool(event:TouchEvent)
        For Local obj:Touchable = EachIn pool
            If obj.OnTouchDown(event) Then Return True
        End
        Return False
    End

    Method OnTouchMove:Bool(event:TouchEvent)
        For Local obj:Touchable = EachIn pool
            If obj.OnTouchMove(event) Then Return True
        End
        Return False
    End

    Method OnTouchUp:Bool(event:TouchEvent)
        For Local obj:Touchable = EachIn pool
            If obj.OnTouchUp(event) Then Return True
        End
        Return False
    End

    Method Add:Void(obj:Touchable)
        If Not pool.Contains(obj) Then pool.AddFirst(obj)
    End

    Method Remove:Void(obj:Touchable)
        pool.RemoveEach(obj)
    End
End
