Strict

Public

#If TARGET="ios"
    Import paymentproviderappleios
    Alias PaymentProviderAlias = PaymentProviderAppleIos
#ElseIf TARGET="glfw"
    Import paymentproviderautounlock
    Alias PaymentProviderAlias = PaymentProviderAutoUnlock
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="google"
    Import paymentproviderandroidgoogle
    Alias PaymentProviderAlias = PaymentProviderAndroidGoogle
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="amazon"
    Import paymentproviderandroidamazon
    Alias PaymentProviderAlias = PaymentProviderAndroidAmazon
#Else
    #Error "BONO: Unable to detect the right PaymentProvider"
#End
