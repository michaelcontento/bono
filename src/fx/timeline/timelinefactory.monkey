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

    Method Clear:Void()
        GetTimeline().Clear()
    End

    Method Loop:Void(times:Int=Timeline.INFINITE)
        line.Loop(times)
    End

    Method Parallel:ActionParallel()
        Local result := New ActionParallel(obj)
        line.Append(result)
        Return result
    End

    Method Callback:ActionCallback(name:String, cb:ActionsCallback)
        Local result := New ActionCallback(obj, name, cb)
        line.Append(result)
        Return result
    End

    Method MoveTo:ActionMoveTo(pos:Vector2D)
        Local result := New ActionMoveTo(Positionable(obj), pos)
        line.Append(result)
        Return result
    End

    Method MoveTo:ActionMoveTo(x:Float, y:Float)
        Return MoveTo(New Vector2D(x, y))
    End

    Method SizeTo:ActionSizeTo(size:Vector2D)
        Local result := New ActionSizeTo(Sizeable(obj), size)
        line.Append(result)
        Return result
    End

    Method SizeTo:ActionSizeTo(width:Float, height:Float)
        Return SizeTo(width, height)
    End

    Method FadeColorTo:ActionFadeColorTo(dst:Color)
        Local result := New ActionFadeColorTo(Colorable(obj), dst)
        line.Append(result)
        Return result
    End

    Method FadeAlphaTo:ActionFadeAlphaTo(alpha:Float)
        Local result := New ActionFadeAlphaTo(Colorable(obj), alpha)
        line.Append(result)
        Return result
    End

    Method Scale:ActionScale(scaleToAdd:Vector2D)
        Local result := New ActionScale(Sprite(obj), scaleToAdd)
        line.Append(result)
        Return result
    End

    Method Scale:ActionScale(val:Float)
        Return Scale(val, val)
    End

    Method Scale:ActionScale(x:Float, y:Float)
        Return Scale(New Vector2D(x, y))
    End

    Method Sleep:ActionSleep(duration:Float)
        Local result := New ActionSleep(duration)
        line.Append(result)
        Return result
    End

    Method SleepRandom:ActionSleepRandom(minDuration:Float, maxDuration:Float)
        Return Sleep(Rnd(minDuration, maxDuration))
    End

    Method SleepRandomLateEval:ActionSleepRandomLateEval(minDuration:Float, maxDuration:Float)
        Local result := New ActionSleepRandomLateEval(minDuration, maxDuration)
        line.Append(result)
        Return result
    End

    Method Rotate:ActionRotate(angel:Float)
        Local result := New ActionRotate(Rotateable(obj), angel)
        line.Append(result)
        Return result
    End
End
