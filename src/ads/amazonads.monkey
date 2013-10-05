Strict

' ============================
' == COMMERCIAL BREAK START ==
' ============================
'
' Tired of setting things up? Monkey-Wizard to the rescue!
' --> https://github.com/michaelcontento/monkey-wizard
'
' And the whole thing should be easy as:
' --> wizard AmazonAds ../myproject/myproject.build/android
'
' ============================
' ==  COMMERCIAL BREAK END  ==
' ============================

#if TARGET="android" And BONO_ANDROID_MARKET="amazon"

' Read the official Amazon Quick Start Guide:
'  https://developer.amazon.com/sdk/mobileads/quick-start.html

Private

Import "native/amazonadsbridge.${TARGET}.${LANG}"

Extern

Class AmazonAds Abstract
    Function StartSession:Void(id:String)="AmazonAdsBridge.StartSession"
    Function Show:Void()="AmazonAdsBridge.Show"
    Function Hide:Void()="AmazonAdsBridge.Hide"
    Function EnableTesting:Void()="AmazonAdsBridge.EnableTesting"
    Function DisableTesting:Void()="AmazonAdsBridge.DisableTesting"
End

#else

Private

Import bono

Public

Class AmazonAds Abstract
    Function StartSession:Void(id:String)
        If Target.IS_DEBUG Then Print "[AmazonAds StartSession]"
    End

    Function Show:Void()
        If Target.IS_DEBUG Then Print "[AmazonAds Show]"
    End

    Function Hide:Void()
        If Target.IS_DEBUG Then Print "[AmazonAds Hide]"
    End

    Function EnableTestingWithAds:Void()
        If Target.IS_DEBUG Then Print "[AmazonAds EnableTesting]"
    End

    Function DisableTesting:Void()
        If Target.IS_DEBUG Then Print "[AmazonAds DisableTesting]"
    End
End

#endif
