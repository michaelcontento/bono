Strict

Private

Import suspendable

Public

Class SuspendableFan Implements Suspendable
    Private

    Field pool:List<Suspendable> = New List<Suspendable>()

    Public

    Method OnSuspend:Void()
        For Local obj:Suspendable = EachIn pool
            obj.OnSuspend()
        End
    End

    Method OnResume:Void()
        For Local obj:Suspendable = EachIn pool
            obj.OnResume()
        End
    End

    Method Add:Void(obj:Suspendable)
        If Not pool.Contains(obj) Then pool.AddLast(obj)
    End

    Method Remove:Void(obj:Suspendable)
        pool.RemoveEach(obj)
    End
End
