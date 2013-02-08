Strict

Private

Import bono

Public

Class GuiButton Extends GuiBase Implements Touchable, Updateable
    Private

    Field isPressed:Bool
    Field finger:Int
    Field sprite:Sprite

    Public

    Field trackLeavingMoves:Bool

    Method GetSprite:Sprite()
        Return sprite
    End

    Method SetSprite:Void(sprite:Sprite)
        SetColor(sprite.GetColor())
        SetPosition(sprite.GetPosition())
        SetSize(sprite.GetSize())
        Self.sprite = sprite
    End

    Method RemoveSprite:Void()
        If Not sprite Then Return

        Local oldSprite:Sprite = sprite
        sprite = Null

        GetColor().Set(oldSprite.GetColor())
        GetPosition().Set(oldSprite.GetPosition())
        GetSize().Set(oldSprite.GetSize())
    End

    Method SetColor:Void(newColor:Color)
        LockedWithSprite("SetColor")
        Super.SetColor(newColor)
    End

    Method GetColor:Color()
        LockedWithSprite("GetColor")
        Return Super.GetColor()
    End

    Method SetPosition:Void(newPos:Vector2D)
        LockedWithSprite("SetPosition")
        Super.SetPosition(newPos)
    End

    Method GetPosition:Vector2D()
        LockedWithSprite("GetPosition")
        Return Super.GetPosition()
    End

    Method SetSize:Void(newSize:Vector2D)
        LockedWithSprite("SetSize")
        Super.SetSize(newSize)
    End

    Method GetSize:Vector2D()
        LockedWithSprite("GetSize")
        Return Super.GetSize()
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If sprite Then sprite.OnUpdate(timer)
    End

    Method OnRender:Void()
        If sprite Then sprite.OnRender()
    End

    Method Collide:Bool(pos:Vector2D)
        Local realPos:Vector2D = Director.TranslateSpace(pos)

        If sprite Then Return sprite.Collide(realPos)
        Return Super.Collide(realPos)
    End

    Method OnTouchDown:Bool(event:TouchEvent)
        If isPressed Then Return False
        If Not Collide(event.pos) Then Return False

        isPressed = True
        finger = event.finger
        OnButtonDown(event)
        Return True
    End

    Method OnTouchMove:Bool(event:TouchEvent)
        If Not isPressed Then Return False
        If event.finger <> finger Then Return False

        If Not trackLeavingMoves And Not Collide(event.pos) Then Return False

        OnButtonMove(event)
        Return True
    End

    Method OnTouchUp:Bool(event:TouchEvent)
        If Not isPressed Then Return False
        If event.finger <> finger Then Return False

        isPressed = False
        finger = -1

        If Not Collide(event.pos) Then Return False

        OnButtonUp(event)
        Return True
    End

    Method OnButtonDown:Void(event:TouchEvent)
    End

    Method OnButtonMove:Void(event:TouchEvent)
    End

    Method OnButtonUp:Void(event:TouchEvent)
    End

    Private

    Method LockedWithSprite:Void(name:String)
        If Not sprite Then Return

        Throw New RuntimeException("Button is bound to a sprite so " +
            "please use GetSprite()." + name)
    End
End
