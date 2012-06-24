Strict

Private

Import mojo
Import vector2d

Public

Class TouchEvent
    Private

    Field finger_:Int
    Field startTime_:Int
    Field endTime_:Int

    Public

    Field positions:List<Vector2D> = New List<Vector2D>()

    Method Copy:TouchEvent()
        Local obj:TouchEvent = New TouchEvent(finger_)
        obj.Add(pos)
        Return obj
    End

    Method finger:Int() Property
        Return finger_
    End

    Method startTime:Int() Property
        Return startTime_
    End

    Method endTime:Int() Property
        Return endTime_
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
        If positions.Count() < 2 Then Return New Vector2D(0, 0)
        Return positions.LastNode().PrevNode().Value()
    End

    Method startDelta:Vector2D() Property
        Return pos.Copy().Sub(startPos)
    End

    Method prevDelta:Vector2D() Property
        Return pos.Copy().Sub(prevPos)
    End

    Method New(finger:Int)
        finger_ = finger
        startTime_ = Millisecs()
    End

    Method Trim:Void(size:Int)
        If size = 0
            positions.Clear()
            Return
        End

        While positions.Count() > size
            positions.RemoveFirst()
        End
    End

    Method Add:Void(pos:Vector2D)
        endTime_ = Millisecs()
        If prevPos.x = pos.x And prevPos.y = pos.y Then Return
        positions.AddLast(pos)
    End
End
