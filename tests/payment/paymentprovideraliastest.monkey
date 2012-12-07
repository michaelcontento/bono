Strict

Private

Import bono
Import bono.src.payment

Public

Class PaymentProviderAliasTest Extends TestCase
    Method TestRightAlias:Void()
        #If TARGET="glfw"
            AssertNotNull(PaymentProviderAutoUnlock(New PaymentProviderAlias()))
        #Else
            MarkTestSkipped("Alias for the used TARGET not defined")
        #End
    End
End
