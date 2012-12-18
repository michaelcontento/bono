Strict

Private

Import deltatimer
Import updateable

Public

Class UpdateableFan Implements Updateable
    Private

    Field pool:List<Updateable> = New List<Updateable>()

    Public

    Method OnUpdate:Void(timer:DeltaTimer)
        For Local obj:Updateable = EachIn pool
            obj.OnUpdate(timer)
        End
    End

    Method Add:Void(obj:Updateable)
        If Not pool.Contains(obj) Then pool.AddLast(obj)
    End

    Method Remove:Void(obj:Updateable)
        pool.RemoveEach(obj)
    End
End
