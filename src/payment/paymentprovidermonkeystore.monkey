Strict

Private

Import bono.src.payment.paymentprovider
Import brl.monkeystore
Import brl.filestream
Import brl.json

Public

Class PaymentProviderMonkeyStore Implements PaymentProvider, IOnOpenStoreComplete, IOnGetOwnedProductsComplete, IOnBuyProductComplete
    Private

    Field store:MonkeyStore = New MonkeyStore()
    Field purchased:JsonObject = New JsonObject()
    Field processing:Bool
    Const TYPE_CONSUMABLES := 1
    Const TYPE_NON_CONSUMABLES := 2

    Public

    '
    ' PaymentProvider API
    '

    Method Init:Void(idsConsumable:String[], idsNonConsumable:String[])
        Load()

        store.AddProducts(idsConsumable, TYPE_CONSUMABLES)
        store.AddProducts(idsNonConsumable, TYPE_NON_CONSUMABLES)
        store.OpenStoreAsync(Self)
    End

    Method IsProcessing:Bool()
        Return processing
    End

    Method IsPurchased:Bool(id:String)
        Return (purchased.GetInt(id) > 0)
    End

    Method Purchase:Void(id:String)
        Local p := store.GetProduct(id)
        If Not p
            LogError("Unable to load product for purchase")
            Return
        End

        processing = True
        store.BuyProductAsync(p, Self)
    End

    Method RestorePreviousPurchases:Void()
        processing = True
        store.GetOwnedProductsAsync(Self)
    End

    '
    ' MonkeyStore Callbacks
    '

    Method OnOpenStoreComplete:Void(result:Int, interrupted:Product[])
        If result <> 0
            LogError("Failed to open store")
            Return
        End

        For Local p := EachIn store.GetProducts()
            LogInfo("Found product: " + p.Identifier())
        End
        LogInfo("Store is now ready")
    End

    Method OnBuyProductComplete:Void(result:Int, p:Product)
        processing = False

        If result = 1
            LogInfo("Purchase cancelled by user")
            Return
        ElseIf result <> 0
            LogError("Purchase failed")
            Return
        End

        LogInfo("Purchased: " + p.Identifier())
        purchased.SetInt(p.Identifier(), 1)

        Save()
    End

    Method OnGetOwnedProductsComplete:Void(result:Int, products:Product[])
        processing = False

        If result = 1
            LogInfo("Restore purchases cancelled by user")
            Return
        ElseIf result <> 0
            LogError("Restore purchases failed")
            Return
        End

        For Local p:Product = EachIn products
            LogInfo("Restored purchase: " + p.Identifier())
            purchased.SetInt(p.Identifier(), 1)
        End

        Save()
    End

    Private

    '
    ' Logging
    '

    Method LogError:Void(msg:String)
        Print "[PaymentProviderMonkeyStore] ERROR: " + msg
    End

    Method LogInfo:Void(msg:String)
        Print "[PaymentProviderMonkeyStore] INFO: " + msg
    End

    '
    ' Purchase Persistence API
    '

    Method Load:Void()
        Local f := FileStream.Open("monkey://internal/.purchases", "r")
        If Not f
            LogError("Unable to load purchases from disk")
            Return
        End

        Local json := f.ReadString()

        Try
            purchased = New JsonObject(json)
            LogInfo("Loaded purchases from disk")
        Catch ex:JsonError
            LogError("Unable to restore purchases from disk (json error)")
        End

        f.Close()
    End

    Method Save:Void()
        Local f := FileStream.Open("monkey://internal/.purchases", "w")
        If Not f
            LogError("Unable to save purchases to disk")
            Return
        End

        Local json := purchased.ToJson()

        Try
            f.WriteString(json)
            LogInfo("Saved purchases to disk")
        Catch ex:StreamWriteError
            LogError("Unable to write to disk: " + ex.ToString())
        End

        f.Close()
    End
End
