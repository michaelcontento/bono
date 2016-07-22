Strict

' ============================
' == COMMERCIAL BREAK START ==
' ============================
'
' Tired of setting things up? Monkey-Wizard to the rescue!
' --> https://github.com/michaelcontento/monkey-wizard
'
' And the whole thing should be easy as:
' --> wizard IosAppodeal ../myproject/myproject.build/ios
'
' ============================
' ==  COMMERCIAL BREAK END  ==
' ============================

Private

#If Not BONO_ADS_DISABLED

Import bono.vendor.appodeal.appodeal

#EndIf

Public

Class Appodeal Abstract
    Function StartSession:Void(appKey:String)
#If Not BONO_ADS_DISABLED
        Local appo := AdAppodeal.GetAppodeal()

        appo.disableLocationPermissionCheck()
        appo.initialize(appKey, AdType.INTERSTITIAL | AdType.NON_SKIPPABLE_VIDEO);

        appo.setAutoCache(AdType.NON_SKIPPABLE_VIDEO, True)
        appo.setAutoCache(AdType.INTERSTITIAL, True)
#EndIf
    End

    Function Show:Void()
#If Not BONO_ADS_DISABLED
        Local appo := AdAppodeal.GetAppodeal()

        If appo.isLoaded(AdType.NON_SKIPPABLE_VIDEO)
            appo.show(AdType.NON_SKIPPABLE_VIDEO)
            Return
        End

        If appo.isLoaded(AdType.INTERSTITIAL)
            appo.show(AdType.INTERSTITIAL)
            Return
        End
#EndIf
    End

    Function Hide:Void()
#If Not BONO_ADS_DISABLED
        Local appo := AdAppodeal.GetAppodeal()

        appo.hide(AdType.NON_SKIPPABLE_VIDEO)
        appo.hide(AdType.INTERSTITIAL)
#EndIf
    End
End
