Strict

Private

Import bono
Import mojo

Public

Class MockImageLoader Implements ImageLoader
    Field size := New Vector2D(1, 1)
    Field lastFile:String

    Method LoadImage:Image(file:String)
        lastFile = file
        Return CreateImage(size.x, size.y)
    End
End
