Strict

Private

Import baseobject
Import director
Import mojo
Import vector2d

Public

Class Sprite Extends BaseObject
    Private

    Field image:Image
    Field frameTimer:Int
    Field currentFrame:Int
    Field frameCount:Int

    Public

    Field rotation:Float
    Field scale:Vector2D = New Vector2D(1, 1)
    Field loopAnimation:Bool
    Field frameSpeed:Int

    ' TODO: LoadImage() should be called in OnCreate()
    Method New(imageName:String, pos:Vector2D=Null)
        image = LoadImage(imageName)
        InitVectors(image.Width(), image.Height(), pos)
    End

    Method New(imageName:String, frameWidth:Int, frameHeight:Int, frameCount:Int, frameSpeed:Int, pos:Vector2D=Null)
        Self.frameCount = frameCount - 1
        Self.frameSpeed = frameSpeed

        image = LoadImage(imageName, frameWidth, frameHeight, frameCount)
        InitVectors(frameWidth, frameHeight, pos)
    End

    Method OnRender:Void()
        Super.OnRender()
        DrawImage(image, pos.x, pos.y, rotation, scale.x, scale.y, currentFrame)
    End

    Method OnUpdate:Void(delta:Float, frameTime:Float)
        Super.OnUpdate(delta, frameTime)

        If frameCount <= 0 Then Return
        If animationIsDone Then Return

        ' TODO: Replace the old Millisecs() implementation with delta
        If frameTimer = 0 Then
            frameTimer = Millisecs()
            Return
        End
        If Millisecs() < frameTimer + frameSpeed Then Return

        If currentFrame = frameCount
            If loopAnimation
                currentFrame = 1
            End
        Else
            currentFrame += 1
        End
        frameTimer = Millisecs()
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

    Method InitVectors:Void(width:Int, height:Int, pos:Vector2D=Null)
        If pos = Null
            Self.pos = New Vector2D(0, 0)
        Else
            Self.pos = pos
        End
        size = New Vector2D(width, height)
    End
End
