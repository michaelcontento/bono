Strict

Private

Import renderable

Public

Class RenderableFan Implements Renderable
    Private

    Field pool:List<Renderable> = New List<Renderable>()

    Public

    Method OnRender:Void()
        For Local obj:Renderable = EachIn pool
            obj.OnRender()
        End
    End

    Method Add:Void(obj:Renderable)
        If Not pool.Contains(obj) Then pool.AddLast(obj)
    End

    Method Remove:Void(obj:Renderable)
        pool.RemoveEach(obj)
    End
End
