Strict

Import mojo.graphics
Import bono

Class Handler Extends Partial
    Private

    Field lastTouchDown:TouchEvent
    Field lastTouchMove:TouchEvent
    Field lastTouchUp:TouchEvent
    Field lastKeyDown:KeyEvent
    Field lastKeyPress:KeyEvent
    Field lastKeyUp:KeyEvent

    Public

    Method OnRender:Void()
        Cls()

        SetColor(255, 0, 0)
        If lastTouchDown Then RenderTouch(lastTouchDown)

        SetColor(0, 255, 0)
        If lastTouchMove Then RenderTouch(lastTouchMove)

        SetColor(0, 0, 255)
        If lastTouchUp Then RenderTouch(lastTouchUp)

        SetColor(255, 255, 255)
        If lastKeyDown  Then DrawText(" lastKeyDown: " + lastKeyDown.code,  10, 10)
        If lastKeyPress Then DrawText("lastKeyPress: " + lastKeyPress.code, 10, 25)
        If lastKeyUp    Then DrawText("   lastKeyUp: " + lastKeyUp.code,    10, 40)
    End

    Method OnTouchDown:Void(touch:TouchEvent)
        lastTouchDown = touch
    End

    Method OnTouchMove:Void(touch:TouchEvent)
        lastTouchMove = touch
    End

    Method OnTouchUp:Void(touch:TouchEvent)
        lastTouchUp = touch
    End

    Method OnKeyUp:Void(event:KeyEvent)
        lastKeyUp = event
    End

    Method OnKeyPress:Void(event:KeyEvent)
        lastKeyPress = event
    End

    Method OnKeyDown:Void(event:KeyEvent)
        lastKeyDown = event
    End

    Private

    Method RenderTouch:Void(touch:TouchEvent)
        SetAlpha(0.7)
        Local lastPos:Vector2D
        For Local pos:Vector2D = EachIn touch.positions
            If lastPos Then DrawLine(lastPos.x, lastPos.y, pos.x, pos.y)
            lastPos = pos
        End

        SetAlpha(1)
        DrawCircle(touch.pos.x, touch.pos.y, 4)
        DrawText(" id: " + touch.id    , touch.pos.x + 10, touch.pos.y +  0)
        DrawText("finger: " + touch.finger, touch.pos.x + 70, touch.pos.y +  0)
        DrawText("pos: " + touch.pos   , touch.pos.x + 10, touch.pos.y + 15)
    End
End

Function Main:Int()
    Local director:Director = New Director(640, 480)
    director.inputController.trackKeys = True
    director.inputController.trackTouch = True
    director.inputController.touchRetainSize = 250
    director.inputController.touchMinDistance = 0
    director.Run(New Handler())

    Return 0
End
