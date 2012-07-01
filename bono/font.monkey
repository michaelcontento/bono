Strict

Private

Import baseobject
Import color
Import director
Import mojo
Import vector2d
Import vendor.angelfont

Public

Class Font Extends BaseObject
    Private

    Field _align:Int = LEFT
    Field _text:String
    Field font:AngelFont
    Field fontName:String
    Field recalculateSize:Bool

    Public

    Const LEFT:Int = AngelFont.ALIGN_LEFT
    Const CENTER:Int = AngelFont.ALIGN_CENTER
    Const RIGHT:Int = AngelFont.ALIGN_RIGHT
    Field color:Color

    Method New(fontName:String, pos:Vector2D=Null)
        If pos = Null Then pos = New Vector2D(0, 0)

        Self.fontName = fontName
        Self.pos = pos
    End

    Method OnCreate:Void(director:Director)
        font = New AngelFont()
        font.LoadFont(fontName)

        If recalculateSize
            recalculateSize = False
            text = _text
        End

        Super.OnCreate(director)
    End

    Method OnRender:Void()
        If color Then color.Activate()
        font.DrawText(_text, pos.x, pos.y, _align)
        If color Then color.Deactivate()
    End

    Method text:Void(newText:String) Property
        _text = newText
        If Not font
            recalculateSize = True
            Return
        End

        Local width:Int = font.TextWidth(newText)
        Local height:Int = font.TextHeight(newText)
        size = New Vector2D(width, height)
    End

    Method text:String() Property
        Return _text
    End

    Method align:Void(newAlign:Int) Property
        Select newAlign
        Case LEFT, CENTER, RIGHT
            _align = newAlign
        Default
            Error("Invalid align value specified.")
        End
    End

    Method align:Int() Property
        Return _align
    End
End
