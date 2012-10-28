Strict

Private

Import bono.kernel
Import bono.graphics
Import bono.utils
Import carousel
Import carouselhandler
Import carouselrenderer
Import mojo

Public

Class CarouselRendererSimple Implements CarouselRenderer, TouchObserver
    Private

    Field touched:Bool
    Field offset:Vector2D = New Vector2D()
    Field carousel:Carousel
    Field lastItemPixelX:Float

    Public

    Field padding:Vector2D = New Vector2D()
    Field maxMoveDistanceForClicks:Float = 3

    Method SetCarousel:Void(carousel:Carousel)
        Self.carousel = carousel
    End

    Method Recalculate:Void()
        Local nextPos:Vector2D = carousel.GetPosition().Copy()
        nextPos.Add(padding)

        For Local item:BaseDisplayObject = EachIn carousel.GetItems()
            Local oldHeight:Float = item.GetSize().y
            item.GetSize().y = carousel.GetSize().y - (padding.y * 2)

            Local heightScaleFactor:Float = item.GetSize().y / oldHeight
            item.GetSize().x = item.GetSize().x * heightScaleFactor

            item.SetPosition(nextPos.Copy())
            nextPos.x += item.GetSize().x
            nextPos.x += padding.x
        End

        lastItemPixelX = carousel.GetItems().Last().GetPosition().x
        lastItemPixelX += carousel.GetItems().Last().GetSize().x
    End

    Method OnRender:Void()
        Local pos:Vector2D = carousel.GetPosition()
        Local size:Vector2D = carousel.GetSize()

        PushMatrix()
            SetScissor(pos.x, pos.y, size.x, size.y)
            Translate(offset.x, offset.y)

            For Local item:BaseDisplayObject = EachIn carousel.GetItems()
                Local itemPosX:Float = item.GetPosition().x
                itemPosX += offset.x

                If itemPosX > pos.x + size.x Then Continue
                If itemPosX + item.GetSize().x < pos.x Then Continue
                item.OnRender()
            End
        PopMatrix()
    End

    Method OnTouchDown:Void(event:TouchEvent)
        touched = True
    End

    Method OnTouchMove:Void(event:TouchEvent)
        If Not touched Then Return
        offset.x += event.prevDelta.x
        offset.x = Min(0.0, offset.x)

        Local maxX:Float = carousel.GetPosition().x + carousel.GetSize().x
        maxX -= lastItemPixelX
        maxX -= padding.x
        offset.x = Max(maxX, offset.x)
    End

    Method OnTouchUp:Void(event:TouchEvent)
        If Not touched Then Return
        touched = False

        If event.startDelta.Length() > maxMoveDistanceForClicks Then Return

        Local item:BaseDisplayObject = GetTouchedItem(event)
        If Not item Then Return

        Local handler:CarouselHandler = CarouselHandler(item)
        If Not handler Then Return

        handler.OnCarouselSelect()
    End

    Private

    Method GetTouchedItem:BaseDisplayObject(event:TouchEvent)
        Local result:BaseDisplayObject
        ' Offset is negative and we need to use Sub() here instead of Add()
        Local checkPos:Vector2D = event.pos.Copy().Sub(offset)

        For Local item:BaseDisplayObject = EachIn carousel.GetItems()
            If item.Collide(checkPos) Then Return item
        End

        Return Null
    End
End
