Strict

Private

Import paymentprovider
Import bono.src.exceptions
Import "native/paymentwrapper-google.android.java"

Private Extern

Class PaymentWrapper
    Method Init:Void(publicKey:String)
    Method Purchase:Void(productId:String)
    Method IsBought:Bool(id:String)
    Method IsPurchaseInProgress:Bool()
End

Public

Class PaymentProviderAndroidGoogle Implements PaymentProvider
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

        If Not publicKey
            Throw New RuntimeException("Please configure " +
                "PaymentProviderAndroidGoogle.publicKey with your " +
                "public key first.")
        End

        wrapper = New PaymentWrapper()
        wrapper.Init(publicKey)
    End
End
