Strict

Private

Import bono
Import mojo

Class DummyImageLoader Implements ImageLoader
    Field lastFile:String
    Field nextImage:Image

    Method LoadImage:Image(file:String)
        lastFile = file
        Return nextImage
    End
End

Public

Class CachedImageLoaderTest Extends TestCase
    Field cache:CachedImageLoader
    Field dummy:DummyImageLoader

    Method SetUp:Void()
        dummy = New DummyImageLoader()
        cache = New CachedImageLoader(dummy)
    End

    Method TestFailOnWrongConstructor:Void()
        Local caught := False
        Try
            New CachedImageLoader()
        Catch ex:InvalidConstructorException
            caught = True
        End
        If Not caught Then Fail("InvalidConstructorException expected")
    End

    Method TestShouldPassTheFilenameUnchanged:Void()
        Local file := "name-WITH-%^&-fancy-STUFF"
        cache.LoadImage(file)

        AssertEquals(file, dummy.lastFile)
    End

    Method TestShouldReturnTheParentResult:Void()
        dummy.nextImage = CreateImage(1, 1)
        AssertIdentical(dummy.nextImage, cache.LoadImage(""))

        Local wrongImage := CreateImage(1, 1)
        AssertNotIdentical(wrongImage, cache.LoadImage(""))
    End

    Method TestImplementsImageLoader:Void()
        AssertNotNull(ImageLoader(cache))
    End
End
