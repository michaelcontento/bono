Strict

Private

Import bono
Import mojo

Public

Class CachedImageLoader Implements ImageLoader
    Private

    Global cache := New StringMap<Image>
    Field provider:ImageLoader

    Public

    Method New()
        Throw New InvalidConstructorException("use New(ImageLoader)")
    End

    Method New(provider:ImageLoader)
        Self.provider = provider
    End

    Method LoadImage:Image(file:String)
        If Not cache.Contains(file)
            cache.Set(file, provider.LoadImage(file))
        End

        Return cache.Get(file)
    End

    Method ClearCache:Void()
        cache.Clear()
    End
End
