Strict

Private

Import bono.src.kernel
Import sceneable

Public

Class SceneManager Implements Renderable
    Private

    Field scenes:StringMap<Sceneable> = New StringMap<Sceneable>()
    Field _current:Sceneable
    Field _currentName:String
    Field _previous:Sceneable
    Field _previousName:String

    Public

    Method OnRender:Void()
        If _current Then _current.OnRender()
    End

    Method Add:Void(name:String, scene:Sceneable)
        If scenes.Contains(name)
            Error("There is already a scene named: " + name)
        End

        scenes.Set(name, scene)
    End

    Method Get:Sceneable(name:String)
        If Not scenes.Contains(name)
            Error("Unknown scene name given: " + name)
        End

        Return scenes.Get(name)
    End

    Method Goto:Void(name:String)
        If name = _currentName Then Return

        ChangeCurrentAndPrevious(name)
        If _previous Then _previous.OnSceneLeave()
        If _current Then _current.OnSceneEnter()
    End

    Method current:Sceneable() Property
        Return _current
    End

    Method currentName:String() Property
        Return _currentName
    End

    Method previous:Sceneable() Property
        Return _previous
    End

    Method previousName:String() Property
        Return _previousName
    End

    Private

    Method ChangeCurrentAndPrevious:Void(name:String)
        _previous = _current
        _previousName = _currentName

        _current = Get(name)
        _currentName = name
    End
End
