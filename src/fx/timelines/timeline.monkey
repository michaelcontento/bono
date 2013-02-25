Strict

Private

Import bono

Public

Class Timeline Implements Updateable
    Private

    Const START_POSITION := 1
    Field actions := New IntMap<Action>()
    Field length := 0
    Field position := START_POSITION
    Field positionStarted := False
    Field isPaused := False
    Field loopsRequested := 0
    Field loopCounter := 0

    Public

    Const INFINITE := -1

    Method Pause:Void()
        isPaused = True
    End

    Method Play:Void()
        isPaused = False
    End

    Method PauseToggle:Void()
        isPaused = (Not isPaused)
    End

    Method Stop:Void()
        isPaused = True
        position = START_POSITION
    End

    Method Restart:Void()
        Stop()
        Play()
    End

    Method Loop:Void(times:Int=INFINITE)
        loopsRequested = times
    End

    Method Clear:Void()
        actions.Clear()
        position = START_POSITION
    End

    Method Prepend:Void(action:Action)
        length += 1

        For Local i := length Until START_POSITION Step -1
            actions.Set(i, actions.Get(i - 1))
        End

        actions.Set(START_POSITION, action)
    End

    Method Append:Void(action:Action)
        length += 1
        actions.Set(length, action)
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If isPaused Then Return

        HandleLoopCondition()
        If position > length Then Return

        Local currentAction := actions.Get(position)
        If Not positionStarted
            positionStarted = True
            currentAction.OnActionStart()
        End

        currentAction.OnUpdate(timer)
        If Not currentAction.IsFinished() Then Return

        currentAction.OnActionEnd()
        positionStarted = False
        position += 1
    End

    Private

    Method HandleLoopCondition:Void()
        If isPaused Then Return
        If position <= length Then Return
        If loopsRequested = 0 Then Return

        If loopsRequested = INFINITE
            position = START_POSITION
            Return
        End

        If loopCounter < loopsRequested
            position = START_POSITION
            loopCounter += 1
        End
    End
End
