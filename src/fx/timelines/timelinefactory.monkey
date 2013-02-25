Strict

Private

Import bono

Public

Class TimelineFactory
    Private

    Field obj:Object
    Field line:Timeline

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Object)")
    End

    Method New(obj:Object)
        Self.obj = obj
        line = New Timeline()
    End

    Method GetTimeline:Timeline()
        Return line
    End

    Method Loop:Void(times:Int=Timeline.INFINITE)
        line.Loop(times)
    End

    Method MoveTo:ActionMoveTo(pos:Vector2D)
        Local result := New ActionMoveTo(Positionable(obj), pos)
        line.Append(result)
        Return result
    End

    Method Sleep:ActionSleep(duration:Float)
        Local result := New ActionSleep(duration)
        line.Append(result)
        Return result
    End

    Method Rotate:ActionRotate(angel:Float)
        Local result := New ActionRotate(Rotateable(obj), angel)
        line.Append(result)
        Return result
    End
End
