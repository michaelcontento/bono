Strict

Private

Import bono

Class DummyCallbackReceiver Implements TimedCallbackObserver
    Field events:StringMap<Int> = New StringMap<Int>()

    Method OnTimedCallback:Void(name:String)
        If Not events.Contains(name) Then events.Set(name, 0)
        events.Set(name, events.Get(name) + 1)
    End
End

Class DeltaTimerWithFixedFrameTime Extends DeltaTimer
    Private

    Field time:Float

    Public

    Method New(time:Float)
        Self.time = time
    End

    Method frameTime:Float() Property
        Return time
    End
End

Public

Class TimedCallbackEmitterTest Extends TestCase
    Field receiver:DummyCallbackReceiver
    Field callback:TimedCallbackEmitter

    Method GetDeltaTimerWithFrameTime:DeltaTimer(frameTime:Float)
        Return New DeltaTimerWithFixedFrameTime(frameTime)
    End

    Method SetUp:Void()
        receiver = New DummyCallbackReceiver()
        callback = New TimedCallbackEmitter()
    End

    Method TestCalledAfterTTL:Void()
        callback.Add("foo", receiver, 1)
        callback.OnUpdate(GetDeltaTimerWithFrameTime(2))

        AssertTrue(receiver.events.Contains("foo"))
        AssertEquals(1, receiver.events.Count())
        AssertEquals(1, receiver.events.Get("foo"))
    End

    Method TestCallMultipleAfterTTL:Void()
        callback.Add("foo", receiver, 1)
        callback.Add("bar", receiver, 2)
        callback.Add("foo", receiver, 3)
        callback.Add("bar", receiver, 4)
        callback.OnUpdate(GetDeltaTimerWithFrameTime(5))

        AssertTrue(receiver.events.Contains("foo"))
        AssertTrue(receiver.events.Contains("bar"))
        AssertEquals(2, receiver.events.Count())
        AssertEquals(2, receiver.events.Get("foo"))
        AssertEquals(2, receiver.events.Get("bar"))
    End

    Method TestNotCalledBeforeTTL:Void()
        callback.Add("foo", receiver, 2)
        callback.OnUpdate(GetDeltaTimerWithFrameTime(1))

        AssertFalse(receiver.events.Contains("foo"))
        AssertEquals(0, receiver.events.Count())
    End

    Method TestCountWithoutAddShouldBeZero:Void()
        AssertEquals(0, callback.Count())
    End

    Method TestCountAfterAdd:Void()
        callback.Add("foo", receiver, 1)
        callback.Add("foo", receiver, 1)
        AssertEquals(2, callback.Count())
    End

    Method TestCountShouldDecreaseAfterCall:Void()
        callback.Add("foo", receiver, 0)
        callback.OnUpdate(GetDeltaTimerWithFrameTime(1))

        AssertEquals(0, callback.Count())
    End

    Method TestClearByName:Void()
        callback.Add("foo", receiver, 0)
        callback.Add("foo", receiver, 0)
        callback.Add("bar", receiver, 0)
        callback.ClearByName("foo")

        AssertEquals(1, callback.Count())
    End

    Method TestClear:Void()
        callback.Add("foo", receiver, 0)
        callback.Add("bar", receiver, 0)
        callback.Clear()

        AssertEquals(0, callback.Count())
    End
End
