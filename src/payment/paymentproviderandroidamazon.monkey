Strict

Private

Import paymentprovider

Public

Class PaymentProviderAndroidAmazon Implements PaymentProvider
    Method IsProcessing:Bool()
        Return False
    End

    Method Purchase:Void(id:String)
    End

    Method IsPurchased:Bool(id:String)
        Return False
    End
End
