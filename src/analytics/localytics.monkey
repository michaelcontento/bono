Strict

#if TARGET="android"

Private

Import "native/localyticsbridge.${TARGET}.${LANG}"

Extern

Class Localytics="LocalyticsBridge"
    Function StartSession:Void(id:String)
    Function Suspend:Void()
    Function Resume:Void()
    Function TagEvent:Void(name:String)
End

#Else

Private

Import bono

Public

Class Localytics Abstract
    Function StartSession:Void(id:String)
        If Target.IS_DEBUG Then Print "[Localytics StartSession] id: " + id
    End

    Function Suspend:Void()
        If Target.IS_DEBUG Then Print "[Localytics Suspend]"
    End

    Function Resume:Void()
        If Target.IS_DEBUG Then Print "[Localytics Resume]"
    End

    Function TagEvent:Void(name:String)
        If Target.IS_DEBUG Then Print "[Localytics TagEvent] name: " + name
    End
End

#End
