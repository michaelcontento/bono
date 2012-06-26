Private

Import "native/util.${TARGET}.${LANG}"

Public

Extern

#if TARGET="ios" Or TARGET="glfw"
    Function GetTimestamp:Int()="util::GetTimestamp"
#else
    Function GetTimestamp:Int()="util.GetTimestamp"
#end
