Strict

Public

#IF BONO_PAYMENT_FREE
    #Print "Bono: PaymentProviderAlias set to PaymentProviderFree"
    Import bono.src.payment.paymentproviderfree
    Alias PaymentProviderAlias = PaymentProviderFree
#ElseIf TARGET="ios"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAppleIos"
    Import bono.src.payment.paymentproviderappleios
    Alias PaymentProviderAlias = PaymentProviderAppleIos
#ElseIf TARGET="glfw" Or TARGET="html5"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAutoUnlock"
    Import bono.src.payment.paymentproviderautounlock
    Alias PaymentProviderAlias = PaymentProviderAutoUnlock
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="google"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAndroidGoogle"
    Import bono.src.payment.paymentproviderandroidgoogle
    Alias PaymentProviderAlias = PaymentProviderAndroidGoogle
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="amazon"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAndroidAmazon"
    Import bono.src.payment.paymentproviderandroidamazon
    Alias PaymentProviderAlias = PaymentProviderAndroidAmazon
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="samsung"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAndroidSamsung"
    Import bono.src.payment.paymentproviderandroidsamsung
    Alias PaymentProviderAlias = PaymentProviderAndroidSamsung
#Else
    #Error "BONO: Unable to detect the right PaymentProvider"
#End
