Strict

Public

Interface PaymentProvider
    Method IsProcessing:Bool()
    Method Purchase:Void(id:String)
    Method IsPurchased:Bool(id:String)
End
