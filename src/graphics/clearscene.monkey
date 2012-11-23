Strict

Private

Import bono.src.kernel
Import color
Import mojo.graphics

Public

Class ClearScene Implements AppObserver
    Private

    Field color:Color

    Public

    Method New(color:Color=New Color())
        Self.color = color
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
    End

    Method OnRender:Void()
        Cls(color.red, color.green, color.blue)
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End
End
