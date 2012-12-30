Strict

Private

Import bono.src.utils
Import positionable
Import sizeable
Import sprite

Public

Class Align Abstract
    Const TOP:Int = 0
    Const BOTTOM:Int = 1
    Const LEFT:Int = 2
    Const RIGHT:Int = 3
    Const CENTER:Int = 4

    Function Horizontal:Void(object:Object, mode:Int)
        CheckInterfaces(object)
        Local scale:Float = GetScale(object).x

        Select mode
        Case LEFT
            ' Default alignment - nothing to do here
        Case RIGHT
            Positionable(object).GetPosition().x -= Sizeable(object).GetSize().x / scale
        Case CENTER
            Positionable(object).GetPosition().x -= Sizeable(object).GetSize().x / scale / 2
        Default
            Error("Invalid alignment mode (" + mode + ") given")
        End
    End

    Function Vertical:Void(object:Object, mode:Int)
        CheckInterfaces(object)
        Local scale:Float = GetScale(object).y

        Select mode
        Case TOP
            ' Default alignment - nothing to do here
        Case BOTTOM
            Positionable(object).GetPosition().y -= Sizeable(object).GetSize().y / scale
        Case CENTER
            Positionable(object).GetPosition().y -= Sizeable(object).GetSize().y / scale / 2
        Default
            Error("Invalid alignment mode (" + mode + ") given")
        End
    End

    Function Centered:Void(object:Sizeable)
        Horizontal(object, CENTER)
        Vertical(object, CENTER)
    End

    Private

    Function CheckInterfaces:Void(object:Object)
        If Not Sizeable(object)
            Error("Given object must implement Sizeable")
        End

        If Not Positionable(object)
            Error("Given object must implement Positionable")
        End
    End

    Function GetScale:Vector2D(object:Object)
        If Sprite(object) Then Return Sprite(object).scale
        Return New Vector2D(1, 1)
    End
End
