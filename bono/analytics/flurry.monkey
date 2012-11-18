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

Class Flurry Abstract
    Function StartSession:Void(id:String)
        Print "[Flurry StartSession] id:" + id
    End

    Function LogEvent:Void(name:String)
        Print "[Flurry LogEvent] name:" + name
    End

    Function LogEventTimed:Void(name:String)
        Print "[Flurry LogEventTimed] name:" + name
    End

    Function EndTimedEvent:Void(name:String)
        Print "[Flurry EndTimedEvent] name:" + name
    End
End

#End
