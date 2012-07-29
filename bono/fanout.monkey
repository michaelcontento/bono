Strict

Private

Import director
Import directorevents
Import deltatimer
Import keyevent
Import touchevent

Public

Class FanOut Implements DirectorEvents
    Private

    Field objects:List<DirectorEvents> = New List<DirectorEvents>()

    Public

    Method Add:Void(obj:DirectorEvents)
        objects.AddLast(obj)
    End

    Method Count:Int()
        Return objects.Count()
    End

    Method Clear:Void()
        objects.Clear()
    End

    Method Remove:Void(obj:DirectorEvents)
        objects.RemoveEach(obj)
    End

    Method ObjectEnumerator:list.Enumerator<DirectorEvents>()
        Return objects.ObjectEnumerator()
    End

    Method OnCreate:Void(director:Director)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnCreate(director)
        End
    End

    Method OnLoading:Void()
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnLoading()
        End
    End

    Method OnUpdate:Void(deltaTimer:DeltaTimer)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnUpdate(deltaTimer)
        End
    End

    Method OnRender:Void()
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnRender()
        End
    End

    Method OnSuspend:Void()
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnSuspend()
        End
    End

    Method OnResume:Void(delta:Int)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnResume(delta)
        End
    End

    Method OnKeyDown:Void(event:KeyEvent)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnKeyDown(event)
        End
    End

    Method OnKeyPress:Void(event:KeyEvent)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnKeyPress(event)
        End
    End

    Method OnKeyUp:Void(event:KeyEvent)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnKeyUp(event)
        End
    End

    Method OnTouchDown:Void(event:TouchEvent)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnTouchDown(event)
        End
    End

    Method OnTouchMove:Void(event:TouchEvent)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnTouchMove(event)
        End
    End

    Method OnTouchUp:Void(event:TouchEvent)
        If Not objects Then Return
        For Local obj:DirectorEvents = EachIn objects
            obj.OnTouchUp(event)
        End
    End
End
