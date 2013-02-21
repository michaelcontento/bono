Strict

Private

Import bono

Public

Class KeyhandlerFan Implements Keyhandler
    Private

    Field pool:List<Keyhandler> = New List<Keyhandler>()

    Public

    Method OnKeyDown:Bool(event:KeyEvent)
        For Local obj:Keyhandler = EachIn pool
            If obj.OnKeyDown(event) Then Return True
        End
        Return False
    End

    Method OnKeyPress:Bool(event:KeyEvent)
        For Local obj:Keyhandler = EachIn pool
            If obj.OnKeyPress(event) Then Return True
        End
        Return False
    End

    Method OnKeyUp:Bool(event:KeyEvent)
        For Local obj:Keyhandler = EachIn pool
            If obj.OnKeyUp(event) Then Return True
        End
        Return False
    End

    Method Add:Void(obj:Keyhandler)
        If Not pool.Contains(obj) Then pool.AddFirst(obj)
    End

    Method Remove:Void(obj:Keyhandler)
        pool.RemoveEach(obj)
    End
End
