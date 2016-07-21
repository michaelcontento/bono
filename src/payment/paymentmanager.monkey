Strict

Private

Import bono
Import bono.src.payment.paymentprovider
Import bono.src.payment.paymentprovideralias

Public

Class PaymentManager Implements PaymentProvider
    Private

    Field provider:PaymentProvider
    Global instance:PaymentManager
    Global initialized:Bool

    Public

    Field idPrefix:String = ""
    Field idAlias:StringMap<String> = New StringMap<String>()

    Method New()
        Throw New InvalidConstructorException("use New(PaymentProvider)")
    End

    Method New(provider:PaymentProvider)
        Self.provider = provider
    End

    Method IsPurchased:Bool(id:String)
        Return GetProvider().IsPurchased(ResolveId(id))
    End

    Method Purchase:Void(id:String)
        DebugLog("Purchase", "id: " + ResolveId(id))
        GetProvider().Purchase(ResolveId(id))
    End

    Method IsProcessing:Bool()
        Return GetProvider().IsProcessing()
    End

    Method RestorePreviousPurchases:Void()
        DebugLog("RestorePreviousPurchases")
        GetProvider().RestorePreviousPurchases()
    End

    Method Init:Void(idsConsumable:String[], idsNonConsumable:String[])
        GetProvider().Init(idsConsumable, idsNonConsumable);
    End

    Method Init:Void()
        If initialized
            Throw New RuntimeException("Payment already initialized!")
        End
        initialized = True

        Local ids := new List<String>()
        For Local id:String = EachIn idAlias.Values()
            ids.AddLast(idPrefix + id)
        End

        GetProvider().Init([], ids.ToArray());
    End

    Method GetProvider:PaymentProvider()
        IF Not initialized
            Throw New RuntimeException("Payment not initialized - call Init() first!")
        End
        Return provider
    End

    Function GetInstance:PaymentManager()
        If Not instance
            instance = New PaymentManager(New PaymentProviderAlias())
        End

        Return instance
    End

    Private

    Method ResolveId:String(id:String)
        If idAlias.Contains(id)
            Return idPrefix + idAlias.Get(id)
        Else
            Return idPrefix + id
        End
    End

    Method DebugLog:Void(func:String, message:String="")
        Print "[PaymentManager " + func + "] " + message
    End
End
