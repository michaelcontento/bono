Strict

Private

Import bono
Import mojo.app

Public

Class TouchEvent
    Private

    Field _endTime:Int
    Field _finger:Int
    Field _id:Int
    Field _startTime:Int
    Global nextId:Int = 0

    Public

    Field positions:List<Vector2D> = New List<Vector2D>()

    Method New(finger:Int)
        _finger = finger
        _startTime = Millisecs()

        nextId += 1
        _id = nextId
    End

    Method Trim:Void(size:Int)
        If size = 0 Then
            positions.Clear()
            Return
        End

        While positions.Count() > size
            positions.RemoveFirst()
        End
    End

    Method Add:Void(pos:Vector2D)
        _endTime = Millisecs()
        If prevPos.x = pos.x And prevPos.y = pos.y Then Return
        positions.AddLast(pos)
    End

    Method Copy:TouchEvent()
        Local obj:TouchEvent = New TouchEvent(_finger)

        ' New has increased the global counter but we're just creating a clone
        ' of ourself and, to keep a proper order, we should decrement the id
        ' by one now
        nextId -= 1

        obj._id = _id
        obj._startTime = _startTime
        obj._endTime = _endTime
        For Local pos:Vector2D = EachIn positions
            obj.Add(pos)
        End

        Return obj
    End

    Method finger:Int() Property
        Return _finger
    End

    Method startTime:Int() Property
        Return _startTime
    End

    Method endTime:Int() Property
        Return _endTime
    End

    Method id:Int() Property
        Return _id
    End

    Method pos:Vector2D() Property
        If positions.Count() = 0 Then Return New Vector2D(0, 0)
        Return positions.Last()
    End

    Method startPos:Vector2D() Property
        If positions.Count() = 0 Then Return New Vector2D(0, 0)
        Return positions.First()
    End

    Method prevPos:Vector2D() Property
        If positions.Count() = 0 Then Return New Vector2D(0, 0)
        If positions.Count() = 1 Then Return startPos
        Return positions.LastNode().PrevNode().Value()
    End

    Method startDelta:Vector2D() Property
        Return pos.Copy().Sub(startPos)
    End

    Method prevDelta:Vector2D() Property
        Return pos.Copy().Sub(prevPos)
    End
End
