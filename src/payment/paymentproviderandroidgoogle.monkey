Strict

Private

Import paymentprovider

Public

Class PaymentProviderAndroidGoogle Implements PaymentProvider
    Method IsProcessing:Bool()
        Return False
    End

    Method Purchase:Void(id:String)
    End

    Method IsPurchased:Bool(id:String)
        Return False
    End
End

