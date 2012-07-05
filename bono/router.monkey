Strict

Private

Import director
Import directorevents
Import keyevent
Import routerevents
Import touchevent

Public

Class Router Implements DirectorEvents
    Private

    Field handlers:StringMap<DirectorEvents> = New StringMap<DirectorEvents>()
    Field routers:StringMap<RouterEvents> = New StringMap<RouterEvents>()
    Field created:List<String> = New List<String>()
    Field _current:DirectorEvents
    Field _currentName:String
    Field _previous:DirectorEvents
    Field _previousName:String
    Field director:Director

    Public

    Method Add:Void(name:String, handler:DirectorEvents)
        If handlers.Contains(name)
            Error("Router already contains a handler named " + name)
        End

        handlers.Set(name, handler)
        routers.Set(name, RouterEvents(handler))
    End

    Method Get:DirectorEvents(name:String)
        If Not handlers.Contains(name)
            Error("Router has no handler named " + name)
        End

        Return handlers.Get(name)
    End

    Method Goto:Void(name:String)
        If name = _currentName Then Return

        _previous = _current
        _previousName = _currentName

        _current = Get(name)
        _currentName = name
        DispatchOnCreate()

        Local tmpRouter:RouterEvents = routers.Get(_previousName)
        If tmpRouter Then tmpRouter.OnLeave()

        tmpRouter = routers.Get(_currentName)
        If tmpRouter Then tmpRouter.OnEnter()
    End

    Method OnCreate:Void(director:Director)
        Self.director = director
        DispatchOnCreate()
    End

    Method OnLoading:Void()
        If _current Then _current.OnLoading()
    End

    Method OnUpdate:Void(delta:Float, frameTime:Float)
        If _current Then _current.OnUpdate(delta, frameTime)
    End

    Method OnRender:Void()
        If _current Then _current.OnRender()
    End

    Method OnSuspend:Void()
        If _current Then _current.OnSuspend()
    End

    Method OnResume:Void(delta:Int)
        If _current Then _current.OnResume(delta)
    End

    Method OnKeyDown:Void(event:KeyEvent)
        If _current Then _current.OnKeyDown(event)
    End

    Method OnKeyPress:Void(event:KeyEvent)
        If _current Then _current.OnKeyPress(event)
    End

    Method OnKeyUp:Void(event:KeyEvent)
        If _current Then _current.OnKeyUp(event)
    End

    Method OnTouchDown:Void(event:TouchEvent)
        If _current Then _current.OnTouchDown(event)
    End

    Method OnTouchMove:Void(event:TouchEvent)
        If _current Then _current.OnTouchMove(event)
    End

    Method OnTouchUp:Void(event:TouchEvent)
        If _current Then _current.OnTouchUp(event)
    End

    Method current:DirectorEvents() Property
        Return _current
    End

    Method currentName:String() Property
        Return _currentName
    End

    Method previous:DirectorEvents() Property
        Return _previous
    End

    Method previousName:String() Property
        Return _previousName
    End

    Private

    Method DispatchOnCreate:Void()
        If Not director Then Return
        If Not _current Then Return
        If created.Contains(_currentName) Then Return

        _current.OnCreate(director)
        created.AddLast(_currentName)
    End
End
