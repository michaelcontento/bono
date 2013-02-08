Private

Import bono
Import brl
Import mojo.graphics
Import "native/device.${TARGET}.${LANG}"

Class AsyncAlertCallbackTrigger Implements IAsyncEventSource
    Private

    Field lastAlertId:Int
    Field callback:AlertCallback

    Public

    Method New()
        Throw New InvalidConstructorException("use New(AlertCallback)");
    End

    Method New(callback:AlertCallback)
        Self.callback = callback

        lastAlertId = Device._GetAlertId()
        AddAsyncEventSource(Self)
    End

    Method UpdateAsyncEvents:Void()
        Local currentId := Device._GetAlertId()
        If currentId <= lastAlertId Then Return

        callback.OnAlertCallback(
            Device._GetAlertIndex(),
            Device._GetAlertTitle())

        lastAlertId = currentId
        RemoveAsyncEventSource(Self)
    End
End

Class DeviceNonNative Abstract
    Function GetSize:Vector2D()
        Return New Vector2D(DeviceWidth(), DeviceHeight())
    End

    Function ShowAlert:Void(title:String, message:String, buttons:String[], callback:AlertCallback)
        New AsyncAlertCallbackTrigger(callback)
        Device._ShowAlert(title, message, buttons)
    End
End

Extern

Class Device Extends DeviceNonNative Abstract
#If TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="Device::GetTimestamp"
    Function OpenUrl:Void(url:String)="Device::OpenUrl"
    Function GetLanguage:String()="Device::GetLanguage"
    Function _ShowAlert:Void(title:String, message:String, buttons:String[])="Device::_ShowAlert"
    Function _GetAlertId:Int()="Device::_GetAlertId"
    Function _GetAlertIndex:Int()="Device::_GetAlertIndex"
    Function _GetAlertTitle:String()="Device::_GetAlertTitle"
#Else
    Function GetTimestamp:Int()="Device.GetTimestamp"
    Function OpenUrl:Void(url:String)="Device.OpenUrl"
    Function GetLanguage:String()="Device.GetLanguage"
    Function _ShowAlert:Void(title:String, message:String, buttons:String[])="Device._ShowAlert"
    Function _GetAlertId:Int()="Device._GetAlertId"
    Function _GetAlertIndex:Int()="Device._GetAlertIndex"
    Function _GetAlertTitle:String()="Device._GetAlertTitle"
#End
End
