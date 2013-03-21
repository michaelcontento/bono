Strict

Private

Import bono

Public

Class Countdown Implements Updateable
    Private

    Field duration:Float
    Field elapsed:Float
    Field paused := False
    Field finishCallbacks := New StringMap<List<CountdownFinishCallback>>
    Field tickCallbacks := New StringMap<List<CountdownTickCallback>>
    Field finishTriggered := False

    Public


    Method New(duration:Float=0)
        Set(duration)
    End

    Method Pause:Void()
        paused = True
    End

    Method Play:Void()
        paused = False
    End

    Method PauseToggle:Void()
        paused = (Not paused)
    End

    Method Stop:Void()
        paused = True
        finishTriggered = False
        elapsed = 0
    End

    Method Restart:Void()
        Stop()
        Play()
    End

    Method IsPaused:Bool()
        Return paused
    End

    Method Set:Void(duration:Float)
        Self.duration = duration
        Restart()
    End

    Method Get:Float()
        Return (duration - elapsed)
    End

    Method Remaning:Float()
        Return Max(0.0, Get())
    End

    Method IsFinished:Bool()
        Return (Remaning() = 0)
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If paused Then Return

        elapsed += timer.frameTime
        TriggerTickCallbacks()
        TriggerFinishCallbacks()
    End

    Method Add:Void(duration:Float)
        elapsed += duration
    End

    Method Sub:Void(duration:Float)
        elapsed -= duration
    End

    ' --- FINISH CALLBACK

    Method AddFinishCallback:Void(name:String, obj:CountdownFinishCallback)
        If Not finishCallbacks.Contains(name)
            finishCallbacks.Set(name, New List<CountdownFinishCallback>)
        End

        If Not finishCallbacks.Get(name).Contains(obj)
            finishCallbacks.Get(name).AddLast(obj)
        End
    End

    Method RemoveFinishCallback:Void(name:String, obj:CountdownFinishCallback)
        If Not finishCallbacks.Contains(name) Then Return
        finishCallbacks.Get(name).RemoveEach(obj)
    End

    Method ClearFinishCallbacks:Void()
        finishCallbacks.Clear()
    End

    Method ClearFinishCallbacks:Void(name:String)
        If Not finishCallbacks.Contains(name) Then Return
        finishCallbacks.Remove(name)
    End

    ' --- TICK CALLBACK

    Method AddTickCallback:Void(name:String, obj:CountdownTickCallback)
        If Not tickCallbacks.Contains(name)
            tickCallbacks.Set(name, New List<CountdownTickCallback>)
        End

        If Not tickCallbacks.Get(name).Contains(obj)
            tickCallbacks.Get(name).AddLast(obj)
        End
    End

    Method RemoveTickCallback:Void(name:String, obj:CountdownTickCallback)
        If Not tickCallbacks.Contains(name) Then Return
        tickCallbacks.Get(name).RemoveEach(obj)
    End

    Method ClearTickCallbacks:Void()
        tickCallbacks.Clear()
    End

    Method ClearTickCallbacks:Void(name:String)
        If Not tickCallbacks.Contains(name) Then Return
        tickCallbacks.Remove(name)
    End

    Private

    Method TriggerTickCallbacks:Void()
        For Local name := EachIn tickCallbacks.Keys()
            For Local obj := EachIn tickCallbacks.Get(name)
                obj.OnCountdownTicked(Self, name, duration, elapsed)
            End
        End
    End

    Method TriggerFinishCallbacks:Void()
        If finishTriggered Then Return
        If elapsed < duration Then Return

        finishTriggered = True
        For Local name := EachIn finishCallbacks.Keys()
            For Local obj := EachIn finishCallbacks.Get(name)
                obj.OnCountdownFinished(Self, name, duration)
            End
        End
    End
End
