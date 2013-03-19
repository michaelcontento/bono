Strict

Private

Import bono
Import mojo

Public

Class AssetLoaderTest Extends TestCase
    Field asset:AssetLoader
    Field loader:MockImageLoader
    Const PREFIX := "io/assetloader/"

    Method SetUp:Void()
        loader = New MockImageLoader()
        asset = New AssetLoader(loader)
    End

    Method TearDown:Void()
        Sprite.imageLoader = Null
        TexturePacker.defaultImageLoader = New MojoImageLoader()
    End

    Method TestContains:Void()
        AssertFalse(asset.Contains("foo"))

        asset.Add("foo")
        AssertTrue(asset.Contains("foo"))
    End

    Method TestAddTexturePacker:Void()
        Local atlasPrefix := PREFIX + "sprite/"
        Local atlas := New TexturePacker(atlasPrefix + "sprite.xml")

        asset.Add(atlas)

        AssertTrue(asset.Contains(atlasPrefix + "sprite/rect-green.png"))
        AssertTrue(asset.Contains(atlasPrefix + "sprite/rect-red.png"))
        AssertTrue(asset.Contains(atlasPrefix + "sprite/rect-blue.png"))

        AssertNotNull(asset.GetImage(atlasPrefix + "sprite/rect-green.png"))
        AssertNotNull(asset.GetImage(atlasPrefix + "sprite/rect-red.png"))
        AssertNotNull(asset.GetImage(atlasPrefix + "sprite/rect-blue.png"))
    End

    Method TestGetNamesShouldStartEmpty:Void()
        Local namesFound := GetNamesAsSet(asset)
        AssertEquals(0, namesFound.Count())
    End

    Method TestGetNames:Void()
        asset.Add("foo")
        asset.Add("bar")

        Local namesFound := GetNamesAsSet(asset)

        AssertEquals(2, namesFound.Count())
        AssertTrue(namesFound.Contains("foo"))
        AssertTrue(namesFound.Contains("bar"))
    End

    Function GetNamesAsSet:StringSet(asset:AssetLoader)
        Local result := New StringSet()
        For Local name := EachIn asset.GetNames()
            result.Insert(name)
        End
        Return result
    End

    Method TestGetImage:Void()
        asset.Add(PREFIX + "rect.png")
        Local img:Image = asset.GetImage(PREFIX + "rect.png")
        AssertNotNull(img)
    End

    Method TestGetSprite:Void()
        asset.Add(PREFIX + "rect.png")
        Local img:Sprite = asset.GetSprite(PREFIX + "rect.png")
        AssertNotNull(img)
    End

    Method TestIgnoreCase:Void()
        Local name := PREFIX + "rect.png"
        asset.Add(name)

        asset.ignoreCase = True
        AssertTrue(asset.Contains(name.ToUpper()))

        asset.ignoreCase = False
        AssertFalse(asset.Contains(name.ToUpper()))
    End

    Method TestIngoreCaseDefaultValue:Void()
        AssertTrue(asset.ignoreCase)
    End

    Method TestIgnoreExt:Void()
        Local name := PREFIX + "rect.png"
        asset.Add(name)

        asset.ignoreExt = True
        AssertTrue(asset.Contains(PREFIX + "rect"))

        asset.ignoreExt = False
        AssertFalse(asset.Contains(PREFIX + "rect"))
    End

    Method TestIngoreExtDefaultValue:Void()
        AssertTrue(asset.ignoreExt)
    End

    Method TestConfigureSprite:Void()
        Sprite.imageLoader = Null

        asset.ConfigureSprite()
        AssertNotNull(Sprite.imageLoader)
    End

    Method TestConfigureTexturePacker:Void()
        TexturePacker.defaultImageLoader = Null

        asset.ConfigureTexturePacker()
        AssertNotNull(TexturePacker.defaultImageLoader)
    End

    Method TestConfigureAll:Void()
        Sprite.imageLoader = Null
        TexturePacker.defaultImageLoader = Null

        asset.ConfigureAll()

        AssertNotNull(Sprite.imageLoader)
        AssertNotNull(TexturePacker.defaultImageLoader)
    End
End
