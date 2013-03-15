Strict

Private

Import bono
Import mojo

Public

Class AppTestCase Extends TestCase
    Method SwapBuffer:Void()
        GetGraphicsDevice().EndRender()
        mojo.graphics.EndRender()

        mojo.graphics.BeginRender()
        GetGraphicsDevice().BeginRender()
    End
End
