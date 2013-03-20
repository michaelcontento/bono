Strict

Private

Import bono
Import mojo.graphics

Public

Class Sprite Extends BaseDisplayObject Implements Updateable, Renderable, Rotateable, Timelineable
    Private

    Field image:Image
    Field realSize:Vector2D
    Field rotation:Float
    Field timelineFactory:TimelineFactory
    Global tmpPos:Vector2D = New Vector2D()
    Global tmpScale:Vector2D = New Vector2D(1, 1)

    Public

    Global imageLoader:ImageLoader

    Function Create:Sprite(name:String)
        If Not imageLoader
            Throw New RuntimeException("No ImageLoader configured yet")
        End

        Return New Sprite(imageLoader.LoadImage(name))
    End

    Method New()
        Throw New InvalidConstructorException("use New(Image)")
    End

    Method New(image:Image)
        Self.image = image

        realSize = New Vector2D(image.Width(), image.Height())
        SetSize(realSize.Copy())
    End

    Method GetTimeline:TimelineFactory()
        If Not timelineFactory Then timelineFactory = New TimelineFactory(Self)
        Return timelineFactory
    End

    Method GetRotation:Float()
        Return rotation
    End

    Method SetRotation:Void(rotation:Float)
        Self.rotation = MathHelper.EnsureBounds(rotation, 0.0, 360.0)
    End

    Method OnRender:Void()
        Local oldHandleX := image.HandleX()
        Local oldHandleY := image.HandleY()
        image.SetHandle(realSize.x / 2, realSize.y / 2)

        tmpScale.Set(GetSize()).Div(realSize)

        tmpPos.Set(GetSize()).Div(2)
        tmpPos.Add(GetPosition())
        Align.Align(tmpPos, Self, GetAlignment())

        GetColor().Activate()
        DrawImage(
            image,
            tmpPos.x, tmpPos.y,
            rotation,
            tmpScale.x, tmpScale.y,
            0)
        GetColor().Deactivate()

        image.SetHandle(oldHandleX, oldHandleY)
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If Not timelineFactory Then Return
        timelineFactory.GetTimeline().OnUpdate(timer)
    End

    Method Copy:Sprite()
        Local tmp:Sprite = New Sprite(image)
        BaseDisplayObject.Copy(Self, tmp)

        tmp.SetRotation(GetRotation())
        tmp.GetSize().Set(GetSize())

        Return tmp
    End

    Method GrabSprite:Sprite(src:Vector2D, size:Vector2D)
        Return New Sprite(image.GrabImage(
            src.x, src.y,
            size.x, size.y,
            1,
            Image.MidHandle))
    End

    Method DrawImageRect:Void(pos:Vector2D, rectPos:Vector2D, rectSize:Vector2D)
        DrawImageRect(
            pos.x, pos.y,
            rectPos.x, rectPos.y,
            rectSize.x, rectSize.y)
    End

    Method DrawImageRect:Void(x:Float, y:Float, srcX:Float, srcY:Float, srcWidth:Float, srcHeight:Float)
        ' borrow tmpPos (mainly used in OnRender) here to avoid a new
        ' instance of Vector2D
        tmpPos.Set(GetSize()).Div(2)

        x += tmpPos.x
        y += tmpPos.y
        graphics.DrawImageRect(
            image,
            x, y,
            srcX, srcY,
            srcWidth, srcHeight,
            rotation,
            _scale.x, _scale.y,
            currentFrame)
    End
End
