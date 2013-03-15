Strict

Private

Import mojo.app

Public

Class DeltaTimer
    Private

    Field _delta:Float
    Field _frameTime:Float
    Field _millisecs:Float
    Field lastMillisecs:Float
    Field targetFps:Float
    Field paused:Bool
    Field pauseOffset:Float

    Public

    Method New()
        Throw New InvalidConstructorException("use New(Float)")
    End

    Method New(fps:Float)
        targetFps = fps
        lastMillisecs = Millisecs()
    End

    Method OnUpdate:Void()
        If paused Then Return

        _millisecs = Millisecs() - pauseOffset
        _frameTime = _millisecs - lastMillisecs
        _delta = frameTime / (1000.0 / targetFps)
        lastMillisecs = _millisecs
    End

    Method Play:Void()
        If Not paused Then Return
        paused = False

        lastMillisecs = Millisecs() - pauseOffset
    End

    Method Pause:Void()
        If paused Then Return
        paused = True

        Local now:Float = Millisecs()
        pauseOffset = now - lastMillisecs
    End

    Method IsPaused:Bool()
        Return paused
    End

    Method millisecs:Float() Property
        Return _millisecs
    End

    Method delta:Float() Property
        If paused Then Return 0
        Return _delta
    End

    Method frameTime:Float() Property
        If paused Then Return 0
        Return _frameTime
    End
End
