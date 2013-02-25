Strict

#if TARGET="android"

Private

Import "native/localyticsbridge.${TARGET}.${LANG}"

Extern

Class Localytics Abstract
    Function StartSession:Void(id:String)="LocalyticsBridge.StartSession"
    Function Suspend:Void()="LocalyticsBridge.Suspend"
    Function Resume:Void()="LocalyticsBridge.Resume"
    Function TagEvent:Void(name:String)="LocalyticsBridge.TagEvent"
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
