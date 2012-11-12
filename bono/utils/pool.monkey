Strict

Public

Class Pool<T>
    Private

    Field items:Stack<T> = New Stack<T>()

    Public

    Method Free:Void()
        items.Clear()
    End

    Method Put:Void(newItem:T)
        items.Push(newItem)
    End

    Method Get:T()
        If items.Length() > 0 Then Return items.Pop()
        Return New T()
    End

    Method Length:Int()
        Return items.Length()
    End
End
