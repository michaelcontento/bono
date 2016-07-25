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

#If BONO_ADS_DISABLED

#Print "Bono: Appodeal ads have been disabled"

#Else

Import bono.vendor.appodeal.appodeal

Const AdTypes := AdType.NON_SKIPPABLE_VIDEO | AdType.REWARDED_VIDEO | AdType.INTERSTITIAL

#EndIf

Public

Class Appodeal Abstract
    Function StartSession:Void(appKey:String)
#If Not BONO_ADS_DISABLED
        Local appo := AdAppodeal.GetAppodeal()

        appo.disableLocationPermissionCheck()
        appo.initialize(appKey, AdTypes);
        appo.setAutoCache(AdTypes, True)
#EndIf
    End

    Function Show:Void()
#If Not BONO_ADS_DISABLED
        AdAppodeal.GetAppodeal().show(AdTypes)
#EndIf
    End

    Function Hide:Void()
#If Not BONO_ADS_DISABLED
        AdAppodeal.GetAppodeal().hide(AdTypes)
#EndIf
    End
End
