Strict

Private

Import basedisplayobject
Import bono.src.graphics
Import bono.src.kernel
Import bono.src.utils
Import bono.vendor.angelfont

Public

Class Text Extends BaseDisplayObject Implements Renderable
    Private

    Global angelFontStore:StringMap<AngelFont> = New StringMap<AngelFont>()
    Field name:String
    Field _text:String = ""

    Public

    Method New(name:String, pos:Vector2D=Null)
        Self.name = name
        If Not (pos = Null) Then SetPosition(pos)

        If Not angelFontStore.Contains(name)
            angelFontStore.Set(name, New AngelFont())
            angelFontStore.Get(name).LoadFont(name)
        End
    End

    Method OnRender:Void()
        GetColor().Activate()
        angelFont.DrawText(_text, GetPosition().x, GetPosition().y)
        GetColor().Deactivate()
    End

    Method GetTextWidth:Int(char:String)
        Return angelFont.TextWidth(char)
    End

    Method GetTextHeight:Int(char:String)
        Return angelFont.TextHeight(char)
    End

    Method text:Void(newText:String) Property
        _text = newText

        Local width:Float = angelFont.TextWidth(newText)
        Local height:Float = angelFont.TextHeight(newText)
        SetSize(New Vector2D(width, height))
    End

    Method text:String() Property
        Return _text
    End

    Private

    Method angelFont:AngelFont() Property
        Return angelFontStore.Get(name)
    End
End
