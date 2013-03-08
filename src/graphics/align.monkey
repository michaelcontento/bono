Strict

Private

Import bono

Public

Class Align Abstract
    Const TOP:Int = 1
    Const BOTTOM:Int = 2
    Const LEFT:Int = 4
    Const RIGHT:Int = 8
    Const CENTER:Int = 16

    Function Align:Void(pos:Vector2D, obj:Sizeable, mode:Int)
        ValidateMode(mode)

        If mode & BOTTOM Then pos.y -= obj.GetSize().y
        If mode & RIGHT Then pos.x -= obj.GetSize().x

        If mode & CENTER
            If Not (mode & TOP Or mode & BOTTOM) Then pos.y -= obj.GetSize().y / 2
            If Not (mode & LEFT Or mode & RIGHT) Then pos.x -= obj.GetSize().x / 2
        End
    End

    Private

    Function ValidateMode:Void(mode:Int)
        If mode & LEFT And mode & RIGHT
            Throw New InvalidArgumentException("Invalid alignment LEFT & RIGHT")
        End

        If mode & TOP And mode & BOTTOM
            Throw New InvalidArgumentException("Invalid alignment TOP & BOTTOM")
        End

        If mode & CENTER And (mode & TOP Or mode & BOTTOM) And (mode & LEFT Or mode & RIGHT)
            Throw New InvalidArgumentException("Alignment with CENTER and both X and Y-axis is not valid")
        End
    End
End
