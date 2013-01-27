Strict

Private

Import bono.src.graphics.colors
Import bono.src.kernel
Import color
Import mojo.graphics

Public

Class ColorBlend Extends BaseDisplayObject Implements Renderable
    Method New(color:Color=New Color())
        SetSize(Director.Shared().GetApp().GetVirtualSize())
        SetColor(color)
    End

    Method OnRender:Void()
        GetColor().Activate()
        DrawRect(GetPosition().x, GetPosition().y, GetSize().x, GetSize().y)
        GetColor().Deactivate()
    End
End
