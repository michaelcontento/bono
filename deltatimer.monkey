Strict

Import mojo

Class DeltaTimer
    Private

    Field currentTicks:Float
    Field frameTime:Float
    Field lastTicks:Float
    Field targetFps:Float

    Public

    Field delta:Float

    Method New(fps:Float)
        targetFps = fps
        lastTicks = Millisecs()
    End

    Method OnUpdate:Void()
        currentTicks = Millisecs()
        frameTime = currentTicks - lastTicks
        delta = frameTime / (1000.0 / targetFps)
        lastTicks = currentTicks
    End
End
