Strict

Public

Interface PaymentProvider
    Method Init:Void(idsConsumable:String[], idsNonConsumable:String[])
    Method IsProcessing:Bool()
    Method Purchase:Void(id:String)
    Method IsPurchased:Bool(id:String)
    Method RestorePreviousPurchases:Void()
End
