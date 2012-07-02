Strict

Private

Import mojo.graphics

Public

Interface Fader
    Method OnPreRender:Void(value:Float)
    Method OnPostRender:Void(value:Float)
End

Class FaderAlpha Implements Fader
    Method OnPreRender:Void(value:Float)
        PushMatrix()
            SetAlpha(value)
    End

    Method OnPostRender:Void(value:Float)
        PopMatrix()
    End
End
