Strict

Private

Import basedisplayobject
Import bono.utils
Import color
Import mojo.graphics

Public

Class ColorBlend Extends BaseDisplayObject
    Method New(color:Color=New Color())
        size = Device.GetSize()
        Self.color = color
    End

    Method OnRender:Void()
        PushMatrix()
            color.Activate()
            DrawRect(pos.x, pos.y, size.x, size.y)
            color.Deactivate()
        PopMatrix()
    End
End
