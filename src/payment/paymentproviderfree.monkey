Strict

Private

Import bono.src.payment.paymentprovider

Public

Class PaymentProviderFree Implements PaymentProvider
    Public

    Method Init:Void(idsConsumable:String[], idsNonConsumable:String[])
    End

    Method IsProcessing:Bool()
        Return False
    End

    Method Purchase:Void(id:String)
    End

    Method IsPurchased:Bool(id:String)
        Return True
    End

    Method RestorePreviousPurchases:Void()
    End
End
