Strict

Private

Import directorevents
Import mojo.graphics
Import positionable
Import sizeable

Public

Interface Fader
    Method PreRender:Void(value:Float)
    Method PostRender:Void(value:Float)
    Method PreNode:Void(value:Float, node:DirectorEvents)
    Method PostNode:Void(value:Float, node:DirectorEvents)
End

Class FaderAlpha Implements Fader
    Method PreRender:Void(value:Float)
        PushMatrix()
            SetAlpha(value)
    End

    Method PostRender:Void(value:Float)
        PopMatrix()
    End

    Method PreNode:Void(value:Float, node:DirectorEvents)
    End

    Method PostNode:Void(value:Float, node:DirectorEvents)
    End
End

Class FaderScale Implements Fader
    Private

    Field offsetX:Float
    Field offsetY:Float

    Public

    Method PreRender:Void(value:Float)
    End

    Method PostRender:Void(value:Float)
    End

    Method PreNode:Void(value:Float, node:DirectorEvents)
        If value = 1 Then Return
        PushMatrix()

        Local sizeNode:Sizeable = Sizeable(node)
        If sizeNode
            offsetX = sizeNode.center.x * (value - 1)
            offsetY = sizeNode.center.y * (value - 1)
            Translate(-offsetX, -offsetY)
        End

        Local posNode:Positionable = Positionable(node)
        If posNode
            offsetX = posNode.pos.x * (value - 1)
            offsetY = posNode.pos.y * (value - 1)
            Translate(-offsetX, -offsetY)
        End

        Scale(value, value)
    End

    Method PostNode:Void(value:Float, node:DirectorEvents)
        If value = 1 Then Return
        PopMatrix()
    End
End
