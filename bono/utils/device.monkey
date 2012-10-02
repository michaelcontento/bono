Private

Import "native/device.${TARGET}.${LANG}"

Public

Extern

Class Device Abstract
#If TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="device::GetTimestamp"
    Function OpenUrl:Void(url:String)="device::OpenUrl"
#Else
    Function GetTimestamp:Int()="device.GetTimestamp"
    Function OpenUrl:Void(url:String)="device.OpenUrl"
#End
End
