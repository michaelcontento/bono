Strict

#If TARGET="ios"

' You need to include the following frameworks to your project:
'   * SystemConfiguration.framework
'   * Flurry.framework
'
' Whereas the first one is a standard apple frameworks and the last one can be
' found here: http://dev.flurry.com

Private

Import "native/flurrybridge.${TARGET}.${LANG}"

Extern

Class Flurry Abstract
    Function StartSession:Void(id:String)="FlurryBridge::StartSession"
    Function LogEvent:Void(name:String)="FlurryBridge::LogEvent"
    Function LogEventTimed:Void(name:String)="FlurryBridge::LogEventTimed"
    Function EndTimedEvent:Void(name:String)="FlurryBridge::EndTimedEvent"
End

#Else

Private

Import bono

Public

Class Flurry Abstract
    Function StartSession:Void(id:String)
        If Target.IS_DEBUG Then Print "[Flurry StartSession] id:" + id
    End

    Function LogEvent:Void(name:String)
        If Target.IS_DEBUG Then Print "[Flurry LogEvent] name:" + name
    End

    Function LogEventTimed:Void(name:String)
        If Target.IS_DEBUG Then Print "[Flurry LogEventTimed] name:" + name
    End

    Function EndTimedEvent:Void(name:String)
        If Target.IS_DEBUG Then Print "[Flurry EndTimedEvent] name:" + name
    End
End

#End
