Strict

Import mojo.graphics
Import bono

Class PlainScene Extends Partial
    Method OnRender:Void()
        Cls(0, 255, 0)
        DrawText("PLAIN", 0, 0)
    End

    Method OnTouchDown:Void(touch:TouchEvent)
        Router(director.handler).Goto("advanced")
    End
End

Class AdvancedScene Extends Partial Implements RouterEvents
    Method OnRender:Void()
        Cls(255, 0, 0)
        DrawText("ADVANCED", 0, 0)
    End

    Method OnTouchDown:Void(touch:TouchEvent)
        Router(director.handler).Goto("plain")
    End

    Method OnEnter:Void()
        Print("scene enter")
    End

    Method OnLeave:Void()
        Print("scene leave")
    End
End

Function Main:Int()
    Local router:Router = New Router()
    router.Add("plain", New PlainScene())
    router.Add("advanced", New AdvancedScene())
    router.Goto("plain")

    Local director:Director = New Director(640, 480)
    director.Run(router)

    Return 0
End
