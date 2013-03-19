Strict

Private

Import bono
Import mojo

Public

Class TexturePackerTest Extends AppTestCase
    Field mockLoader:MockImageLoader

    Method SetUp:Void()
        mockLoader = New MockImageLoader()
        TexturePacker.defaultImageLoader = mockLoader
    End

    Method TearDown:Void()
        TexturePacker.defaultImageLoader = New MojoImageLoader()
    End

    Method TestWithExampleSprite:Void()
        Local tp := New TexturePacker(
            "io/texturepacker/sprite/sprite.xml",
            New MojoImageLoader())

        RenderAndCompare(tp, "rect-green.png")

        MarkTestSkipped("This should work but AssertScreenEquals seems to be buggy")
        ' RenderAndCompare(tp, "rect-blue.png")
        ' RenderAndCompare(tp, "rect-red.png")
    End

    Method TestGetFilename:Void()
        Local file := GetXmlFile("valid-1x1")
        Local tp := New TexturePacker(file)

        AssertEquals(file, tp.GetFilename())
    End

    Method TestGetRootImage:Void()
        Local file := GetXmlFile("valid-1x1")
        Local tp := New TexturePacker(file)

        AssertNotNull(tp.GetRootImage())
        AssertEquals(1, tp.GetRootImage().Width())
        AssertEquals(1, tp.GetRootImage().Height())
    End

    Method RenderAndCompare:Void(tp:TexturePacker, file:String)
        Cls()
        DrawImage(tp.Get(file), 0, 0)
        AssertScreenEquals("io/texturepacker/sprite/" + file)
    End

    Method TestFailOnWrongConstructor:Void()
        Local caught := False
        Try
            New TexturePacker()
        Catch ex:InvalidConstructorException
            caught = True
        End
        If Not caught Then Fail("InvalidConstructorException expected")
    End

    Method TestExceptionOnInvalidFile:Void()
        Local caught := False
        Try
            New TexturePacker("some-invalid-filename")
        Catch ex:RuntimeException
            caught = True
        End
        If Not caught Then Fail("RuntimeException expected")
    End

    Method TestExceptionOnWrongRootImageWidht:Void()
        mockLoader.size.x = 2
        LoadAndExpectAssertionExeption(GetXmlFile("valid-1x1"))
    End

    Method TestExceptionOnWrongRootImageHeight:Void()
        mockLoader.size.y = 2
        LoadAndExpectAssertionExeption(GetXmlFile("valid-1x1"))
    End

    Method TestRootImageWidthAndHeightAreOptional:Void()
        mockLoader.size.Set(2, 2)
        New TexturePacker(GetXmlFile("valid-no-root-image-dimension"))
    End

    Method TestFailOnInvalidXml:Void()
        Local files := ["unknown-child-node", "missing-attr-n",
            "missing-attr-x", "missing-attr-y",
            "missing-attr-w", "missing-attr-h",
            "todo-attr-ox", "todo-attr-oy",
            "todo-attr-ow", "todo-attr-oh",
            "todo-attr-r", "wrong-value-r"]

        For Local file := EachIn files
            LoadAndExpectXmlExeption(GetXmlFile(file))
        End
    End

    Method GetXmlFile:String(name:String)
        Return "io/texturepacker/" + name + ".xml"
    End

    Method LoadAndExpectAssertionExeption:Void(file:String)
        Local caught := False
        Try
            New TexturePacker(file)
        Catch ex:AssertionFailedException
            caught = True
        End

        If Not caught
            Fail("AssertionFailedException expected for file " + file)
        End
    End

    Method LoadAndExpectXmlExeption:Void(file:String)
        Local caught := False
        Try
            New TexturePacker(file)
        Catch ex:InvalidXmlException
            caught = True
        End

        If Not caught
            Fail("InvalidXmlException expected for file " + file)
        End
    End
End
