# ImageLoader

Defines how to load images from various sources. All implementations must
throw an exception, if they were unable to load the requested image!

## MojoImageLoader

Well .. it's just a wrapper around LoadImage.

```monkey
Local loader := New MojoImageLoader()
DrawImage(loader.Get("image.png"), 0, 0)
```

## Cached

Instantiate with another `ImageLoader` and all requests are cached. This is
usefull even for `MojoImageLoader` as `LoadImage` is expensive on Android.

```monkey
Local loader := New CachedImageLoader(New MojoImageLoader())
DrawImage(loader.Get("image.png"), 0, 0)
```

## Mock

A simple mock that returns new images created with `CreateImage`. Used in some
tests and not very usefull in production code. Use `size` to configure the size
of the created images.

```monkey
Local loader := New MockImageLoader()
DrawImage(loader.Get("image.png"), 0, 0)

Print loader.lastFile
' >>> image.png

Print loader.size
' >>> (1, 1)
```
