Private

Import "native/util.${TARGET}.${LANG}"

Public

Extern

Class Util Abstract
#If TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="util::GetTimestamp"
    Function OpenUrl:Void(url:String)="util::OpenUrl"
#Else
    Function GetTimestamp:Int()="util.GetTimestamp"
    Function OpenUrl:Void(url:String)="util.OpenUrl"
#End
End
