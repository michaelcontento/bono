Strict

Public

#IF BONO_PAYMENT_FREE Or (TARGET="android" And BONO_ANDROID_MARKET="amazon-underground")
    #Print "Bono: PaymentProviderAlias set to PaymentProviderFree"
    Import bono.src.payment.paymentproviderfree
    Alias PaymentProviderAlias = PaymentProviderFree
#ElseIf TARGET="ios" Or (TARGET="android" And BONO_ANDROID_MARKET="google")
    #Print "Bono: PaymentProviderAlias set to PaymentProviderMonkeyStore"
    Import bono.src.payment.paymentprovidermonkeystore
    Alias PaymentProviderAlias = PaymentProviderMonkeyStore
#ElseIf TARGET="glfw" Or TARGET="html5"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAutoUnlock"
    Import bono.src.payment.paymentproviderautounlock
    Alias PaymentProviderAlias = PaymentProviderAutoUnlock
#ElseIf TARGET="android" And BONO_ANDROID_MARKET="amazon"
    #Print "Bono: PaymentProviderAlias set to PaymentProviderAndroidAmazon"
    Import bono.src.payment.paymentproviderandroidamazon
    Alias PaymentProviderAlias = PaymentProviderAndroidAmazon
#Else
    #Error "BONO: Unable to detect the right PaymentProvider"
#End
