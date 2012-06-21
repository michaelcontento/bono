Strict

Import mojo

Class DeltaTimer
    Private

    Field currentTicks:Float
    Field frameTime:Float
    Field lastTicks:Float
    Field targetFps:Float
    Field delta_:Float

    Public

    Method delta:Float() Property
        Return delta_
    End

    Method New(fps:Float)
        targetFps = fps
        lastTicks = Millisecs()
    End

    Method OnUpdate:Void()
        currentTicks = Millisecs()
        frameTime = currentTicks - lastTicks
        delta_ = frameTime / (1000.0 / targetFps)
        lastTicks = currentTicks
    End
End
