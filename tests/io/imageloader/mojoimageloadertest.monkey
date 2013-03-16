Strict

Private

Import bono
Import mojo

Public

Class MojoImageLoaderTest Extends TestCase
    Field loader:MojoImageLoader

    Method SetUp:Void()
        loader = New MojoImageLoader()
    End

    Method TestThrowExceptionIfFileDoesNotExists:Void()
        Local caught := False
        Try
            loader.LoadImage("invalid-file-name")
        Catch ex:RuntimeException
            caught = True
        End
        If Not caught Then Fail("RuntimeException expected")
    End

    Method TestLoadExistingImage:Void()
        Local img := loader.LoadImage("io/imageloader/red-rect.png")

        AssertNotNull(img)
        AssertNotNull(Image(img))
        AssertEquals(10, img.Width())
        AssertEquals(10, img.Height())
    End

    Method TestLoadImageWithDefaultHandle:Void()
        Local img := loader.LoadImage("io/imageloader/red-rect.png")

        AssertEquals(0.0, img.HandleX())
        AssertEquals(0.0, img.HandleY())

        ' 65536 = Image.DefaultFlags | Image.FullFrame
        ' But it's hardcoded here as Image.FullFrame is private
        AssertEquals(65536, img.Flags())
    End

    Method TestImplementsImageLoader:Void()
        AssertNotNull(ImageLoader(loader))
    End
End
