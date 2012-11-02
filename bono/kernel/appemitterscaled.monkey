Strict

Private

Import appemitter
Import appobserver
Import bono.utils
Import mojo.graphics
Import touchemitter

Public

Class AppEmitterScaled Extends AppEmitter
    Private

    Field size:Vector2D
    Field scale:Vector2D = New Vector2D(1, 1)
    Field counter:Int = 0
    Field counterThreshold:Int

    Public

    Method New(size:Vector2D, fps:Int=DEFAULT_FPS)
        Super.New(fps)
        Self.size = size

        ' 60 FPS = Size check once per frame
        counterThreshold = 60
        counter = counterThreshold
    End

    Method OnUpdate:Int()
        counter += 1
        If counter >= counterThreshold
            scale = Device.GetSize().Copy().Div(size)
            counter = 0
            Print "check"
        End

        Return Super.OnUpdate()
    End

    Method OnRender:Int()
        Scale(scale.x, scale.y)
        Return Super.OnRender()
    End
End
