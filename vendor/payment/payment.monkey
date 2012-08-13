Import product
Import service
Import universalproduct

#if TARGET="android"
Import "native/payment.${TARGET}.${LANG}"
Public
Extern
	Class PaymentWrapper
		Method Init:Void()
		Method Purchase:Void(productId$)
		Method IsBought?(id$)
		Method IsPurchaseInProgress?()
	End

	Class Security="com.payment.Security"
		Function SetPublicKey(k$)="com.payment.Security.SetPublicKey"
	End

Public


#end

#Rem
how to do on android:

add:
	<uses-permission android:name="com.android.vending.BILLING" />
to AndroidManifest.xml

#End
