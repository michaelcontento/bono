'File modules/iap/iap.monkey

' IMPORTANT: You must manually add StoreKit framework to your xcode project, otherwise it wil not compile
' IMPORTANT: If your app is not "Waiting for review" in iTunes Connect you won't be able to test In App Purchases. Once you get that status you can reject your binary and test peacefully. How weird! 

'*************************************************************
' Written by Roman Budzowski <rbudzowski@gmail.com>
' Free for any usage, but keep in mind MKStore license
' No warranty implied; use at your own risk.
' Released under MIT License
' IAP is a module which is only dedicated for iOS
'************************************************************
' wherever I use product$ it actually means productIdentifier

#if TARGET="ios"

Import "native/MKStoreKit.cpp"


Extern

Function InitInAppPurchases(bundleID$, productList:String[])
Function buyProduct(product$)
Function isProductPurchased(product$)
Function canConsumeProduct:Bool(product$)					' use to check for one unit
'Function canConsumeProductQ:Bool(product$, quantity)		' use to check for certain amount - not implemented yet
Function consumeProduct:Bool(product$)
Function restorePurchasedProducts()
Function isPurchaseInProgress()
Function getPurchaseResult:Int()
Function resetPurchaseResult()

#else

Global iapPurchaseInProgress:Bool = False, iapCount = 0

Function InitInAppPurchases(bundleID$, productList:String[])
End
Function buyProduct(product$)
	iapPurchaseInProgress = True
	iapCount = 0
End
Function isProductPurchased(product$)
End
Function canConsumeProduct:Bool(product$)					' use to check for one unit
End
'Function canConsumeProductQ:Bool(product$, quantity)		' use to check for certain amount - not implemented yet
'End
Function consumeProduct:Bool(product$)
End
Function restorePurchasedProducts()
End

Function isPurchaseInProgress:Bool()
	iapPurchaseInProgress = True
	iapCount = iapCount + 1
	
	If iapCount > 500 Then
		iapPurchaseInProgress = False 
	Endif
	
	Return iapPurchaseInProgress 
End

Function getPurchaseResult:Int()
End
Function resetPurchaseResult()
End

#endif
