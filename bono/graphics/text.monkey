Strict

Private

Import align
Import basedisplayobject
Import bono.graphics
Import bono.kernel
Import bono.utils
Import bono.vendor.angelfont

Public

Class Text Extends BaseDisplayObject Implements AppObserver
    Private

    Global angelFontStore:StringMap<AngelFont> = New StringMap<AngelFont>()
    Field name:String
    Field _text:String = ""

    Public

    Field halign:Int = Align.LEFT
    Field valign:Int = Align.TOP

    Method New(name:String, pos:Vector2D=Null)
        If pos = Null Then pos = New Vector2D(0, 0)

        Self.name = name
        Self.pos = pos

        If Not angelFontStore.Contains(name)
            angelFontStore.Set(name, New AngelFont())
            angelFontStore.Get(name).LoadFont(name)
        End
    End

    Method OnLoading:Void()
    End

    Method OnRender:Void()
        Local renderPos:Vector2D = pos.Copy()
        Align.AdjustHorizontal(renderPos, Self, halign)
        Align.AdjustVertical(renderPos, Self, valign)

        If color Then color.Activate()
        angelFont.DrawText(_text, renderPos.x, renderPos.y)
        If color Then color.Deactivate()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnUpdate:Void(deltaTimer:DeltaTimer)
    End

    Method TextWidth:Int(char:String)
        Return angelFont.TextWidth(char)
    End

    Method TextHeight:Int(char:String)
        Return angelFont.TextHeight(char)
    End

    Method text:Void(newText:String) Property
        _text = newText
        If Not angelFont Then Return

        Local width:Float = angelFont.TextWidth(newText)
        Local height:Float = angelFont.TextHeight(newText)
        size = New Vector2D(width, height)
    End

    Method text:String() Property
        Return _text
    End

    Private

    Method angelFont:AngelFont() Property
        Return angelFontStore.Get(name)
    End
End
