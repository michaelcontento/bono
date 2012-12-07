Strict

Private

' Just add Apple's StoreKit framework as a dependency to your project

Import paymentprovider
Import bono.vendor.iap

Public

Class PaymentProviderAppleIos Implements PaymentProvider
    Private

    Field initialized:Bool

    Public

    Method IsProcessing:Bool()
        Initialize()
        Return (Not (Not isPurchaseInProgress()))
    End

    Method Purchase:Void(id:String)
        Initialize()
        buyProduct(id)
    End

    Method IsPurchased:Bool(id:String)
        Initialize()
        Return (isProductPurchased(id) > 0)
    End

    Method RestorePreviousPurchases:Void()
        Initialize()
        restorePurchasedProducts()
    End

    Private

    Method Initialize:Void()
        If initialized Then Return
        initialized = True

        InitInAppPurchases("", [])
    End
End
