Strict

Private

Import bono
Import mojo.graphics

Public

Class Sprite Extends BaseDisplayObject Implements Updateable, Renderable, Rotateable, Timelineable
    Private

    Field currentFrame:Int
    Field frameTimer:Int
    Field image:Image
    Field renderPos:Vector2D = New Vector2D()
    Field _scale:Vector2D = New Vector2D(1, 1)
    Field lastScale:Vector2D = New Vector2D(1, 1)
    Field rotation:Float
    Field timelineFactory:TimelineFactory

    Public

    Field frameSpeed:Int
    Field loopAnimation:Bool
    Global imageLoader:ImageLoader

    Function Get:Sprite(name:String)
        If Not imageLoader
            Throw New RuntimeException("No ImageLoader configured yet")
        End

        Return New Sprite(imageLoader.LoadImage(name))
    End

    Method New(image:Image)
        Self.image = image
    End

    Method GetTimeline:TimelineFactory()
        If Not timelineFactory Then timelineFactory = New TimelineFactory(Self)
        Return timelineFactory
    End

    Method GetRotation:Float()
        Return rotation
    End

    Method SetRotation:Void(rotation:Float)
        Self.rotation = MathHelper.ModF(rotation, 360.0)
    End

    Method OnRender:Void()
        GetSize().Div(lastScale).Mul(_scale)
        lastScale.Set(_scale)

        renderPos.Set(GetSize()).Div(2)
        renderPos.Add(GetPosition())
        Align.Align(renderPos, Self, GetAlignment())

        GetColor().Activate()
        DrawImage(
            image,
            renderPos.x, renderPos.y,
            rotation,
            _scale.x, _scale.y,
            currentFrame)
        GetColor().Deactivate()
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If timelineFactory
            timelineFactory.GetTimeline().OnUpdate(timer)
        End

        OnUpdateAnimation(timer)
    End

    Method Copy:Sprite()
        Local tmp:Sprite = New Sprite(image)
        BaseDisplayObject.Copy(Self, tmp)

        tmp.frameSpeed = frameSpeed
        tmp.loopAnimation = loopAnimation
        tmp.rotation = rotation
        tmp.scale = scale.Copy()

        Return tmp
    End

    Method GrabSprite:Sprite(src:Vector2D, size:Vector2D)
        Return New Sprite(image.GrabImage(
            src.x, src.y,
            size.x, size.y,
            1,
            Image.MidHandle))
    End

    Method Restart:Void()
        currentFrame = 0
    End

    Method animationIsDone:Bool() Property
        If loopAnimation Then Return False
        Return (currentFrame = image.Frames())
    End

    Method scale:Vector2D() Property
        Return _scale
    End

    Method scale:Void(newScale:Vector2D) Property
        _scale = newScale
    End

    Method DrawImageRect:Void(pos:Vector2D, rectPos:Vector2D, rectSize:Vector2D)
        DrawImageRect(pos.x, pos.y, rectPos.x, rectPos.y, rectSize.x, rectSize.y)
    End

    Method DrawImageRect:Void(x:Float, y:Float, srcX:Float, srcY:Float, srcWidth:Float, srcHeight:Float)
        ' borrow renderPos (mainly used in OnRender) here to avoid a new
        ' instance of Vector2D
        renderPos.Set(GetSize()).Div(2)

        x += renderPos.x
        y += renderPos.y
        graphics.DrawImageRect(
            image,
            x, y,
            srcX, srcY,
            srcWidth, srcHeight,
            rotation,
            _scale.x, _scale.y,
            currentFrame)
    End

    Private

    Method OnUpdateAnimation:Void(timer:DeltaTimer)
        If animationIsDone Then Return
        If image.Frames() <= 0 Then Return

        If frameTimer < frameSpeed
            frameTimer += timer.frameTime
            Return
        End

        If (currentFrame + 1) = image.Frames()
            If loopAnimation Then currentFrame = 1
        Else
            currentFrame += 1
        End
        frameTimer = 0
    End
End
