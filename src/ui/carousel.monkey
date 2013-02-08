Strict

Private

Import bono

Public

Class Carousel Extends BaseDisplayObject Implements Touchable
    Private

    Field itemList:List<BaseDisplayObject> = New List<BaseDisplayObject>()
    Field borderRect:ColorBlend
    Field doRecalculation:Bool = True
    Field touched:Bool
    Field renderer:CarouselRenderer
    Field isTouchable:Bool

    Public

    Field displayBorder:Bool

    Method New()
        Throw New InvalidConstructorException("use New(CarouselRenderer)")
    End

    Method New(renderer:CarouselRenderer)
        Self.renderer = renderer

        renderer.SetCarousel(Self)
        If Touchable(renderer) Then isTouchable = True
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

    ' --- Touchable
    Method OnTouchDown:Bool(event:TouchEvent)
        If Not isTouchable Then Return False
        If Not Collide(event.pos) Then Return False
        touched = True

        Touchable(renderer).OnTouchDown(event)
        Return True
    End

    Method OnTouchMove:Bool(event:TouchEvent)
        If Not isTouchable Then Return False
        If Not touched Then Return False

        Touchable(renderer).OnTouchMove(event)
        Return True
    End

    Method OnTouchUp:Bool(event:TouchEvent)
        If Not isTouchable Then Return False
        If Not touched Then Return False
        touched = False

        Touchable(renderer).OnTouchUp(event)
        Return True
    End

    Private

    Method RenderBorder:Void()
        If Not borderRect Then borderRect = New ColorBlend()
        borderRect.SetSize(GetSize())
        borderRect.SetPosition(GetPosition())
        borderRect.OnRender()
    End
End
