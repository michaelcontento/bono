Private

Import "native/util.${TARGET}.${LANG}"

Public

Extern

Class Util Abstract
#If TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="util::GetTimestamp"
#Else
    Function GetTimestamp:Int()="util.GetTimestamp"
#End
End
