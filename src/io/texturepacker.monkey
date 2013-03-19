Strict

Private

Import bono
Import bono.vendor.skn3.xml
Import mojo
Import os

Public

Class TexturePacker
    Private

    Field loader:ImageLoader
    Field rootImage:Image
    Field childImages := New StringMap<Image>
    Field xml:XMLDoc
    Field xmlFilename:String

    Public

    Global defaultImageLoader:ImageLoader = New MojoImageLoader()

    Method New()
        Throw New InvalidConstructorException("use New(String)")
    End

    Method New(filename:String, loader:ImageLoader=Null)
        If Not loader Then loader = defaultImageLoader
        Self.loader = loader

        xmlFilename = filename
        LoadXml()
        CheckXml()

        LoadRootImage()
        LoadChildImages()

        FreeXmlRecursive(xml)
        xml = Null
    End

    Method Get:Image(name:String)
        If Not childImages.Contains(name)
            Throw New InvalidArgumentException(
                "There is no sprite named: " + name)
        End

        Return childImages.Get(name)
    End

    Method GetNames:MapKeys<String, Sprite>()
        Return childImages.Keys()
    End

    Method Count:Int()
        Return childImages.Count()
    End

    Method IsEmpty:Bool()
        Return childImages.IsEmpty()
    End

    Method Contains:Bool(name:String)
        Return childImages.Contains(name)
    End

    Method GetFilename:String()
        Return xmlFilename
    End

    Method GetRootImage:Image()
        Return rootImage
    End

    Private

    Method LoadXml:Void()
        Local content:String = mojo.app.LoadString(xmlFilename)
        If Not content Or content = ""
            Throw New RuntimeException(
                "Unable to load definition from file: " + xmlFilename)
        End

        Local error:XMLError = New XMLError
        xml = ParseXML(content, error)

        If Not xml Or error.error
            Throw New RuntimeException(
                "Unable to parse XML: " + error)
        End
    End

    Method CheckXml:Void()
        If Not xml.HasChildren()
            Throw New InvalidXmlException(
                "Given xml file seems to be empty")
        End

        If xml.name <> "textureatlas"
            Throw New InvalidXmlException(
                "First node must be 'TextureAtlas'")
        End

        If Not xml.HasAttribute("imagepath")
            Throw New InvalidXmlException(
                "Missing attribute 'imagepath' in 'TextureAtlas' node")
        End
    End

    Method LoadRootImage:Void()
        Local file := xml.GetAttribute("imagepath")
        rootImage = loader.LoadImage(ExtractDir(xmlFilename) + "/" + file)

        If xml.HasAttribute("width")
            Assert.AssertEquals(
                rootImage.Width(),
                Int(xml.GetAttribute("width")))
        End

        If xml.HasAttribute("height")
            Assert.AssertEquals(
                rootImage.Height(),
                Int(xml.GetAttribute("height")))
        End
    End

    Method LoadChildImages:Void()
        Local name:String
        Local src:Vector2D = New Vector2D()
        Local size:Vector2D = New Vector2D()

        For Local child:XMLNode = EachIn xml.children
            CheckChildXml(child)

            name = child.GetAttribute("n")
            src.x = Int(child.GetAttribute("x"))
            src.y = Int(child.GetAttribute("y"))
            size.x = Int(child.GetAttribute("w"))
            size.y = Int(child.GetAttribute("h"))

            childImages.Set(
                name,
                rootImage.GrabImage(src.x, src.y, size.x, size.y))
        End
    End

    Method CheckChildXml:Void(child:XMLNode)
        If child.name <> "sprite"
            Throw New InvalidXmlException(
                "Unknown node '" + child.name + "' found")
        End

        For Local attr:String = EachIn ["n", "x", "y", "w", "h"]
            If Not child.HasAttribute(attr)
                Throw New InvalidXmlException(
                    "Missing attribute '" + attr + "' in sprite node")
            End
        End

        For Local attr:String = EachIn ["oX", "oY", "oW", "oH", "r"]
            If child.HasAttribute(attr)
                Throw New InvalidXmlException(
                    "Attribute '" + attr + "' found but not yet implemented")
            End
        End

        If child.HasAttribute("r") And child.GetAttribute("r") <> "y"
            Throw New InvalidXmlException(
                "Invalid value for attribute 'r' in sprite node found")
        End
    End

    Method FreeXmlRecursive:Void(xml:XMLNode)
        If Not xml Then Return

        For Local child:XMLNode = EachIn xml.children
            FreeXmlRecursive(child)
            xml.RemoveChild(child)
        End

        xml.ClearAttributes()
        xml.ClearChildren()
    End
End
