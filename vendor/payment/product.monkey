Import iap
Import service

Class PaymentProduct Abstract
	Field purchased?
	Field startBuy?
	Field service:PaymentService

	Method New()
		purchased = False
		startBuy = False
	End

	Method SetService:Void(s:PaymentService)
		service = s
	End

	Method GetAppleId$() Abstract
	Method GetAndroidId$() Abstract

	Method Buy:Void()
		startBuy = True
		buyProduct(GetAppleId())
#if TARGET="android"
		service.androidPayment.Purchase(GetAndroidId())
#end
	End

	Method IsProductPurchased?()
#if TARGET="ios"
		If (startBuy And Not IsPurchaseInProgress())
			UpdatePurchasedState()
		End
#elseif TARGET="android"
		If (purchased) Then Return True
		purchased = service.androidPayment.IsBought(GetAndroidId())
#end
		Return purchased
	End

	Method UpdatePurchasedState:Void()
#if TARGET="ios"
		purchased = (isProductPurchased(GetAppleId()) > 0)
#elseif TARGET="android"
		purchased = service.androidPayment.IsBought(GetAndroidId())
#end

		'todo: implment for android
	End

	Method IsPurchaseInProgress?()
#if TARGET="ios"
		Return (isPurchaseInProgress() > 0)
#elseif TARGET="android"
		Return service.androidPayment.IsPurchaseInProgress()
#end
	End
End
