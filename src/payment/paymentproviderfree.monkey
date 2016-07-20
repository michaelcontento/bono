Strict

Private

Import bono.src.payment.paymentprovider

Public

Class PaymentProviderFree Implements PaymentProvider
    Public

    Method IsProcessing:Bool()
        Return False
    End

    Method Purchase:Void(id:String)
    End

    Method IsPurchased:Bool(id:String)
        Return True
    End
End
