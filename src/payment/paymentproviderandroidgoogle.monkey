Strict

Private

' ============================
' == COMMERCIAL BREAK START ==
' ============================
'
' Tired of setting things up? Monkey-Wizard to the rescue!
' --> https://github.com/michaelcontento/monkey-wizard
'
' And the whole thing should be easy as:
' --> wizard GooglePayment ../myproject/myproject.build/android
'
' ============================
' ==  COMMERCIAL BREAK END  ==
' ============================
'
'
' 1) Ensure this two lines exists inside <manifest> of your AndroidManifest.xml
'
'     <uses-permission android:name="android.permission.INTERNET"></uses-permission>
'     <uses-permission android:name="com.android.vending.BILLING"></uses-permission>
'
' 2) Add this reciever inside <application> of your AndroidManifest.xml
'
'    <service android:name="net.robotmedia.billing.BillingService" />
'    <receiver android:name="net.robotmedia.billing.BillingReceiver">
'        <intent-filter>
'            <action android:name="com.android.vending.billing.IN_APP_NOTIFY" />
'            <action android:name="com.android.vending.billing.RESPONSE_CODE" />
'            <action android:name="com.android.vending.billing.PURCHASE_STATE_CHANGED" />
'        </intent-filter>
'    </receiver>
'
' 3) Copy the billing library from the following link into src/
'
'    https://github.com/robotmedia/AndroidBillingLibrary
'
' 4) Patch AndroidBillingLibrary/src/net/robotmedia/billing/BillingRequest.java 
'    around line 220 to look like:
'
'    ## BEFORE
'
'    @Override
'    public void onResponseCode(ResponseCode response) {
'        super.onResponseCode(response);
'        if (response == ResponseCode.RESULT_OK) {
'            BillingController.onTransactionsRestored();
'        }
'    }
'
'    ## AFTER
'
'    @Override
'    public void onResponseCode(ResponseCode response) {
'        super.onResponseCode(response);
'        BillingController.onTransactionsRestored();
'    }

Import bono
Import bono.src.payment
Import "native/paymentwrapper-google.android.java"

Private Extern

Class PaymentWrapper
    Method Init:Void(publicKey:String)
    Method Purchase:Void(productId:String)
    Method IsBought:Bool(id:String)
    Method IsPurchaseInProgress:Bool()
End

Public

Class PaymentProviderAndroidGoogle Implements PaymentProvider
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

        If Not publicKey
            Throw New RuntimeException("Please configure " +
                "PaymentProviderAndroidGoogle.publicKey with your " +
                "public key first.")
        End

        wrapper = New PaymentWrapper()
        wrapper.Init(publicKey)
    End
End
