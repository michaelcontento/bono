Strict

Private

Import bono
Import mojo
Import os

Public

Class AssetLoader Implements ImageLoader
    Private

    Field imageLoader:ImageLoader
    Field names := New StringMap<Int>
    Field textures := New StringMap<TexturePacker>

    Global preloadColor := New Color(0, 0, 0, 0)
    Const TYPE_IMAGE := 0
    Const TYPE_TEXTURE := 1

    Public

    Field ignoreCase := True
    Field ignoreExt := True

    Method New(imageLoader:ImageLoader=Null)
        If Not imageLoader
            imageLoader = New CachedImageLoader(New MojoImageLoader())
        End

        Self.imageLoader = imageLoader
    End

    Method Contains:Bool(name:String)
        Try
            ResolveNameToFile(name)
            Return True
        Catch ex:InvalidArgumentException
        End
        Return False
    End

    Method GetNames:MapKeys<String, Int>()
        Return names.Keys()
    End

    Method GetImage:Image(name:String)
        Local realName := ResolveNameToFile(name)
        Local mode := names.Get(realName)

        If mode = TYPE_IMAGE Then Return GetImageImage(realName)
        Return GetImageTexture(realName)
    End

    Method GetSprite:Sprite(name:String)
        Return New Sprite(GetImage(name))
    End

    ' --- Data import

    Method Add:Void(file:String)
        ' TODO already exists?
        names.Set(file, TYPE_IMAGE)
    End

    Method Add:Void(atlas:TexturePacker, namespace:String="")
        ' TODO already exists?
        Local base := namespace
        If base = "" Then base = TrimExt(atlas.GetFilename())
        textures.Set(base, atlas)

        For Local name := EachIn atlas.GetNames()
            names.Set(base + "/" + name, TYPE_TEXTURE)
        End
    End

    ' --- ImageLoader interface

    Method LoadImage:Image(file:String)
        Return GetImage(file)
    End

    ' --- Preload

    Method Preload:Void(img:Image)
        preloadColor.Activate()
        DrawImage(img, 0, 0)
        preloadColor.Deactivate()
    End

    Method PreloadAll:Void()
        For Local name := EachIn GetNames()
            If names.Get(name) <> TYPE_IMAGE Then Continue
            Preload(GetImage(name))
        End

        For Local name := EachIn textures.Keys()
            Preload(textures.Get(name).GetRootImage())
        End
    End

    ' --- Configure

    Method ConfigureAll:Void()
        ConfigureSprite()
        ConfigureTexturePacker()
    End

    Method ConfigureSprite:Void()
        Sprite.imageLoader = Self
    End

    Method ConfigureTexturePacker:Void()
        TexturePacker.defaultImageLoader = Self
    End

    Private

    Method ResolveNameToFile:String(name:String)
        name = ConvertCase(name)
        For Local rawImageName := EachIn GetNames()
            Local imageName := ConvertCase(rawImageName)
            If imageName = name Then Return rawImageName
            If ignoreExt And TrimExt(imageName) = name Then Return rawImageName
        End

        Throw New InvalidArgumentException("There is no asset named " + name)
    End

    Method GetImageImage:Image(name:String)
        Return LoadImageRaw(name)
    End

    Method GetImageTexture:Image(name:String)
        For Local node := EachIn textures
            If Not name.StartsWith(node.Key()) Then Continue

            Local atlas := node.Value()
            Local atlasName := name[node.Key().Length() + 1..]
            If atlas.Contains(atlasName) Then Return atlas.Get(atlasName)
        End

        Return Null
    End

    Method ConvertCase:String(in:String)
        If ignoreCase Then Return in.ToLower()
        Return in
    End

    Function TrimExt:String(in:String)
        Local pos := in.FindLast(".")
        If pos <> -1 Then Return in[..pos]
        Return in
    End

    Method LoadImageRaw:Image(file:String)
        Return imageLoader.LoadImage(file)
    End
End
