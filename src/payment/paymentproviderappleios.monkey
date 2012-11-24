Strict

Private

Import paymentprovider

Public

Class PaymentProviderAppleIos Implements PaymentProvider
    Method IsProcessing:Bool()
        Return False
    End

    Method Purchase:Void(id:String)
    End

    Method IsPurchased:Bool(id:String)
        Return False
    End

    Method RestorePreviousPurchases:Void()
    End
End
