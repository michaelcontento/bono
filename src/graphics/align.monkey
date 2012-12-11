Strict

Private

Import bono.src.utils
Import sprite
Import sizeable

Public

Class Align Abstract
    Const TOP:Int = 0
    Const BOTTOM:Int = 1
    Const LEFT:Int = 2
    Const RIGHT:Int = 3
    Const CENTER:Int = 4

    Function AdjustHorizontal:Void(pos:Vector2D, object:Sizeable, mode:Int)
        Local scale:Float = 1
        If Sprite(object) Then scale = Sprite(object).scale.x

        Select mode
        Case LEFT
            ' Default alignment - nothing to do here
        Case RIGHT
            pos.x -= object.GetSize().x / scale
        Case CENTER
            pos.x -= object.GetSize().x / scale / 2
        Default
            Error("Invalid alignment mode (" + mode + ") given")
        End
    End

    Function AdjustVertical:Void(pos:Vector2D, object:Sizeable, mode:Int)
        Local scale:Float = 1
        If Sprite(object) Then scale = Sprite(object).scale.y

        Select mode
        Case TOP
            ' Default alignment - nothing to do here
        Case BOTTOM
            pos.y -= object.GetSize().y / scale
        Case CENTER
            pos.y -= object.GetSize().y / scale / 2
        Default
            Error("Invalid alignment mode (" + mode + ") given")
        End
    End
End
