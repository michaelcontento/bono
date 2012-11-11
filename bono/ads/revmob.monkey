Strict

#If TARGET="ios"

' You need to include the following frameworks to your project:
'   * RevMobAds.framework
'   * SystemConfiguration.framework
'   * StoreKit.framework
'   * AdSupport.framework
'
' Whereas the last three are standard apple frameworks and the first one can be
' found here: http://sdk.revmob.com/ios

Private

Import "native/revmobbridge.${TARGET}.${LANG}"

Extern

Class Revmob Abstract
    Function StartSession:Void(id:String)="RevmobBridge::StartSession"
    Function ShowFullscreen:Void()="RevmobBridge::ShowFullscreen"
    Function ShowBanner:Void()="RevmobBridge::ShowBanner"
    Function HideBanner:Void()="RevmobBridge::HideBanner"
    Function OpenAdLink:Void()="RevmobBridge::OpenAdLink"
    Function ShowPopup:Void()="RevmobBridge::ShowPopup"
    Function EnableTestingWithAds:Void()="RevmobBridge::EnableTestingWithAds"
    Function EnableTestingWithoutAds:Void()="RevmobBridge::EnableTestingWithoutAds"
    Function DisableTesting:Void()="RevmobBridge::DisableTesting"
End

#Else

Class Revmob Abstract
    Function StartSession:Void(id:String)
        Print "[Revmob StartSession]"
    End

    Function ShowFullscreen:Void()
        Print "[Revmob ShowFullscreen]"
    End

    Function ShowBanner:Void()
        Print "[Revmob ShowBanner]"
    End

    Function HideBanner:Void()
        Print "[Revmob HideBanner]"
    End

    Function OpenAdLink:Void()
        Print "[Revmob OpenAdLink]"
    End

    Function ShowPopup:Void()
        Print "[Revmob ShowPopup]"
    End

    Function EnableTestingWithAds:Void()
        Print "[Revmob EnableTestingWithAds]"
    End

    Function EnableTestingWithoutAds:Void()
        Print "[Revmob EnableTestingWithoutAds]"
    End

    Function DisableTesting:Void()
        Print "[Revmob DisableTesting]"
    End
End

#End
