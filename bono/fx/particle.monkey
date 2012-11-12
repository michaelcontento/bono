Strict

Private

Import bono.graphics
Import bono.utils

Public

Class Particle
    Field position:Vector2D = New Vector2D()
    Field previousPosition:Vector2D = New Vector2D()
    Field size:Vector2D = New Vector2D()
    Field velocity:Vector2D = New Vector2D()
    Field color:Color = New Color()
    Field lifetime:Float
    Field active:Bool

    Method Apply:Void(sprite:Sprite)
        sprite.SetPosition(position)
        sprite.SetColor(color)
    End

    Method Reset:Void()
        position.x = 0
        position.y = 0
        previousPosition.x = 0
        previousPosition.y = 0
        size.x = 0
        size.y = 0
        velocity.x = 0
        velocity.y = 0
        color.Reset()
        lifetime = 0
        active = True
    End
End
