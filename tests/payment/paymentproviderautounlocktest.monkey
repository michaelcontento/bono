Strict

Private

Import bono
Import bono.src.payment

#If TARGET<>"glfw"
Import bono.src.payment.paymentproviderautounlock
#End

Public

Class PaymentProviderAutoUnlockTest Extends TestCase
    Field provider:PaymentProviderAutoUnlock

    Method SetUp:Void()
        provider = New PaymentProviderAutoUnlock()
    End

    Method TestIsProcessingReturnsFalse:Void()
        AssertFalse(provider.IsProcessing())
    End

    Method TestPurchaseShouldUnlock:Void()
        provider.Purchase("foo")
        AssertTrue(provider.IsPurchased("foo"))
    End

    Method TestShouldNotBePurchasedByDefault:Void()
        AssertFalse(provider.IsPurchased("foo"))
    End

    Method TestImplementsPaymentProvider:Void()
        AssertNotNull(PaymentProvider(provider))
    End
End
