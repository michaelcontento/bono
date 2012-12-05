Strict

Private

Import paymentprovider
Import "native/paymentwrapper-amazon.android.java"

Private Extern

Class PaymentWrapper
    Method Init:Void()
    Method Purchase:Void(productId$)
    Method IsBought?(id$)
    Method IsPurchaseInProgress?()
End

Public

Class PaymentProviderAndroidAmazon Implements PaymentProvider
    Private

    Field wrapper:PaymentWrapper

    Public

    Field publicKey:String

    Method IsProcessing:Bool()
        Initialize()
        Return wrapper.IsPurchaseInProgress()
    End

    Method Purchase:Void(id:String)
        Initialize()
        wrapper.Purchase(id)
    End

    Method IsPurchased:Bool(id:String)
        Initialize()
        Return wrapper.IsBought(id)
    End

    Private

    Method Initialize:Void()
        If wrapper Then Return

        wrapper = New PaymentWrapper()
        wrapper.Init()
    End
End
