Strict

Private

Import align
Import basedisplayobject
Import bono.kernel
Import bono.utils
Import mojo.graphics

Public

Class Sprite Extends BaseDisplayObject
    Private

    Field currentFrame:Int
    Field frameCount:Int
    Field frameSize:Vector2D
    Field frameTimer:Int
    Field image:Image
    Field imageName:String
    Field _scale:Vector2D = New Vector2D(1, 1)
    Field _halign:Int = Align.LEFT
    Field _valign:Int = Align.TOP
    Field renderPos:Vector2D

    Public

    Field frameSpeed:Int
    Field loopAnimation:Bool
    Field rotation:Float

    Method New(imageName:String, pos:Vector2D=Null)
        SetNameAndPos(imageName, pos)
        LoadImage()
    End

    Method New(imageName:String, frameSize:Vector2D, frameCount:Int, frameSpeed:Int, pos:Vector2D=Null)
        Self.frameSize = frameSize
        Self.frameCount = frameCount
        Self.frameSpeed = frameSpeed

        SetNameAndPos(imageName, pos)
        LoadImage()
    End

    Method OnRender:Void()
        If Not renderPos Then CalculateRenderPos()
        GetColor().Activate()
        DrawImage(image, renderPos.x, renderPos.y, rotation, scale.x, scale.y, currentFrame)
        GetColor().Deactivate()
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

    Method animationIsDone:Bool() Property
        If loopAnimation Then Return False
        Return (currentFrame = frameCount)
    End

    Method scale:Vector2D() Property
        Return _scale
    End

    Method scale:Void(newScale:Vector2D) Property
        If image Then GetSize().Div(_scale).Mul(newScale)
        _scale = newScale
    End

    Method filepath:String() Property
        Return imageName
    End

    Method halign:Int() Property
        Return _halign
    End

    Method halign:Void(newAlign:Int) Property
        _halign = newAlign
        renderPos = Null
    End

    Method valign:Int() Property
        Return _valign
    End

    Method valign:Void(newAlign:Int) Property
        _valign = newAlign
        renderPos = Null
    End

    Method SetPosition:Void(newPos:Vector2D)
        Super.SetPosition(newPos)
        renderPos = Null
    End

    Private

    Method CalculateRenderPos:Void()
        renderPos = GetPosition().Copy()
        Align.AdjustHorizontal(renderPos, Self, halign)
        Align.AdjustVertical(renderPos, Self, valign)
    End

    Method LoadImage:Void()
        If frameSize
            image = graphics.LoadImage(imageName, frameSize.x, frameSize.y, frameCount)
            SetSize(frameSize.Copy())
        Else
            image = graphics.LoadImage(imageName)
            SetSize(New Vector2D(image.Width(), image.Height()))
        End

        If Not image Then Error("Unable to load: " + imageName)
        GetSize().Mul(scale)
    End

    Method SetNameAndPos:Void(imageName:String, pos:Vector2D=Null)
        Self.imageName = imageName
        If Not pos Then pos = New Vector2D(0, 0)
        Self.SetPosition(pos)
    End
End
