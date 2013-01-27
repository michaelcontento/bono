Strict

Private

Import bono

Public

Class KeyhandlerFan Implements Keyhandler
    Private

    Field pool:List<Keyhandler> = New List<Keyhandler>()

    Public

    Method OnKeyDown:Void(event:KeyEvent)
        For Local obj:Keyhandler = EachIn pool
            obj.OnKeyDown(event)
        End
    End

    Method OnKeyPress:Void(event:KeyEvent)
        For Local obj:Keyhandler = EachIn pool
            obj.OnKeyPress(event)
        End
    End

    Method OnKeyUp:Void(event:KeyEvent)
        For Local obj:Keyhandler = EachIn pool
            obj.OnKeyUp(event)
        End
    End

    Method Add:Void(obj:Keyhandler)
        If Not pool.Contains(obj) Then pool.AddLast(obj)
    End

    Method Remove:Void(obj:Keyhandler)
        pool.RemoveEach(obj)
    End
End
