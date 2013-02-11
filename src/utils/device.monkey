Strict

Private

Import bono
Import mojo.graphics
Import "native/device.${TARGET}.${LANG}"

Class DeviceNonNative Abstract
    Function GetSize:Vector2D()
        Return New Vector2D(DeviceWidth(), DeviceHeight())
    End

    Function ShowAlert:Void(title:String, message:String, buttons:String[], callback:AlertCallback)
        Device.ShowAlertNative(title, message, buttons, New AlertDelegateBridge(callback))
    End
End

Extern

Class Device Extends DeviceNonNative Abstract
#If TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="Device::GetTimestamp"
    Function OpenUrl:Void(url:String)="Device::OpenUrl"
    Function GetLanguage:String()="Device::GetLanguage"

    Private

    Function ShowAlertNative:Void(title:String, message:String, buttons:String[], cb:AlertDelegate)="Device::ShowAlertNative"
#Else
    Function GetTimestamp:Int()="Device.GetTimestamp"
    Function OpenUrl:Void(url:String)="Device.OpenUrl"
    Function GetLanguage:String()="Device.GetLanguage"

    Private

    Function ShowAlertNative:Void(title:String, message:String, buttons:String[], cb:AlertDelegate)="Device::ShowAlertNative"
#End
End

' Interfaces can't be external and for this we need to do a little dance ...
'
' The basic workflow is something like:
'   Device.ShowAlertNative
'   --> UIAlertView.show
'   --> AlertDelegateObjectiveC.clickedButtonAtIndex
'   --> AlertDelegate.Call
'
' The UIAlertView is created, configured and shown completly in the native
' ShowAlert method. To receive the click we create a new instance of
' AlertDelegateObjectiveC which only translates the Obj-C call into
' AlertDelegate.Call(). This is important, because we now have a very simple
' object with one (pure virtual) method - AlertDelegate.
'
' AlertDelegate has an external interface and is accessbile for Monkey. And with
' this in mind: AlertDelegateBridge simply inherits AlertDelegate and
' translates the method Call() into the desired interface (AlertCallback).
'
' The full stack should look something like this:
'   Device.ShowAlert
'   --> Device.ShowAlertNative
'   --> UIAlertView.show
'   --> AlertDelegateObjectiveC.clickedButtonAtIndex
'   --> AlertDelegate.Call
'   --> AlertDelegateBridge.Call
'   --> AlertCallback.OnAlertCallback

Extern Private

Class AlertDelegate="AlertDelegate"
    Method Call:Void(buttonIndex:Int, buttonTitle:String)
End

Private

Class AlertDelegateBridge Extends AlertDelegate
    Private

    Field callback:AlertCallback

    Public

    Method New()
        Throw New InvalidConstructorException("use New(AlertCallback)")
    End

    Method New(callback:AlertCallback)
        Self.callback = callback
    End

    Method Call:Void(buttonIndex:Int, buttonTitle:String)
        callback.OnAlertCallback(buttonIndex, buttonTitle)
    End
End
