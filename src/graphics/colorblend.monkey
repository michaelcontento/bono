Strict

Private

Import basedisplayobject
Import bono.src.utils
Import color
Import mojo.graphics

Public

Class ColorBlend Extends BaseDisplayObject
    Method New(color:Color=New Color())
        SetSize(Device.GetSize())
        SetColor(color)
    End

    Method OnRender:Void()
        PushMatrix()
            GetColor().Activate()
            DrawRect(GetPosition().x, GetPosition().y, GetSize().x, GetSize().y)
            GetColor().Deactivate()
        PopMatrix()
    End
End
