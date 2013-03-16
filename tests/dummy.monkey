Strict

Private

Import bono

Public

Class TexturePacker

End

Class AssetLoaderTest Extends AppTestCase
    Method TestDummy:Void()
        Local mgr := New AssetLoader()
        mgr.AddAll()
        mgr.ConfigureAll()
        mgr.PreloadAll()

        Local ball := Sprite.Get("ball")
    End
End
