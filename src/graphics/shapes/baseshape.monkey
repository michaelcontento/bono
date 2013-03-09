Strict

Private

Import bono
Import mojo.graphics

Public

Class BaseShape Extends BaseDisplayObject Implements Renderable, Rotateable, Updateable
    Private

    Field rotation:Float
    Field timelineFactory:TimelineFactory
    Field renderPos := New Vector2D()
    Field halfSize := New Vector2D()

    Public

    Method GetRotation:Float()
        Return rotation
    End

    Method SetRotation:Void(rotation:Float)
        Self.rotation = MathHelper.ModF(rotation, 360.0)
    End

    Method GetTimeline:TimelineFactory()
        If Not timelineFactory Then timelineFactory = New TimelineFactory(Self)
        Return timelineFactory
    End

    Method OnUpdate:Void(timer:DeltaTimer)
        If timelineFactory Then timelineFactory.GetTimeline().OnUpdate(timer)
    End

    Method OnRender:Void()
        halfSize.Set(GetSize()).Div(2)
        renderPos.Set(GetPosition())
        Align.Align(renderPos, Self, GetAlignment())

        PushMatrix()

        MatrixHelper.Translate(renderPos)

        MatrixHelper.Translate(halfSize)
        Rotate(GetRotation())
        MatrixHelper.Translate(halfSize.Revert())

        GetColor().Activate()
        OnRenderShape()
        GetColor().Deactivate()

        PopMatrix()
    End

    Method OnRenderShape:Void() Abstract
End
