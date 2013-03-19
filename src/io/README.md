# IO

## AssetLoader

A simple manager for all your assets. You can add single images or whole
TexturePacker instances and access them through one interface. This also helps
you to prototype your app with single images and switch to image sprites later.

```monkey
' easy configuration
Local assets := New AssetLoader()
assets.Add("image.png")
asssts.Add("folder/another-image.png")

' easy access
Local img:Image = assets.GetImage("image.png")
Local spr:Sprite = assets.GetSprite("image.png")
```

### Configure

You can use `ConfigureSprite`, `ConfigureTexturePacker` or `ConfigureAll` to
inject the given `AssetLoader` instance as default `ImageLoader` into `Sprite`
and/or `TexturePacker`. They are all loose parts but it's a good idea to use
them together.

```monkey
Local assets := New AssetLoader()
assets.ConfigureAll()
assets.Add("image.png")

' this will now use the same ImageLoader as asset
assets.Add(New TexturePacker("sprite.xml"))

' nice sugar, huh? ;)
Local sp := Sprite.Get("image")
```

### TexturePacker

Support for `TexturePacker` sprites is already baked in. But keep in mind that
all image paths are prefixed with the name of the xml file. Just have a look at
this short example and everything should be clear:

```monkey
assets.Add(New TexturePacker("mysprite.xml"))
Local img:Image = assets.GetImage("mysprite/spriteimg.png")

assets.Add(New TexturePacker("path/sprite.xml"))
Local img:Image = assets.GetImage("path/sprite/img-inside-sprite.png")
```

### IgnoreExt

This flag is enabled per default and allows you to skip the file extension while
accessing files from the `AssetLoader`. Why should you do this? Or why is this
helpful? Because you can simple change file formats without touching code.

```monkey
assets.Add("will-be-changed-to-jpg-in-the-future.png")
Local img:Image = assets.GetImage("will-be-changed-to-jpg-in-the-future")

' but this feature can be disabled
assets.ignoreExt = False

' now this will throw an exception
Local img:Image = assets.GetImage("will-be-changed-to-jpg-in-the-future")
```

### IgnoreCase

This flag is also enabled per default.

```monkey
assets.Add("lower-case.png")
Local img:Image = assets.GetImage("LOWER-case.png")

' but this feature can be disabled
assets.ignoreCase = False

' now this will throw an exception
Local img:Image = assets.GetImage("LOWER-case.png")
```

## TexturePacker

Load sprite images created with [TexturePacker][] saved in the "generic XML"
format. Features that haven't been implemented yet:

1. Rotation
1. Trim

Here is a short example:

```monkey
Local tp := New TexturePacker("mysprite.xml")
DrawImage(tp.Get("image.png"), 0, 0)
```

The current default `ImageLoader` is set to `MojoImageLoader` and can be set as
second constructor argument or, as default for all new instances, via
`TexturePacker.defaultImageLoader`.

```monkey
' as argument
Local tp := New TexturePacker("mysprite.xml", New MojoImageLoader())

' or as default value for all following instances
TexturePacker.defaultImageLoader = New MojoImageLoader()
Local tp := New TexturePacker("mysprite.xml")
```

## Persitable

See [StateStore][].

## StateStore

Can be used to store something that implements `Persitable` via `SaveState`
and `LoadState`.

```monkey
Class MyObj Implements Persistable
    Field value := ""

    Method FromString:Void(data:String)
        value = data
    End

    Method ToString:String()
        Return value
    End
End

Local myObj := New MyObj()
myObj.value = "Hello World"
StateStore.Save(myObj)

myObj.value = "Goodbye"
StateStore.Load(myObj)
Print myObj.value
' >> "Hello World"
```

 [StateStore]: #statestore
 [TexturePacker]: http://www.codeandweb.com/texturepacker
