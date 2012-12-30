Strict

Private

Import align
Import basedisplayobject
Import bono.src.kernel
Import bono.src.utils
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
    Global cacheImage:StringMap<Image> = New StringMap<Image>()
    Global cacheSize:StringMap<Vector2D> = New StringMap<Vector2D>()

    Public

    Field frameSpeed:Int
    Field loopAnimation:Bool
    Field rotation:Float

    Method New(imageName:String, pos:Vector2D=Null)
        Self.imageName = imageName

        LoadImage()
    End

    Method New(imageName:String, frameSize:Vector2D, frameCount:Int, frameSpeed:Int, pos:Vector2D=Null)
        Self.imageName = imageName
        Self.frameSize = frameSize
        Self.frameCount = frameCount
        Self.frameSpeed = frameSpeed

        LoadImage()
    End

    Method OnRender:Void()
        GetColor().Activate()
        Local pos:Vector2D = GetPosition.Copy().Add(GetCenter())
        DrawImage(image, pos.x, pos.y, rotation, scale.x, scale.y, currentFrame)
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

    Private

    Method CacheSet:Void(name:String, image:Image, size:Vector2D)
        cacheImage.Set(name, image)
        cacheSize.Set(name, size)
    End

    Method CacheGetSize:Vector2D(name:String)
        Return cacheSize.Get(name)
    End

    Method CacheGetImage:Image(name:String)
        Return cacheImage.Get(name)
    End

    Method LoadImage:Void()
        ' Try the cache first ...
        image = CacheGetImage(imageName)
        If image
            SetSize(CacheGetSize(imageName))
        End

        ' ... but handle misses aswell
        If Not image
            If frameSize
                image = graphics.LoadImage(imageName, frameSize.x, frameSize.y, frameCount, Image.MidHandle)
                SetSize(frameSize.Copy())
            Else
                image = graphics.LoadImage(imageName, 1, Image.MidHandle)
                SetSize(New Vector2D(image.Width(), image.Height()))
            End
            CacheSet(imageName, image, GetSize())
        End

        If Not image Then Error("Unable to load: " + imageName)
        GetSize().Mul(scale)
    End
End
