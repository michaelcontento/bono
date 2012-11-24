Strict

Private

Import paymentprovideralias

Public

Class PaymentManager
    Private

    Field provider:PaymentProviderAlias
    Global instance:PaymentManager

    Public

    Field idPrefix:String = ""

    Method IsPurchased:Bool(id:String)
        Local result:Bool = GetProvider().IsPurchased(idPrefix + id)

        If result
            DebugLog("IsPurchased", id + " => True")
        Else
            DebugLog("IsPurchased", id + " => False")
        End

        Return result
    End

    Method Purchase:Void(id:String)
        DebugLog("Purchase", id)
        GetProvider().Purchase(idPrefix + id)
    End

    Method IsProcessing:Bool()
        Return GetProvider().IsProcessing()
    End

    Method RestorePreviousPurchases:Void()
        #If TARGET="ios"
        DebugLog("RestorePreviousPurchases")
        GetProvider().RestorePreviousPurchases()
        #End
    End

    Method GetProvider:PaymentProviderAlias()
        If Not provider Then provider = New PaymentProviderAlias()
        Return provider
    End

    Function GetInstance:PaymentManager()
        If Not instance Then instance = New PaymentManager()
        Return instance
    End

    Private

    Method DebugLog:Void(func:String, message:String="")
        #If CONFIG="debug"
        Print "[PaymentManager " + func + "] " + message
        #End
    End
End
