Strict

Private

' 1) Download the official SDK: https://developer.amazon.com/sdk.html
' 2) If there is no libs/ folder in build/android: create it!
' 3) Copy the in-app-purchasing-*.jar from the SDK into the libs/ folder
' 4) Put the following code inside the <application> tag of the AndroidManifest.xml
'
'    <receiver android:name="com.amazon.inapp.purchasing.ResponseReceiver" >
'        <intent-filter>
'            <action android:name="com.amazon.inapp.purchasing.NOTIFY"
'                android:permission="com.amazon.inapp.purchasing.Permission.NOTIFY" />
'        </intent-filter>
'    </receiver>

Import paymentprovider
Import "native/paymentwrapper-amazon.android.java"

Private Extern

Class PaymentWrapper
    Method Init:Void()
    Method Purchase:Void(productId$)
    Method IsBought?(id$)
    Method IsPurchaseInProgress?()
End

Public

Class PaymentProviderAndroidAmazon Implements PaymentProvider
    Private

    Field wrapper:PaymentWrapper

    Public

    Field publicKey:String

    Method IsProcessing:Bool()
        Initialize()
        Return wrapper.IsPurchaseInProgress()
    End

    Method Purchase:Void(id:String)
        Initialize()
        wrapper.Purchase(id)
    End

    Method IsPurchased:Bool(id:String)
        Initialize()
        Return wrapper.IsBought(id)
    End

    Private

    Method Initialize:Void()
        If wrapper Then Return

        wrapper = New PaymentWrapper()
        wrapper.Init()
    End
End
