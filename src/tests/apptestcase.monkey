Strict

Private

Import bono
Import mojo

Public

Class AppTestCase Extends TestCase
    Private

    Global imageRenderColor := New Color()

    Public

    Method SetUp:Void()
        Super.SetUp()
        Cls()
    End

    Method SwapAndSleep:Void()
        SwapBuffer()
        For Local i := 0 To 2000000000
            Millisecs()
        End
    End

    Method SwapBuffer:Void()
        ' GetGraphicsDevice().EndRender()
        ' mojo.graphics.EndRender()

        ' mojo.graphics.BeginRender()
        ' GetGraphicsDevice().BeginRender()
    End

    Method AssertScreenEquals:Void(imgfile:String)
        Local data := LoadPixelData(imgfile)
        If Not HasPixelDifference(data) Then Return

        SwapAndSleep()
        Throw New AssertionFailedException(
            "Pixel difference found between the current " +
            "render buffer and " + imgfile)
    End

    Method AssertScreenNotEquals:Void(imgfile:String)
        Local data := LoadPixelData(imgfile)
        If HasPixelDifference(data) Then Return

        Throw New AssertionFailedException(
            "render buffer and " + imgfile + " are identical")
    End

    Private

    Method LoadPixelData:Int[][](imgfile:String)
        Local img := LoadImage(imgfile)
        AssertNotNull(img)

        Local p1 := New Int[img.Width() * img.Height()]
        ReadPixels(p1, 0, 0, img.Width(), img.Height())

        RenderImage(img)

        Local p2 := New Int[img.Width() * img.Height()]
        ReadPixels(p2, 0, 0, img.Width(), img.Height())

        Return [p1, p2]
    End

    Method RenderImage:Void(img:Image)
        ' It's important to ensure a clean state of the global color / alpha 
        ' value AND a blank canvas!

        Cls()
        imageRenderColor.Activate()
        DrawImage(img, 0, 0)
        imageRenderColor.Deactivate()
    End

    Method HasPixelDifference:Bool(data:Int[][])
        For Local i := 0 Until data[0].Length()
            If Not (data[0][i] = data[1][i]) Then Return True
        End

        Return False
    End
End
