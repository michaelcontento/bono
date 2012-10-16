Strict

Private

Import basedisplayobject
Import bono.kernel
Import bono.utils
Import color
Import mojo.graphics

Public

Class ColorBlend Extends BaseDisplayObject Implements AppObserver
    Method New(color:Color=New Color())
        size = Device.GetSize()
        Self.color = color
    End

    Method OnCreate:Void()
    End

    Method OnLoading:Void()
    End

    Method OnUpdate:Void(deltatimer:DeltaTimer)
    End

    Method OnRender:Void()
        PushMatrix()
            color.Activate()
            DrawRect(pos.x, pos.y, size.x, size.y)
            color.Deactivate()
        PopMatrix()
    End

    Method OnResume:Void()
    End

    Method OnSuspend:Void()
    End
End
