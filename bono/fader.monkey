Strict

Private

Import directorevents
Import mojo.graphics
Import positionable

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
    Method PreRender:Void(value:Float)
    End

    Method PostRender:Void(value:Float)
    End

    Method PreNode:Void(value:Float, node:DirectorEvents)
        If value = 1 Then Return
        PushMatrix()

        Local posNode:Positionable = Positionable(node)
        If posNode
            Local offsetX:Float = posNode.pos.x * (value - 1)
            Local offsetY:Float = posNode.pos.y * (value - 1)
            Translate(-offsetX, -offsetY)
        End

        Scale(value, value)
    End

    Method PostNode:Void(value:Float, node:DirectorEvents)
        If value = 1 Then Return
        PopMatrix()
    End
End
