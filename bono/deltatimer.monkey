Strict

Private

Import mojo

Public

Class DeltaTimer
    Private

    Field currentTicks:Float
    Field frameTime:Float
    Field lastTicks:Float
    Field targetFps:Float
    Field _delta:Float

    Public

    Method New(fps:Float)
        targetFps = fps
        lastTicks = Millisecs()
    End

    Method OnUpdate:Void()
        currentTicks = Millisecs()
        frameTime = currentTicks - lastTicks
        _delta = frameTime / (1000.0 / targetFps)
        lastTicks = currentTicks
    End

    Method delta:Float() Property
        Return _delta
    End
End
