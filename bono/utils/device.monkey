Private

Import "native/device.${TARGET}.${LANG}"

Public

Extern

Class Device Abstract
#If TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="Device::GetTimestamp"
    Function OpenUrl:Void(url:String)="Device::OpenUrl"
#Else
    Function GetTimestamp:Int()="Device.GetTimestamp"
    Function OpenUrl:Void(url:String)="Device.OpenUrl"
#End
End
