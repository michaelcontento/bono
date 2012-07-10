Strict

Private

Import font
Import keyevent
Import vector2d
Import mojo

Public

Class TextInput Extends Font
    Private

    Field cursorPos:Int

    Public

    Method New(fontName:String, pos:Vector2D=Null)
        Super.New(fontName, pos)
    End

    Method OnKeyUp:Void(event:KeyEvent)
        If event.code > 31 And event.code < 127
            InsertChar(event.char)
        Else
            Select event.code
            Case 8
                RemoveChar()
            Case 65573
                MoveCursorLeft()
            Case 65575
                MoveCursorRight()
            End
        End
    End

    Private

    Method MoveCursorLeft:Void()
        If cursorPos <= 0 Then Return
        cursorPos -= 1
    End

    Method MoveCursorRight:Void()
        If cursorPos >= text.Length() Then Return
        cursorPos += 1
    End

    Method InsertChar:Void(char:String)
        text = text[0..cursorPos] + char + text[cursorPos..text.Length()]
        MoveCursorRight()
    End

    Method RemoveChar:Void()
        If text.Length() = 0 Or cursorPos = 0 Then Return

        text = text[0..cursorPos - 1] + text[cursorPos..text.Length()]
        MoveCursorLeft()
    End
End
