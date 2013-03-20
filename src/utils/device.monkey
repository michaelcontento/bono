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

Class Device Extends DeviceNonNative
    Function GetTimestamp:Int()
    Function OpenUrl:Void(url:String)
    Function GetLanguage:String()

    Private

    Function ShowAlertNative:Void(title:String, message:String, buttons:String[], cb:AlertDelegate)
End

' Interfaces can't be external and for this we need to do a little dance ...
'
'   DeviceNonNative.ShowAlert
'   --> Device.ShowAlertNative
'   --> (native implementation)
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
