Strict

#If TARGET="ios"

Private

Import "native/vunglebridge.${TARGET}.${LANG}"

Extern

Class Vungle Abstract
    Function StartWithPubAppID:Void(id:String)="VungleBridge::StartWithPubAppID"
    Function AdIsAvailable:Bool()="VungleBridge::AdIsAvailable"
    Function PlayModalAd:Void()="VungleBridge::PlayModalAd"
End

#Else

Private

Import bono

Public

Class Vungle Abstract
    Function StartWithPubAppID:Void(id:String)
        If Target.IS_DEBUG Then Print "[Vungle StartWithPubAppID]"
    End

    Function AdIsAvailable:Bool()
        If Target.IS_DEBUG Then Print "[Vungle AdIsAvailable]"
        Return False
    End

    Function PlayModalAd:Void()
        If Target.IS_DEBUG Then Print "[Vungle PlayModalAd]"
    End
End

#End
