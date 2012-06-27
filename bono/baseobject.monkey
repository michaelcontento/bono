Strict

Private

Import director
Import directorevents
Import fanout
Import keyevent
Import nullobject
Import positionable
Import sizeable
Import touchevent
Import vector2d

Public

Class BaseObject Extends NullObject Implements Positionable, Sizeable Abstract
    Private

    Field _pos:Vector2D
    Field _center:Vector2D
    Field _size:Vector2D
    Field _layer:FanOut = New FanOut()

    Public

    Method CenterX:Void(entity:Sizeable)
        pos.x = entity.center.x - center.x
    End

    Method CenterY:Void(entity:Sizeable)
        pos.y = entity.center.y - center.y
    End

    Method Center:Void(entity:Sizeable)
        pos = entity.center.Copy().Sub(center)
    End

    Method OnCreate:Void(director:Director)
        Super.OnCreate(director)
        _layer.OnCreate(director)
    End

    Method OnLoading:Void()
        _layer.OnLoading()
    End

    Method OnUpdate:Void(delta:Float)
        _layer.OnUpdate(delta)
    End

    Method OnRender:Void()
        _layer.OnRender()
    End

    Method OnSuspend:Void()
        _layer.OnSuspend()
    End

    Method OnResume:Void(delta:Int)
        _layer.OnResume(delta)
    End

    Method OnKeyDown:Void(event:KeyEvent)
        _layer.OnKeyDown(event)
    End

    Method OnKeyPress:Void(event:KeyEvent)
        _layer.OnKeyPress(event)
    End

    Method OnKeyUp:Void(event:KeyEvent)
        _layer.OnKeyUp(event)
    End

    Method OnTouchDown:Void(event:TouchEvent)
        _layer.OnTouchDown(event)
    End

    Method OnTouchMove:Void(event:TouchEvent)
        _layer.OnTouchMove(event)
    End

    Method OnTouchUp:Void(event:TouchEvent)
        _layer.OnTouchUp(event)
    End

    Method layer:FanOut() Property
        Return _layer
    End

    Method pos:Vector2D() Property
        If _pos = Null Then Error("Position not set yet.")
        Return _pos
    End

    Method pos:Void(newPos:Vector2D) Property
        _pos = newPos
    End

    Method size:Vector2D() Property
        If _size = Null Then Error("Size not set yet.")
        Return _size
    End

    Method size:Void(newSize:Vector2D) Property
        _size = newSize
        _center = newSize.Copy().Div(2)
    End

    Method center:Vector2D() Property
        If _center = Null Then Error("No size set and center therefore unset.")
        Return _center
    End
End
