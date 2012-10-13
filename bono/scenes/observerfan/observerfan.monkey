Strict

Public

Class ObserverFan Abstract
    Private

    Field childs:List<Object> = New List<Object>()

    Public

    Method Add:Void(child:Object)
        childs.AddLast(child)
    End

    Method Remove:Void(child:Object)
        childs.RemoveEach(child)
    End

    Method ObjectEnumerator:list.Enumerator<Object>()
        Return childs.ObjectEnumerator()
    End
End
