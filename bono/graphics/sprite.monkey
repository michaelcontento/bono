Strict

Private

Import bono.kernel
Import bono.utils
Import basedisplayobject
Import mojo.graphics

Public

Class Sprite Extends BaseDisplayObject Implements AppObserver
    Private

    Field currentFrame:Int
    Field frameCount:Int
    Field frameSize:Vector2D
    Field frameTimer:Int
    Field image:Image
    Field imageName:String
    Field _scale:Vector2D = New Vector2D(1, 1)

    Public

    Field frameSpeed:Int
    Field loopAnimation:Bool
    Field rotation:Float

    Method New(imageName:String, pos:Vector2D=Null)
        SetNameAndPos(imageName, pos)
    End

    Method New(imageName:String, frameSize:Vector2D, frameCount:Int, frameSpeed:Int, pos:Vector2D=Null)
        SetNameAndPos(imageName, pos)

        Self.frameSize = frameSize
        Self.frameCount = frameCount
        Self.frameSpeed = frameSpeed
    End

    Method OnLoading:Void()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End

    Method OnCreate:Void()
        If frameSize
            image = LoadImage(imageName, frameSize.x, frameSize.y, frameCount)
            size = frameSize.Copy()
        Else
            image = LoadImage(imageName)
            size = New Vector2D(image.Width(), image.Height())
        End

        size.Mul(scale)
    End

    Method OnRender:Void()
        If color Then color.Activate()
        DrawImage(image, pos.x, pos.y, rotation, scale.x, scale.y, currentFrame)
        If color Then color.Deactivate()
    End

    Method OnUpdate:Void(deltaTimer:DeltaTimer)
        If frameCount <= 0 Then Return
        If animationIsDone Then Return

        If frameTimer < frameSpeed
            frameTimer += deltaTimer.frameTime
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

    Method scale:Vector2D() Property
        Return _scale
    End

    Method scale:Void(newScale:Vector2D) Property
        If image Then size = size.Div(_scale).Mul(newScale)
        _scale = newScale
    End

    Private

    Method SetNameAndPos:Void(imageName:String, pos:Vector2D=Null)
        Self.imageName = imageName
        If Not pos Then pos = New Vector2D(0, 0)
        Self.pos = pos
    End
End
