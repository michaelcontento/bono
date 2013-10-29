Strict

Private

Import bono
Import mojo.graphics
Import mojo.data
Import "native/device.${TARGET}.${LANG}"

Extern

#if TARGET="ios" Or TARGET="glfw"

Class DeviceNative Abstract
    Function GetTimestamp:Int()="Device::GetTimestamp"
    Function OpenUrl:Void(url:String)="Device::OpenUrl"
    Function GetLanguage:String()="Device::GetLanguage"
    Function Close:Void()="Device::Close"

    Function FileExistsNative:Bool(path:String)="Device::FileExistsNative"
    Function ShowAlertNative:Void(title:String, message:String, buttons:String[], cb:AlertDelegate)="Device::ShowAlertNative"
End

#else

Class DeviceNative Abstract
    Function GetTimestamp:Int()="Device.GetTimestamp"
    Function OpenUrl:Void(url:String)="Device.OpenUrl"
    Function GetLanguage:String()="Device.GetLanguage"
    Function Close:Void()="Device.Close"

    Function FileExistsNative:Bool(path:String)="Device.FileExistsNative"
    Function ShowAlertNative:Void(title:String, message:String, buttons:String[], cb:AlertDelegate)="Device.ShowAlertNative"
End

#endif

Public

Class Device Abstract
    Function GetSize:Vector2D()
        Return New Vector2D(DeviceWidth(), DeviceHeight())
    End

    Function GetTimestamp:Int()
        Return DeviceNative.GetTimestamp()
    End

    Function OpenUrl:Void(url:String)
        DeviceNative.OpenUrl(url)
    End

    Function GetLanguage:String()
        Return DeviceNative.GetLanguage()
    End

    Function FileExists:Bool(path:String)
        Return DeviceNative.FileExistsNative(FixDataPath(path))
    End

    Function ShowAlert:Void(title:String, message:String, buttons:String[], callback:AlertCallback)
        DeviceNative.ShowAlertNative(title, message, buttons, New AlertDelegateBridge(callback))
    End

    Function Close:Void()
        DeviceNative.Close()
    End
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
