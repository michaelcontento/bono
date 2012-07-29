Strict

Private

Import baseobject
Import director
Import mojo.graphics
Import vector2d

Public

Class Sprite Extends BaseObject
    Private

    Field currentFrame:Int
    Field frameCount:Int
    Field frameSize:Vector2D
    Field frameTimer:Int
    Field image:Image
    Field imageName:String

    Public

    Field frameSpeed:Int
    Field loopAnimation:Bool
    Field rotation:Float
    Field scale:Vector2D = New Vector2D(1, 1)

    Method New(imageName:String, pos:Vector2D=Null)
        SetNameAndPos(imageName, pos)
    End

    Method New(imageName:String, frameSize:Vector2D, frameCount:Int, frameSpeed:Int, pos:Vector2D=Null)
        SetNameAndPos(imageName, pos)

        Self.frameSize = frameSize
        Self.frameCount = frameCount
        Self.frameSpeed = frameSpeed
    End

    Method OnCreate:Void(director:Director)
        Super.OnCreate(director)

        If frameSize
            image = LoadImage(imageName, frameSize.x, frameSize.y, frameCount)
            size = frameSize.Copy()
        Else
            image = LoadImage(imageName)
            size = New Vector2D(image.Width(), image.Height())
        End
    End

    Method OnRender:Void()
        Super.OnRender()
        If color Then color.Activate()
        DrawImage(image, pos.x, pos.y, rotation, scale.x, scale.y, currentFrame)
        If color Then color.Deactivate()
    End

    Method OnUpdate:Void(delta:Float, frameTime:Float)
        Super.OnUpdate(delta, frameTime)

        If frameCount <= 0 Then Return
        If animationIsDone Then Return

        If frameTimer < frameSpeed
            frameTimer += frameTime
            Return
        End

        If (currentFrame + 1) = frameCount
            If loopAnimation
                currentFrame = 1
            End
        Else
            currentFrame += 1
        End
        frameTimer = 0
    End

    Method Restart:Void()
        currentFrame = 0
    End

    Method Collide:Bool(checkPos:Vector2D)
        If checkPos.x < pos.x Or checkPos.x > pos.x + size.x Then Return False
        If checkPos.y < pos.y Or checkPos.y > pos.y + size.y Then Return False
        Return True
    End

    Method animationIsDone:Bool() Property
        If loopAnimation Then Return False
        Return (currentFrame = frameCount)
    End

    Private

    Method SetNameAndPos:Void(imageName:String, pos:Vector2D=Null)
        Self.imageName = imageName
        If Not pos Then pos = New Vector2D(0, 0)
        Self.pos = pos
    End
End
