Strict

Import mojo

Class DeltaTimer
    Private

    Field targetfps:Float
    Field currentticks:Float
    Field lastticks:Float
    Field frametime:Float

    Public

    Field delta:Float

    Method New(fps:Float)
        targetfps = fps
        lastticks = Millisecs()
    End

    Method OnUpdate:Void()
        currentticks = Millisecs()
        frametime = currentticks - lastticks
        delta = frametime / (1000.0 / targetfps)
        lastticks = currentticks
    End
End
