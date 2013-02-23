Strict

Private

Import bono

Public

Class GuiCallbackButton Extends GuiButton
    Private

    Field callback:GuiButtonCallback
    Field name:String

    Public

    Method New(name:String, callback:GuiButtonCallback)
        Self.callback = callback
        Self.name = name

        FailOnOnlyBaseInterface()
    End

    Method OnButtonDown:Void(event:TouchEvent)
        If GuiButtonDownCallback(callback)
            GuiButtonDownCallback(callback).OnButtonDownCallback(name, event)
        End
        Super.OnButtonDown(event)
    End

    Method OnButtonMove:Void(event:TouchEvent)
        If GuiButtonMoveCallback(callback)
            GuiButtonMoveCallback(callback).OnButtonMoveCallback(name, event)
        End
        Super.OnButtonMove(event)
    End

    Method OnButtonUp:Void(event:TouchEvent)
        If GuiButtonUpCallback(callback)
            GuiButtonUpCallback(callback).OnButtonUpCallback(name, event)
        End
        Super.OnButtonUp(event)
    End

    Private

    Method FailOnOnlyBaseInterface:Void()
        Local down:Bool = (GuiButtonDownCallback(callback) <> Null)
        Local move:Bool = (GuiButtonMoveCallback(callback) <> Null)
        Local up:Bool = (GuiButtonUpCallback(callback) <> Null)

        If Not down And Not move And Not up
            Throw New InvalidArgumentException(
                "Interface GuiButtonCallback is just a compile time check. " +
                "Please use GuiButtonDownCallback, -MoveCallback or " +
                "-UpCallback instead.")
        End
    End
End
