Strict

Import bono
Import mojo.graphics

Class Handler Implements AppObserver, TouchObserver, KeyObserver
    Private

    Field lastTouchDown:TouchEvent
    Field lastTouchMove:TouchEvent
    Field lastTouchUp:TouchEvent
    Field lastKeyDown:KeyEvent
    Field lastKeyPress:KeyEvent
    Field lastKeyUp:KeyEvent

    Public

    Method OnCreate:Void()
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

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
    Local handler:Handler = New Handler()

    Local touchEmitter:TouchEmitter = New TouchEmitter()
    touchEmitter.AddObserver(handler)
    touchEmitter.retainSize = 250
    touchEmitter.minDistance = 0

    Local keyEmitter:KeyEmitter = New KeyEmitter()
    keyEmitter.AddObserver(handler)

    Local appEmitter:AppEmitter = New AppEmitter()
    appEmitter.AddObserver(touchEmitter)
    appEmitter.AddObserver(keyEmitter)
    appEmitter.AddObserver(handler)
    appEmitter.Run()

    Return 0
End
