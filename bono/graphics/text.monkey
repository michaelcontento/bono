Strict

Private

Import align
Import basedisplayobject
Import bono.graphics
Import bono.kernel
Import bono.utils
Import bono.vendor.angelfont

Public

Class Text Extends BaseDisplayObject
    Private

    Global angelFontStore:StringMap<AngelFont> = New StringMap<AngelFont>()
    Field name:String
    Field _text:String = ""

    Public

    Field halign:Int = Align.LEFT
    Field valign:Int = Align.TOP

    Method New(name:String, pos:Vector2D=Null)
        Self.name = name
        If Not (pos = Null) Then SetPosition(pos)

        If Not angelFontStore.Contains(name)
            angelFontStore.Set(name, New AngelFont())
            angelFontStore.Get(name).LoadFont(name)
        End
    End

    Method OnRender:Void()
        Local renderPos:Vector2D = GetPosition().Copy()
        Align.AdjustHorizontal(renderPos, Self, halign)
        Align.AdjustVertical(renderPos, Self, valign)

        GetColor().Activate()
        angelFont.DrawText(_text, renderPos.x, renderPos.y)
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
        If Not angelFont Then Return

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
