Strict

#If TARGET="ios"

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
End

#Else

Public

Class Appirater Abstract
    Function Launched:Void(canPrompt:Bool=True)
        If Target.IS_DEBUG Then Print "[Appirater Launched:" + canPrompt + "]"
    End

    Function EnteredForeground:Void(canPrompt:Bool=True)
        If Target.IS_DEBUG Then Print "[Appirater EnteredForeground:" + canPrompt + "]"
    End

    Function UserDidSignificantEvent:Void(canPrompt:Bool=True)
        If Target.IS_DEBUG Then Print "[Appirater UserDidSignificantEvent:" + canPrompt + "]"
    End

    Function SetAppId:Void(id:String)
        If Target.IS_DEBUG Then Print "[Appirater SetAppId:" + id + "]"
    End

    Function SetDaysUntilPrompt:Void(days:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetDaysUntilPrompt:" + days + "]"
    End

    Function SetUsesUntilPrompt:Void(days:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetUsesUntilPrompt:" + days + "]"
    End

    Function SetSignificantEventsUntilPrompt:Void(uses:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetSignificantEventsUntilPrompt:" + uses + "]"
    End

    Function SetTimeBeforeReminding:Void(time:Int)
        If Target.IS_DEBUG Then Print "[Appirater SetTimeBeforeReminding:" + time + "]"
    End

    Function SetDebug:Void(flag:Bool)
        If Target.IS_DEBUG Then Print "[Appirater SetDebug:" + flag + "]"
    End
End

#End
