Strict

#If TARGET="ios"

' ============================
' == COMMERCIAL BREAK START ==
' ============================
'
' Tired of setting things up? Monkey-Wizard to the rescue!
' --> https://github.com/michaelcontento/monkey-wizard
'
' And the whole thing should be easy as:
' --> wizard IosAppirater ../myproject/myproject.build/ios
'
' ============================
' ==  COMMERCIAL BREAK END  ==
' ============================
'
'
' You need to include the following frameworks to your project:
'   * CFNetwork.framework
'   * SystemConfiguration.framework
'   * StoreKit.framework
'   * Appirater (=> https://github.com/arashpayan/appirater)

Private

Import "native/appirater.ios.cpp"

Extern

Class Appirater Abstract
    Function Launched:Void(canPrompt:Bool=True)="AppiraterBridge::Launched"
    Function EnteredForeground:Void(canPrompt:Bool=True)="AppiraterBridge::EnteredForeground"
    Function UserDidSignificantEvent:Void(canPrompt:Bool=True)="AppiraterBridge::UserDidSignificantEvent"
    Function SetAppId:Void(id:String)="AppiraterBridge::SetAppId"
    Function SetDaysUntilPrompt:Void(days:Int)="AppiraterBridge::SetDaysUntilPrompt"
    Function SetUsesUntilPrompt:Void(days:Int)="AppiraterBridge::SetUsesUntilPrompt"
    Function SetSignificantEventsUntilPrompt:Void(uses:Int)="AppiraterBridge::SetSignificantEventsUntilPrompt"
    Function SetTimeBeforeReminding:Void(time:Int)="AppiraterBridge::SetTimeBeforeReminding"
    Function SetDebug:Void(flag:Bool)="AppiraterBridge::SetDebug"
    Function RateApp:Void()="AppiraterBridge::RateApp"
End

#Else

Private

Import bono

Public

Class Appirater Abstract
    Function Launched:Void(canPrompt:Bool=True)
        If Target.IS_DEBUG Then Print "[Appirater Launched] canPrompt: " + BoolToString(canPrompt)
    End

    Function EnteredForeground:Void(canPrompt:Bool=True)
        If Target.IS_DEBUG Then Print "[Appirater EnteredForeground] canPrompt: " + BoolToString(canPrompt)
    End

    Function UserDidSignificantEvent:Void(canPrompt:Bool=True)
        If Target.IS_DEBUG Then Print "[Appirater UserDidSignificantEvent] canPrompt: " + BoolToString(canPrompt)
    End

    Function SetAppId:Void(id:String)
        If Target.IS_DEBUG Then Print "[Appirater SetAppId] id: " + id
    End

    Function SetDaysUntilPrompt:Void(days:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetDaysUntilPrompt] days: " + days
    End

    Function SetUsesUntilPrompt:Void(days:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetUsesUntilPrompt] days: " + days
    End

    Function SetSignificantEventsUntilPrompt:Void(uses:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetSignificantEventsUntilPrompt] uses: " + uses
    End

    Function SetTimeBeforeReminding:Void(time:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetTimeBeforeReminding] time: " + time
    End

    Function SetDebug:Void(flag:Bool)
        If Target.IS_DEBUG Then Print "[Appirater SetDebug] flag: " + BoolToString(flag)
    End

    Function RateApp:Void(flag:Bool)
        If Target.IS_DEBUG Then Print "[Appirater RateApp]"
    End

    Private

    Function BoolToString:String(flag:Bool)
        If flag Then Return "YES"
        Return "NO"
    End
End

#End
