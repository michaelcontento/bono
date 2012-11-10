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
    Field momentumX:Float
    Field touchMovement:Float
    Field touchTime:Int
    Field offsetMaxX:Float

    Public

    Field padding:Vector2D = New Vector2D()
    Field maxMoveDistanceForClicks:Float = 3
    Field frictionCoefficient:Float = 0.8

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

        offsetMaxX = carousel.GetPosition().x + carousel.GetSize().x
        offsetMaxX -= lastItemPixelX
        offsetMaxX -= padding.x
    End

    Method GetCurrentIndex:Void()
    End

    Method OnRender:Void()
        ApplyMomentum()

        Local pos:Vector2D = carousel.GetPosition()
        Local size:Vector2D = carousel.GetSize()

        Local oldScissor:Float[] = GetScissor()
        MatrixHelper.SetScissorRelative(pos, size)

        PushMatrix()
            Translate(offset.x, offset.y)

            For Local item:BaseDisplayObject = EachIn carousel.GetItems()
                Local itemPosX:Float = item.GetPosition().x
                itemPosX += offset.x

                If itemPosX > pos.x + size.x Then Continue
                If itemPosX + item.GetSize().x < pos.x Then Continue
                item.OnRender()
            End
        PopMatrix()

        SetScissor(oldScissor[0], oldScissor[1], oldScissor[2], oldScissor[3])
    End

    Method OnTouchDown:Void(event:TouchEvent)
        touched = True
        momentumX = 0
        touchMovement = 0
    End

    Method OnTouchMove:Void(event:TouchEvent)
        If Not touched Then Return
        offset.x += event.prevDelta.x
        CheckOffsetBoundaries()

        If event.positions.Count() = 0 Then Return
        If event.prevDelta.x = 0 Then Return

        touchMovement += event.prevDelta.x
        touchTime = event.endTime
    End

    Method OnTouchUp:Void(event:TouchEvent)
        If Not touched Then Return
        touched = False

        If event.startDelta.Length() < maxMoveDistanceForClicks
            Local item:BaseDisplayObject = GetTouchedItem(event)
            If Not item Then Return

            Local handler:CarouselHandler = CarouselHandler(item)
            If Not handler Then Return

            handler.OnCarouselSelect()
        Else
            If (Millisecs() - touchTime) < 50 And Abs(touchMovement) > 10
                Local duration:Float = event.endTime - event.startTime
                Local distance:Float = event.startDelta.x
                momentumX = distance / duration * 30
            End
        End
    End

    Private

    Method ApplyMomentum:Void()
        If Abs(momentumX) = 0 Then Return

        offset.x += momentumX
        CheckOffsetBoundaries()

        momentumX *= frictionCoefficient
        If Abs(momentumX) <= 0.05 Then momentumX = 0
    End

    Method CheckOffsetBoundaries:Void()
        offset.x = Min(0.0, offset.x)
        offset.x = Max(offsetMaxX, offset.x)
    End

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
