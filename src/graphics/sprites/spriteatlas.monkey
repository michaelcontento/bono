Strict

Private

Import bono
Import bono.vendor.skn3.xml
Import mojo.app

Public

Class SpriteAtlas
    Private

    Field atlasSprite:Sprite
    Field childSprites:StringMap<Sprite> = New StringMap<Sprite>()
    Field xml:XMLDoc

    Public

    Method New(filename:String)
        LoadXml(filename)
        CheckXml()

        LoadAtlasSprite()
        LoadSprites()

        FreeXmlRecursive(xml)
        xml = Null
    End

    Method Get:Sprite(name:String)
        If Not childSprites.Contains(name)
            Throw New InvalidArgumentException(
                "There is no sprite named: " + name)
        End

        Return childSprites.Get(name).Copy()
    End

    Method GetNames:MapKeys<String, Sprite>()
        Return childSprites.Keys()
    End

    Method Count:Int()
        Return childSprites.Count()
    End

    Method IsEmpty:Bool()
        Return childSprites.IsEmpty()
    End

    Method Contains:Bool(name:String)
        Return childSprites.Contains(name)
    End

    Private

    Method LoadXml:Void(filename:String)
        Local content:String = LoadString(filename)
        If Not content Or content = ""
            Throw New RuntimeException(
                "Unable to load definition from file: " + filename)
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
            Throw New InvalidSpriteAtlasXmlException(
                "Given xml file seems to be empty")
        End

        If xml.name <> "textureatlas"
            Throw New InvalidSpriteAtlasXmlException(
                "First node must be 'TextureAtlas'")
        End

        If Not xml.HasAttribute("imagepath")
            Throw New InvalidSpriteAtlasXmlException(
                "Missing attribute 'imagepath' in 'TextureAtlas' node")
        End
    End

    Method LoadAtlasSprite:Void()
        atlasSprite = New Sprite(xml.GetAttribute("imagepath"))

        If xml.HasAttribute("width")
            Assert.AssertEquals(
                atlasSprite.GetSize().x,
                Float(xml.GetAttribute("width")))
        End

        If xml.HasAttribute("height")
            Assert.AssertEquals(
                atlasSprite.GetSize().y,
                Float(xml.GetAttribute("height")))
        End
    End

    Method LoadSprites:Void()
        Local name:String
        Local src:Vector2D = New Vector2D()
        Local size:Vector2D = New Vector2D()
        Local rotation:Int

        For Local child:XMLNode = EachIn xml.children
            CheckChildXml(child)

            name = child.GetAttribute("n")
            src.x = Int(child.GetAttribute("x"))
            src.y = Int(child.GetAttribute("y"))
            size.x = Int(child.GetAttribute("w"))
            size.y = Int(child.GetAttribute("h"))

            If child.GetAttribute("r", "n") = "y"
                rotation = 90
            Else
                rotation = 0
            End

            childSprites.Set(
                name,
                atlasSprite.GrabSprite(name, src, size, rotation))
        End
    End

    Method CheckChildXml:Void(child:XMLNode)
        If child.name <> "sprite"
            Throw New InvalidSpriteAtlasXmlException(
                "Unknown node '" + child.name + "' found")
        End

        For Local attr:String = EachIn ["n", "x", "y", "w", "h"]
            If Not child.HasAttribute(attr)
                Throw New InvalidSpriteAtlasXmlException(
                    "Missing attribute '" + attr + "' in sprite node")
            End
        End

        If child.HasAttribute("r") And child.GetAttribute("r") <> "y"
            Throw New InvalidSpriteAtlasXmlException(
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
