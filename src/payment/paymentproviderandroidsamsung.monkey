Strict

Private

Import bono
Import bono.src.payment.paymentprovider
Import "native/paymentwrapper-samsung.android.java"

Private Extern

Class PaymentWrapper
    Method Init:Void(itemGroupId:String)
    Method Purchase:Void(productId:String)
    Method IsBought:Bool(id:String)
    Method IsPurchaseInProgress:Bool()
End

Public

Class PaymentProviderAndroidSamsung Implements PaymentProvider
    Private

    Field wrapper:PaymentWrapper

    Public

    Field itemGroupId:String

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

        If Not itemGroupId
            Throw New RuntimeException("Please configure " +
                "PaymentProviderAndroidSamsung.itemGroupId with the " +
                "item group id of your app first.")
        End

        wrapper = New PaymentWrapper()
        wrapper.Init(itemGroupId)
    End
End
