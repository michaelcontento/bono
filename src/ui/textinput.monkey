Strict

Private

Import bono

Public

Class TextInput Extends Text Implements Keyhandler
    Private

    Field cursorPos:Int

    Public

    Method New(fontName:String, pos:Vector2D=Null)
        Super.New(fontName, pos)
    End

    Method OnKeyDown:Bool(event:KeyEvent)
        Return False
    End

    Method OnKeyPress:Bool(event:KeyEvent)
        Return False
    End

    Method OnKeyUp:Void(event:KeyEvent)
        If event.code > 31 And event.code < 127
            InsertChar(event.char)
            Return True
        Else
            Select event.code
            Case 8
                RemoveChar()
                Return True
            Case 65573
                MoveCursorLeft()
                Return True
            Case 65575
                MoveCursorRight()
                Return True
            End
        End

        Return False
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
