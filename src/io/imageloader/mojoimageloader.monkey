Strict

Private

Import bono
Import mojo

Public

Class MojoImageLoader Implements ImageLoader
    Method LoadImage:Image(file:String)
        Local img := mojo.graphics.LoadImage(file)

        If Not img
            Throw New RuntimeException("Unable to load image file: " + file)
        End

        Return img
    End
End
