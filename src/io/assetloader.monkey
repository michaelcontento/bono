Strict

Private

Import bono

Public

Class AssetLoader Implements ImageLoader
    Private

    Field imageLoader:ImageLoader
    Field names := New StringMap<String>

    Public

    Field ignoreCase := True

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
        Catch ex:Exception
        End
        Return False
    End

    Method GetNames:MapKeys<String, String>()
        Return names.Keys()
    End

    Method GetImage:Image(name:String)
        Return LoadImage(ResolveNameToFile(name))
    End

    Method GetSprite:Sprite(name:String)
        Return New Sprite(GetImage(name))
    End

    ' --- Data import

    Method Add:Void(file:String)
        ' TODO: Check if file exists
    End

    Method Add:Void(atlas:TexturePacker, namespace:String="")
        ' TODO: Implement this
    End

    Method AddPath:Void(path:String, recursive:Bool=True)
        ' TODO: Implement this
    End

    Method AddAll:Void()
        AddPath("", True)
    End

    ' --- ImageLoader interface

    Method LoadImage:Image(file:String)
        Return imageLoader.LoadImage(file)
    End

    ' --- Preload

    Method Preload:Void(name:String)
        preloadColor.Activate()
        DrawImage(LoadImage(name, 0, 0))
        preloadColor.Deactivate()
    End

    Method PreloadAll:Void()
        For Local name := EachIn GetNames()
            Preload(name)
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
        ' TODO: Implement this
    End

    Method GetShortName:String(in:String)
        Local parts := in.Split(".")
        Return ".".Join(parts[..parts.Length() - 1])
    End

    Method ConvertCase:String(in:String)
        If ignoreCase Then Return in.ToLower()
        Return in
    End
End
