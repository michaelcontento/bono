Strict

Private

Import mojo

Public

Class DeltaTimer
    Private

    Field _delta:Float
    Field _frameTime:Float
    Field currentTicks:Float
    Field lastTicks:Float
    Field targetFps:Float

    Public

    Method New(fps:Float)
        targetFps = fps
        lastTicks = Millisecs()
    End

    Method OnUpdate:Void()
        currentTicks = Millisecs()
        _frameTime = currentTicks - lastTicks
        _delta = frameTime / (1000.0 / targetFps)
        lastTicks = currentTicks
    End

    Method delta:Float() Property
        Return _delta
    End

    Method frameTime:Float() Property
        Return frameTime
    End
End
