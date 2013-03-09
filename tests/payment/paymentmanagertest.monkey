Strict

Private

Import bono
Import bono.src.payment.paymentmanager
Import bono.src.payment.paymentprovider

Class StubPaymentProvider Implements PaymentProvider
    Field timesIsProcessingCalled:Int
    Field timesPurchaseCalled:Int
    Field timesIsPurchasedCalled:Int
    Field lastIdSeen:String
    Field returnValeIsPurchased:Bool
    Field returnValeIsProcessing:Bool

    Method IsProcessing:Bool()
        timesIsProcessingCalled += 1
        Return returnValeIsProcessing
    End

    Method Purchase:Void(id:String)
        timesPurchaseCalled += 1
        lastIdSeen = id
    End

    Method IsPurchased:Bool(id:String)
        timesIsPurchasedCalled += 1
        lastIdSeen = id
        Return returnValeIsPurchased
    End
End

Public

Class PaymentManagerTest Extends TestCase
    Field provider:StubPaymentProvider
    Field manager:PaymentManager

    Method SetUp:Void()
        provider = New StubPaymentProvider()
        manager = New PaymentManager(provider)
    End

    Method TestPurchaseUnmodified:Void()
        manager.Purchase("foo")

        AssertEquals(1, provider.timesPurchaseCalled)
        AssertEquals("foo", provider.lastIdSeen)
    End

    Method TestIsPaymentProvider:Void()
        AssertNotNull(PaymentProvider(manager))
    End

    Method TestPurchaseWithPrefix:Void()
        manager.idPrefix = "prefix."
        manager.Purchase("foo")

        AssertEquals(1, provider.timesPurchaseCalled)
        AssertEquals("prefix.foo", provider.lastIdSeen)
    End

    Method TestPurchaseWithAlias:Void()
        manager.idAlias.Set("foo", "alias")
        manager.Purchase("foo")

        AssertEquals(1, provider.timesPurchaseCalled)
        AssertEquals("alias", provider.lastIdSeen)
    End

    Method TestPurchaseWithPrefixAndAlias:Void()
        manager.idAlias.Set("foo", "alias")
        manager.idPrefix = "prefix."
        manager.Purchase("foo")

        AssertEquals(1, provider.timesPurchaseCalled)
        AssertEquals("prefix.alias", provider.lastIdSeen)
    End

    Method TestIsPurchasedUnmodified:Void()
        manager.IsPurchased("foo")

        AssertEquals(1, provider.timesIsPurchasedCalled)
        AssertEquals("foo", provider.lastIdSeen)
    End

    Method TestIsPurchasedWithPrefix:Void()
        manager.idPrefix = "prefix."
        manager.IsPurchased("foo")

        AssertEquals(1, provider.timesIsPurchasedCalled)
        AssertEquals("prefix.foo", provider.lastIdSeen)
    End

    Method TestIsPurchasedWithAlias:Void()
        manager.idAlias.Set("foo", "alias")
        manager.IsPurchased("foo")

        AssertEquals(1, provider.timesIsPurchasedCalled)
        AssertEquals("alias", provider.lastIdSeen)
    End

    Method TestIsPurchasedWithPrefixAndAlias:Void()
        manager.idAlias.Set("foo", "alias")
        manager.idPrefix = "prefix."
        manager.IsPurchased("foo")

        AssertEquals(1, provider.timesIsPurchasedCalled)
        AssertEquals("prefix.alias", provider.lastIdSeen)
    End

    Method TestIsProcessing:Void()
        manager.IsProcessing()
        AssertEquals(1, provider.timesIsProcessingCalled)
    End

    Method TestIsPurchasedReturnValue:Void()
        provider.returnValeIsPurchased = True
        AssertTrue(manager.IsPurchased("foo"))

        provider.returnValeIsPurchased = False
        AssertFalse(manager.IsPurchased("foo"))
    End

    Method TestIsProcessingReturnValue:Void()
        provider.returnValeIsProcessing = True
        AssertTrue(manager.IsProcessing())

        provider.returnValeIsProcessing = False
        AssertFalse(manager.IsProcessing())
    End

    Method TestRestorePreviousPurchase:Void()
        #If TARGET="ios"
        MarkTestIncomplete("RestorePreviousPurchases test not implemented")
        #Else
        manager.RestorePreviousPurchases()
        #End
    End
End
