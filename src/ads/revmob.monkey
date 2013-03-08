Strict

' ============================
' == COMMERCIAL BREAK START ==
' ============================
'
' Tired of setting things up? Monkey-Wizard to the rescue!
' --> https://github.com/michaelcontento/monkey-wizard
'
' And the whole thing should be easy as:
' --> wizard IosRevmob ../myproject/myproject.build/ios
' --> wizard AndroidRevmob ../myproject/myproject.build/android
'
' ============================
' ==  COMMERCIAL BREAK END  ==
' ============================

#If TARGET="ios"

' You need to include the following frameworks to your project:
'   * RevMobAds.framework
'   * SystemConfiguration.framework
'   * StoreKit.framework
'   * AdSupport.framework
'
' Whereas the last three are standard apple frameworks and the first one can be
' found here: http://sdk.revmob.com/ios

Private

Import "native/revmobbridge.${TARGET}.${LANG}"

Extern

Class Revmob Abstract
    Function StartSession:Void(id:String)="RevmobBridge::StartSession"
    Function ShowFullscreen:Void()="RevmobBridge::ShowFullscreen"
    Function ShowBanner:Void()="RevmobBridge::ShowBanner"
    Function HideBanner:Void()="RevmobBridge::HideBanner"
    Function OpenAdLink:Void()="RevmobBridge::OpenAdLink"
    Function ShowPopup:Void()="RevmobBridge::ShowPopup"
    Function EnableTestingWithAds:Void()="RevmobBridge::EnableTestingWithAds"
    Function EnableTestingWithoutAds:Void()="RevmobBridge::EnableTestingWithoutAds"
    Function DisableTesting:Void()="RevmobBridge::DisableTesting"
End

#ElseIf TARGET="android"

' 1) Download the Revmob SDK from http://sdk.revmob.com/android
' 2) If there is no libs/ folder in the android build folder: create it now!
' 3) Copy the revmob-*.jar from the SDK into the libs/ folder
' 4) Change the content of "templates/res/layout/main.xml" in the android build
'    folder to look like this:
'
'     <?xml version="1.0" encoding="utf-8"?>
'     <FrameLayout
'         android:id="@+id/mainframe"
'         android:layout_width="fill_parent"
'         xmlns:android="http://schemas.android.com/apk/res/android"
'         android:layout_height="fill_parent" >
'         <LinearLayout
'             android:layout_width="fill_parent"
'             android:layout_height="fill_parent"
'             android:orientation="vertical" >
'             <view class="${ANDROID_APP_PACKAGE}.MonkeyGame$MonkeyView"
'                 android:id="@+id/monkeyview"
'                 android:keepScreenOn="true"
'                 android:layout_width="fill_parent"
'                 android:layout_height="fill_parent" />
'         </LinearLayout>
'         <RelativeLayout
'                 android:layout_width="fill_parent"
'                 android:layout_height="fill_parent" >
'             <LinearLayout
'                  android:id="@+id/banner"
'                  android:layout_width="wrap_content"
'                  android:layout_height="wrap_content"
'                  android:layout_alignParentBottom="true" >
'             </LinearLayout>
'         </RelativeLayout>
'     </FrameLayout>
'
' 5) Put the following code inside the <manifest> tag of the AndroidManifest.xml
'
'     <uses-permission android:name="android.permission.INTERNET"/>
'     <uses-permission android:name="android.permission.ACCESS_WIFI_STATE"/>
'     <uses-permission android:name="android.permission.ACCESS_NETWORK_STATE"/>
'     <uses-permission android:name="android.permission.READ_PHONE_STATE"/>
'
' 6) And put the following code inside the <application> tag of the AndroidManifest.xml
'
'    <activity
'        android:name="com.revmob.ads.fullscreen.FullscreenActivity"
'        android:configChanges="keyboardHidden|orientation" >
'    </activity>

Private

Import "native/revmobbridge.${TARGET}.${LANG}"

Extern

Class Revmob Abstract
    Function StartSession:Void(id:String)="RevmobBridge.StartSession"
    Function ShowFullscreen:Void()="RevmobBridge.ShowFullscreen"
    Function ShowBanner:Void()="RevmobBridge.ShowBanner"
    Function HideBanner:Void()="RevmobBridge.HideBanner"
    Function OpenAdLink:Void()="RevmobBridge.OpenAdLink"
    Function ShowPopup:Void()="RevmobBridge.ShowPopup"
    Function EnableTestingWithAds:Void()="RevmobBridge.EnableTestingWithAds"
    Function EnableTestingWithoutAds:Void()="RevmobBridge.EnableTestingWithoutAds"
    Function DisableTesting:Void()="RevmobBridge.DisableTesting"
End

#Else

Private

Import bono

Public

Class Revmob Abstract
    Function StartSession:Void(id:String)
        If Target.IS_DEBUG Then Print "[Revmob StartSession]"
    End

    Function ShowFullscreen:Void()
        If Target.IS_DEBUG Then Print "[Revmob ShowFullscreen]"
    End

    Function ShowBanner:Void()
        If Target.IS_DEBUG Then Print "[Revmob ShowBanner]"
    End

    Function HideBanner:Void()
        If Target.IS_DEBUG Then Print "[Revmob HideBanner]"
    End

    Function OpenAdLink:Void()
        If Target.IS_DEBUG Then Print "[Revmob OpenAdLink]"
    End

    Function ShowPopup:Void()
        If Target.IS_DEBUG Then Print "[Revmob ShowPopup]"
    End

    Function EnableTestingWithAds:Void()
        If Target.IS_DEBUG Then Print "[Revmob EnableTestingWithAds]"
    End

    Function EnableTestingWithoutAds:Void()
        If Target.IS_DEBUG Then Print "[Revmob EnableTestingWithoutAds]"
    End

    Function DisableTesting:Void()
        If Target.IS_DEBUG Then Print "[Revmob DisableTesting]"
    End
End

#End
