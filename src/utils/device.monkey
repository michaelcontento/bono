Private

Import bono
Import mojo.graphics
Import "native/device.${TARGET}.${LANG}"

Class DeviceNonNative Abstract
    Function GetSize:Vector2D()
        Return New Vector2D(DeviceWidth(), DeviceHeight())
    End
End

Extern

Class Device Extends DeviceNonNative Abstract
#If TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="Device::GetTimestamp"
    Function OpenUrl:Void(url:String)="Device::OpenUrl"
    Function GetLanguage:String()="Device::GetLanguage"
#Else
    Function GetTimestamp:Int()="Device.GetTimestamp"
    Function OpenUrl:Void(url:String)="Device.OpenUrl"
    Function GetLanguage:String()="Device.GetLanguage"
#End
End
