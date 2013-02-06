Strict

Private

Import bono

Public

Class GuiButton Extends GuiBase Implements Touchable, Updateable
    Private

    Global someButtonPressed:Bool
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

        SetColor(oldSprite.GetColor().Copy())
        SetPosition(oldSprite.GetPosition().Copy())
        SetSize(oldSprite.GetSize().Copy())
    End

    Method SetColor:Void(newColor:Color)
        LockedWithSprite("SetColor")
        Super.SetColor(newColor)
    End

    Method SetPosition:Void(newPos:Vector2D)
        LockedWithSprite("SetPosition")
        Super.SetPosition(newPos)
    End

    Method SetSize:Void(newSize:Vector2D)
        LockedWithSprite("SetSize")
        Super.SetSize(newSize)
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

    Method OnTouchDown:Void(event:TouchEvent)
        If someButtonPressed Then Return
        If Not Collide(event.pos) Then Return

        someButtonPressed = True
        isPressed = True
        finger = event.finger
        OnButtonDown(event)
    End

    Method OnTouchMove:Void(event:TouchEvent)
        If Not isPressed Then Return
        If Not event.finger = finger Then Return
        If Not trackLeavingMoves And Not Collide(event.pos) Then Return

        OnButtonMove(event)
    End

    Method OnTouchUp:Void(event:TouchEvent)
        If Not isPressed Then Return
        If Not event.finger = finger Then Return

        someButtonPressed = False
        isPressed = False

        If Not Collide(event.pos) Then Return

        OnButtonUp(event)
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
