Strict

Private

Import bono.src.graphics
Import bono.src.kernel
Import carouselrenderer

Public

Class Carousel Extends BaseDisplayObject Implements TouchObserver
    Private

    Field itemList:List<BaseDisplayObject> = New List<BaseDisplayObject>()
    Field borderRect:ColorBlend
    Field doRecalculation:Bool = True
    Field touched:Bool
    Field renderer:CarouselRenderer
    Field isTouchObserver:Bool

    Public

    Field displayBorder:Bool

    Method New()
        Error("Wrong constructor. Use New(CarouselRenderer)")
    End

    Method New(renderer:CarouselRenderer)
        Self.renderer = renderer

        renderer.SetCarousel(Self)
        If TouchObserver(renderer) Then isTouchObserver = True
    End

    Method GetItems:List<BaseDisplayObject>()
        Return itemList
    End

    Method GetRenderer:CarouselRenderer()
        Return renderer
    End

    Method OnRender:Void()
        If doRecalculation
            doRecalculation = False
            renderer.Recalculate()
        End

        If displayBorder Then RenderBorder()
        renderer.OnRender()
    End

    Method Add:Void(item:BaseDisplayObject)
        If itemList.Contains(item) Then Return
        itemList.AddLast(item)
        doRecalculation = True
    End

    ' --- TouchObserver
    Method OnTouchDown:Void(event:TouchEvent)
        If Not isTouchObserver Then Return
        If Not Collide(event.pos) Then Return
        touched = True

        TouchObserver(renderer).OnTouchDown(event)
    End

    Method OnTouchMove:Void(event:TouchEvent)
        If Not isTouchObserver Then Return
        If Not touched Then Return

        TouchObserver(renderer).OnTouchMove(event)
    End

    Method OnTouchUp:Void(event:TouchEvent)
        If Not isTouchObserver Then Return
        If Not touched Then Return
        touched = False

        TouchObserver(renderer).OnTouchUp(event)
    End

    Private

    Method RenderBorder:Void()
        If Not borderRect Then borderRect = New ColorBlend()
        borderRect.SetSize(GetSize())
        borderRect.SetPosition(GetPosition())
        borderRect.OnRender()
    End
End
