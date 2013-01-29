Strict

Private

Import bono

Public

Class GuiButton Extends GuiBase Implements Touchable
    Private

    Global someButtonPressed:Bool
    Field isPressed:Bool

    Public

    Field trackLeavingMoves:Bool

    Method OnTouchDown:Void(event:TouchEvent)
        If someButtonPressed Then Return

        Local realPos:Vector2D = Director.TranslateSpace(event.pos)
        If Not Collide(realPos) Then Return

        someButtonPressed = True
        isPressed = True
        OnButtonDown(event)
    End

    Method OnTouchMove:Void(event:TouchEvent)
        If Not isPressed Then Return

        If Not trackLeavingMoves
            Local realPos:Vector2D = Director.TranslateSpace(event.pos)
            If Not Collide(realPos) Then Return
        End

        OnButtonMove(event)
    End

    Method OnTouchUp:Void(event:TouchEvent)
        If Not isPressed Then Return

        someButtonPressed = False
        isPressed = False

        Local realPos:Vector2D = Director.TranslateSpace(event.pos)
        If Not Collide(realPos) Then Return

        OnButtonUp(event)
    End

    Method OnButtonDown:Void(event:TouchEvent)
    End

    Method OnButtonMove:Void(event:TouchEvent)
    End

    Method OnButtonUp:Void(event:TouchEvent)
    End
End
