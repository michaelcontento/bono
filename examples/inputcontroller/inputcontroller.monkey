Strict

Import mojo.graphics
Import bono

Class Handler Extends Partial
    Private

    Field lastTouchDown:TouchEvent
    Field lastTouchMove:TouchEvent
    Field lastTouchUp:TouchEvent

    Public

    Method OnRender:Void()
        Cls()

        SetColor(255, 0, 0)
        If lastTouchDown Then RenderTouch(lastTouchDown)

        SetColor(0, 255, 0)
        If lastTouchMove Then RenderTouch(lastTouchMove)

        SetColor(0, 0, 255)
        If lastTouchUp Then RenderTouch(lastTouchUp)
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

    Private

    Method RenderTouch:Void(touch:TouchEvent)
        SetAlpha(0.2)
        For Local pos:Vector2D = EachIn touch.positions
            DrawCircle(pos.x, pos.y, 10)
        End

        SetAlpha(1)
        DrawCircle(touch.pos.x, touch.pos.y, 10)
    End
End

Function Main:Int()
    Local director:Director = New Director(640, 480)
    director.Run(New Handler())

    Return 0
End
