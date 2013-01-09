Strict

Public

#If TARGET="ios"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAppleIos"
    Import paymentproviderappleios
    Alias PaymentProviderAlias = PaymentProviderAppleIos
#ElseIf TARGET="glfw" Or TARGET="html5"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAutoUnlock"
    Import paymentproviderautounlock
    Alias PaymentProviderAlias = PaymentProviderAutoUnlock
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="google"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAndroidGoogle"
    Import paymentproviderandroidgoogle
    Alias PaymentProviderAlias = PaymentProviderAndroidGoogle
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="amazon"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAndroidAmazon"
    Import paymentproviderandroidamazon
    Alias PaymentProviderAlias = PaymentProviderAndroidAmazon
#Else
    #Error "BONO: Unable to detect the right PaymentProvider"
#End
