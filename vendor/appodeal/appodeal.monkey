#If TARGET <> "android" And TARGET <> "ios"
    #Error "The Admob module is only available on the android and ios targets"
#End

#If TARGET="android"

Import "native/appodeal.android.java"

#LIBS+="${CD}/native/android/android-support-v4-23.1.2-trimmed.jar"
#LIBS+="${CD}/native/android/appodeal-1.14.14.jar"
#LIBS+="${CD}/native/android/google-play-services.jar"
#LIBS+="${CD}/native/android/flurry-analytics-6.2.0.jar"
#LIBS+="${CD}/native/android/inmobi-5.3.0.jar"
#LIBS+="${CD}/native/android/yandex-metrica-2.41.jar"
#LIBS+="${CD}/native/android/applovin-6.1.5.jar"
#LIBS+="${CD}/native/android/chartboost-6.4.1.jar"
#LIBS+="${CD}/native/android/my-target-4.3.10.jar"
#LIBS+="${CD}/native/android/unity-ads-1.4.7.jar"

#ANDROID_MANIFEST+="<uses-permission android:name=~qandroid.permission.ACCESS_NETWORK_STATE~q /><uses-permission android:name=~qandroid.permission.INTERNET~q /><uses-permission android:name=~qandroid.permission.ACCESS_COARSE_LOCATION~q /><uses-permission android:name=~qandroid.permission.WRITE_EXTERNAL_STORAGE~q />"
#ANDROID_MANIFEST_APPLICATION+="
    <meta-data android:name=~qcom.appodeal.framework~q android:value=~qmonkey~q />
    <receiver android:name=~qcom.appodeal.ads.AppodealPackageAddedReceiver~q android:enabled=~qtrue~q android:exported=~qtrue~q><intent-filter><action android:name=~qandroid.intent.action.PACKAGE_ADDED~q /></intent-filter></receiver>
    <activity android:name=~qcom.appodeal.ads.InterstitialActivity~q android:configChanges=~qorientation|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar~q />
    <activity android:name=~qcom.appodeal.ads.VideoActivity~q android:configChanges=~qorientation|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar~q />
    <activity android:name=~qcom.appodeal.ads.LoaderActivity~q android:configChanges=~qorientation|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar~q />
    <meta-data android:name=~qcom.google.android.gms.version~q android:value=~q@integer/google_play_services_version~q />
    <activity android:name=~qcom.google.android.gms.ads.AdActivity~q android:configChanges=~qkeyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize~q android:theme=~q@android:style/Theme.Translucent~q />
    <activity android:name=~qcom.chartboost.sdk.CBImpressionActivity~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar.Fullscreen~q android:hardwareAccelerated=~qtrue~q android:excludeFromRecents=~qtrue~q />
    <activity android:name=~qcom.applovin.adview.AppLovinInterstitialActivity~q android:theme=~q@android:style/Theme.Translucent~q />
    <activity android:name=~qcom.mopub.mobileads.MoPubActivity~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q android:theme=~q@android:style/Theme.Translucent~q />
    <activity android:name=~qcom.mopub.common.MoPubBrowser~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q />
    <activity android:name=~qcom.mopub.mobileads.MraidActivity~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q />
    <activity android:name=~qcom.mopub.mobileads.MraidVideoPlayerActivity~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q />
    <activity android:name=~qorg.nexage.sourcekit.mraid.MRAIDBrowser~q android:configChanges=~qorientation|keyboard|keyboardHidden|screenSize~q android:theme=~q@android:style/Theme.Translucent~q />
    <activity android:name=~qcom.amazon.device.ads.AdActivity~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q android:theme=~q@android:style/Theme.Translucent~q />
    <activity android:name=~qru.mail.android.mytarget.ads.MyTargetActivity~q android:configChanges=~qkeyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize~q />
    <activity android:name=~qorg.nexage.sourcekit.vast.activity.VPAIDActivity~q android:theme=~q@android:style/Theme.NoTitleBar.Fullscreen~q />
	<activity android:name=~qorg.nexage.sourcekit.vast.activity.VASTActivity~q android:theme=~q@android:style/Theme.NoTitleBar.Fullscreen~q />
    <activity android:name=~qcom.appodeal.ads.networks.SpotXActivity~q android:theme=~q@android:style/Theme.NoTitleBar.Fullscreen~q />
    <activity android:name=~qcom.facebook.ads.InterstitialAdActivity~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q />
    <activity android:name=~qcom.appodeal.ads.networks.vpaid.VPAIDActivity~q android:theme=~q@android:style/Theme.NoTitleBar.Fullscreen~q />
    <activity android:name=~qcom.unity3d.ads.android.view.UnityAdsFullscreenActivity~q android:configChanges=~qfontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen~q android:theme=~q@android:style/Theme.NoTitleBar.Fullscreen~q android:hardwareAccelerated=~qtrue~q />
    <activity android:name=~qcom.unity3d.ads.android2.view.UnityAdsFullscreenActivity~q android:configChanges=~qfontScale|keyboard|keyboardHidden|locale|mnc|mcc|navigation|orientation|screenLayout|screenSize|smallestScreenSize|uiMode|touchscreen~q android:theme=~q@android:style/Theme.NoTitleBar.Fullscreen~q android:hardwareAccelerated=~qtrue~q />
    <activity android:name=~qcom.jirbo.adcolony.AdColonyOverlay~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar.Fullscreen~q />
    <activity android:name=~qcom.jirbo.adcolony.AdColonyFullscreen~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar.Fullscreen~q />
    <activity android:name=~qcom.jirbo.adcolony.AdColonyBrowser~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar.Fullscreen~q />
    <activity android:name=~qcom.vungle.publisher.FullScreenAdActivity~q android:configChanges=~qkeyboardHidden|orientation|screenSize~q android:theme=~q@android:style/Theme.NoTitleBar.Fullscreen~q />
    <activity android:name=~qcom.startapp.android.publish.list3d.List3DActivity~q android:theme=~q@android:style/Theme~q />
    <activity android:name=~qcom.startapp.android.publish.OverlayActivity~q android:configChanges=~qorientation|keyboardHidden|screenSize~q android:theme=~q@android:style/Theme.Translucent~q />
    <activity android:name=~qcom.startapp.android.publish.FullScreenActivity~q android:configChanges=~qorientation|keyboardHidden|screenSize~q android:theme=~q@android:style/Theme~q />
    <service android:name=~qcom.yandex.metrica.MetricaService~q android:enabled=~qtrue~q android:exported=~qtrue~q android:process=~q:Metrica~q>
      <intent-filter>
        <action android:name=~qcom.yandex.metrica.IMetricaService~q />
        <category android:name=~qandroid.intent.category.DEFAULT~q />
      </intent-filter>
      <meta-data android:name=~qmetrica:api:level~q android:value=~q44~q />
    </service>
    <receiver android:name=~qcom.yandex.metrica.MetricaEventHandler~q android:enabled=~qtrue~q android:exported=~qtrue~q>
      <intent-filter>
        <action android:name=~qcom.android.vending.INSTALL_REFERRER~q />
      </intent-filter>
    </receiver>
    <activity android:name=~qcom.yandex.mobile.ads.AdActivity~q android:configChanges=~qkeyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize~q />
    <activity android:name=~qcom.inmobi.rendering.InMobiAdActivity~q android:configChanges=~qkeyboardHidden|orientation|keyboard|smallestScreenSize|screenSize~q android:theme=~q@android:style/Theme.Translucent.NoTitleBar~q android:hardwareAccelerated=~qtrue~q android:excludeFromRecents=~qtrue~q />
    <receiver android:name=~qcom.inmobi.commons.core.utilities.uid.ImIdShareBroadCastReceiver~q android:enabled=~qtrue~q android:exported=~qtrue~q>
      <intent-filter>
        <action android:name=~qcom.inmobi.share.id~q />
      </intent-filter>
    </receiver>
    <service android:enabled=~qtrue~q android:name=~qcom.inmobi.signals.activityrecognition.ActivityRecognitionManager~q />
    <activity android:name=~qcom.flurry.android.FlurryFullscreenTakeoverActivity~q android:configChanges=~qkeyboard|keyboardHidden|orientation|screenLayout|uiMode|screenSize|smallestScreenSize~q />"

#Elseif TARGET="ios"

Import "native/appodeal.ios.cpp"

#end

Extern

Class AdAppodeal Extends Null="BBAppodeal"

	Function GetAppodeal:AdAppodeal()

	Method initialize:Void(appKey:String,adType:Int)
	Method show:Bool(adType:Int)
	Method show:Bool(adType:Int, placement:String)
	Method cache:Void(adType:Int)
	Method hide:Void(adType:Int)
	Method confirm:Void(adType:Int)
	Method isLoaded:Bool(adType:Int)
	Method isPrecache:Bool(adType:Int)
	Method setAutoCache:Void(adType:Int,state:Bool)
	Method setOnLoadedTriggerBoth:Void(adType:Int,state:Bool)
	Method disableNetwork:Void(network:String)
	Method disableNetwork:Void(network:String,adType:Int)
	Method disableLocationPermissionCheck:Void()
	Method disableWriteExternalStoragePermissionCheck:Void()
	Method setTesting:Void(state:Bool)
	Method setLogging:Void(state:Bool)
	Method setCustomSegment:Void(name:String,value:Bool)
	Method setCustomSegment:Void(name:String,value:Int)
	Method setCustomSegment:Void(name:String,value:String)
	Method setCustomSegment:Void(name:String,value:Float)

End

Public
Class AdType
    Const NONE:=0
	Const INTERSTITIAL:=1
	Const SKIPPABLE_VIDEO:=2
	Const BANNER:=4
	Const BANNER_BOTTOM:=8
	Const BANNER_TOP:=16
	Const BANNER_CENTER:=32
	Const REWARDED_VIDEO:=128
	Const NON_SKIPPABLE_VIDEO:=128
End
