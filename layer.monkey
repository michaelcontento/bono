Strict

Private

Import bono

Public

Class Layer Implements Renderable
    Private

    Field objects:List<Renderable> = New List<Renderable>

    Public

    Method Add:Void(obj:Renderable)
        objects.AddLast(obj)
    End

    Method Count:Int()
        Return objects.Count()
    End

    Method Clear:Void()
        objects.Clear()
    End

    Method Remove:Void(obj:Renderable)
        objects.RemoveEach(obj)
    End

    Method ObjectEnumerator:list.Enumerator<Renderable>()
        Return objects.ObjectEnumerator()
    End

    Method OnRender:Void()
        If Not objects Then Return
        For Local obj:Renderable = EachIn objects
            obj.OnRender()
        End
    End

    Method OnUpdate:Void()
        If Not objects Then Return
        For Local obj:Renderable = EachIn objects
            obj.OnUpdate()
        End
    End
End
