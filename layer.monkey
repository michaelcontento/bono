Strict

Private

Import animationable

Public

Class Layer Implements Animationable
    Private

    Field objects:List<Animationable> = New List<Animationable>

    Public

    Method Add:Void(obj:Animationable)
        objects.AddLast(obj)
    End

    Method Count:Int()
        Return objects.Count()
    End

    Method Clear:Void()
        objects.Clear()
    End

    Method Remove:Void(obj:Animationable)
        objects.RemoveEach(obj)
    End

    Method OnRender:Void()
        If Not objects Then Return
        For Local obj:Animationable = EachIn objects
            obj.OnRender()
        End
    End

    Method OnUpdate:Void()
        If Not objects Then Return
        For Local obj:Animationable = EachIn objects
            obj.OnUpdate()
        End
    End

    Method ObjectEnumerator:list.Enumerator<Animationable>()
        Return objects.ObjectEnumerator()
    End
End
