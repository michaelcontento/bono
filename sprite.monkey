Strict

Private

Import mojo
Import animationable
Import director
Import vector2d

Public

Class Sprite Implements Animationable
    Private

    Field image:Image
    Field frameTimer:Int
    Field currentFrame:Int
    Field frameCount:Int
    Field frameSpeed:Int
    Field loopAnimation:Bool

    Public

    Field pos:Vector2D
    Field rotation:Float
    Field scale:Vector2D = New Vector2D(1, 1)
    Field size:Vector2D
    Field center:Vector2D

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

    Method LoopAnimation:Void(flag:Bool=True)
        loopAnimation = flag
    End

    Method AnimationIsDone:Bool()
        If loopAnimation Then Return False
        Return (currentFrame = frameCount)
    End

    Method OnRender:Void()
        DrawImage(image, pos.x, pos.y, rotation, scale.x, scale.y, currentFrame)
    End

    Method OnUpdate:Void()
        UpdateAnimation()
    End

    Method CenterX:Void()
        pos.x = CurrentDirector().center.x - center.x
    End

    Method CenterY:Void()
        pos.y = CurrentDirector().center.y - center.y
    End

    Method Center:Void()
        pos = CurrentDirector().center.Copy().Sub(center)
    End

    Private

    Method UpdateAnimation:Void()
        If frameCount <= 0 Then Return
        If AnimationIsDone() Then Return

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

    Method InitVectors:Void(width:Int, height:Int, pos:Vector2D=Null)
        If pos = Null
            Self.pos = New Vector2D(0, 0)
        Else
            Self.pos = pos
        End

        size = New Vector2D(width, height)
        center = size.Copy().Div(2)
    End
End
