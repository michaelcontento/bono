Strict

Private

Import bono.src.payment.paymentprovider

Public

Class PaymentProviderAutoUnlock Implements PaymentProvider
    Private

    Field purchased:StringSet = New StringSet()

    Public

    Method Init:Void(idsConsumable:String[], idsNonConsumable:String[])
    End

    Method IsProcessing:Bool()
        Return False
    End

    Method Purchase:Void(id:String)
        purchased.Insert(id)
    End

    Method IsPurchased:Bool(id:String)
        Return purchased.Contains(id)
    End

    Method RestorePreviousPurchases:Void()
    End
End
