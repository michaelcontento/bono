Strict

Private

Import bono

Public

Class ActionParallel Implements Action
    Private

    Field lines := New List<TimelineFactory>()
    Field obj:Object

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Object)")
    End

    Method New(obj:Object)
        Self.obj = obj
    End

    Method NewLine:TimelineFactory()
        Local line := New TimelineFactory(obj)
        lines.AddLast(line)
        Return line
    End

    Method OnActionStart:Void()
    End

    Method OnActionEnd:Void()
    End

    Method IsFinished:Bool()
        For Local line := EachIn lines
            If Not line.GetTimeline().IsFinished() Then Return False
        End

        Return True
    End

    Method OnUpdate:Void(time:DeltaTimer)
        For Local line := EachIn lines
            line.GetTimeline().OnUpdate(time)
        End
    End
End
