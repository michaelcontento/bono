Strict

Private

Import bono
Import mojo

Public

Class MockImageLoader Implements ImageLoader
    Field size := New Vector2D(1, 1)

    Method LoadImage:Image(file:String)
        Return CreateImage(size.x, size.y)
    End
End
