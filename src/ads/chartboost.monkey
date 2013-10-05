' This is a wrapper for the chartboost module written by Jonathan Pittock (skn3) under contract.
' The module is currently iOS and android only.
' This module is 100% FREE as long as you use it for good and not evil.
' Feel free to contribute, dream, share, create and call it your own if you want to! :)
' You are allowed to remove these comments.
' This module was part of a Crowdfunding initiative in the Monkey Community. Enjoy.

Strict

'version 4
' - updated to version 3.1.5 of chartboost lib for android
' - updated to version 3.2 for ios
' - fixed blank screen issues
'version 3
' - fixed implements non chartboost classes
'version 2
' - added license
'version 1
' - first release


Private
' --------------------------------- imports ---------------------------------
#If TARGET="ios"
'[ios imports]
'frameworks
#LIBS+="QuartzCore.framework"
#LIBS+="SystemConfiguration.framework"
#LIBS+="StoreKit.framework"
#LIBS+="AdSupport.framework" 'Must weak-link AdSupport.framework in your app For iOS 6 compatibility (Select "Optional")
'#LIBS+="CoreGraphics.framework" Already in project so dont need to add (according to brl.admob)
#LIBS+="GameKit.framework"

'libs
#LIBS+="${CD}/native/chartboost-3.2/ios/libChartboost.a"
#LIBS+="${CD}/native/chartboost-3.2/ios/Chartboost.h"

'glue
Import "native/chartboostglue.ios.cpp"

'[android imports]
#Elseif TARGET="android"
'libs
#LIBS+="${CD}/native/chartboost-3.1.5/android/chartboost.jar"

'glue
Import "native/chartboostglue.android.java"

#end

' --------------------------------- glue class ---------------------------------
'supported device
#If TARGET="ios" Or TARGET="android"
Extern
Class ChartboostGlue Abstract
	Method shouldRequestInterstitial:Bool(location:String)
	Method shouldDisplayInterstitial:Bool(location:String)
	Method didCacheInterstitial:Void(location:String)
	Method didFailToLoadInterstitial:Void(location:String)
	Method didDismissInterstitial:Void(location:String)
	Method didCloseInterstitial:Void(location:String)
	Method didClickInterstitial:Void(location:String)
	Method didShowInterstitial:Void(location:String)
	Method shouldDisplayLoadingViewForMoreApps:Bool()
	Method shouldRequestMoreApps:Bool()
	Method shouldDisplayMoreApps:Bool()
	Method didCacheMoreApps:Void()
	Method didFailToLoadMoreApps:Void()
	Method didDismissMoreApps:Void()
	Method didCloseMoreApps:Void()
	Method didClickMoreApps:Void()
	Method didShowMoreApps:Void()
	Method shouldRequestInterstitialsInFirstSession:Bool()
	
	Method StartSession:Bool(appId:String, appSignature:String)
	Method CacheInterstitial:Void()
	Method CacheInterstitial:Void(location:String)
	Method ShowInterstitial:Void()
	Method ShowInterstitial:Void(location:String)
	Method HasCachedInterstitial:Bool()
	Method HasCachedInterstitial:Bool(location:String)
	Method CacheMoreApps:Void()
	Method HasCachedMoreApps:Bool()
	Method ShowMoreApps:Void()
End

Public
Class Chartboost Extends ChartboostGlue Final
Public 	
	Field delegate:ChartboostDelegate
	Field interstitialOpen:bool
	Field appsOpen:Bool
	
	'chartboost events
	Method shouldRequestInterstitial:Bool(location:String)
		'pass this onto the user delegate
		If delegate Return delegate.shouldRequestInterstitial(location)
		
		'default action
		Return True
	End
	
	Method shouldDisplayInterstitial:Bool(location:String)
		'pass this onto the user delegate
		If delegate Return delegate.shouldDisplayInterstitial(location)
		
		'default action
		Return True
	End

	Method didCacheInterstitial:Void(location:String)
		'pass this onto the user delegate
		If delegate delegate.didCacheInterstitial(location)
	End
	
	Method didFailToLoadInterstitial:Void(location:String)
		'pass this onto the user delegate
		If delegate delegate.didFailToLoadInterstitial(location)
	End
	
	Method didDismissInterstitial:Void(location:String)
		'pass this onto the user delegate
		If delegate delegate.didDismissInterstitial(location)
	End
	
	Method didCloseInterstitial:Void(location:String)
		'pass this onto the user delegate
		interstitialOpen = False
		If delegate delegate.didCloseInterstitial(location)
	End
	
	Method didClickInterstitial:Void(location:String)
		'pass this onto the user delegate
		If delegate delegate.didClickInterstitial(location)
	End
	
	Method didShowInterstitial:Void(location:String)
		'pass this onto the user delegate
		interstitialOpen = True
		If delegate delegate.didShowInterstitial(location)
	End

	Method shouldDisplayLoadingViewForMoreApps:Bool()
		'pass this onto the user delegate
		If delegate Return delegate.shouldDisplayLoadingViewForMoreApps()
		
		'default action
		Return True
	End

	Method shouldRequestMoreApps:Bool()
		'pass this onto the user delegate
		If delegate Return delegate.shouldRequestMoreApps()
		
		'default action
		Return True
	End
		
	Method shouldDisplayMoreApps:Bool()
		'pass this onto the user delegate
		If delegate Return delegate.shouldDisplayMoreApps()
		
		'default action
		Return True
	End

	Method didCacheMoreApps:Void()
		'pass this onto the user delegate
		If delegate delegate.didCacheMoreApps()
	End
		
	Method didFailToLoadMoreApps:Void()
		'pass this onto the user delegate
		If delegate delegate.didFailToLoadMoreApps()
	End
			
	Method didDismissMoreApps:Void()
		'pass this onto the user delegate
		If delegate delegate.didDismissMoreApps()
	End
	
	Method didCloseMoreApps:Void()
		'pass this onto the user delegate
		appsOpen = False
		If delegate delegate.didCloseMoreApps()
	End
	
	Method didClickMoreApps:Void()
		'pass this onto the user delegate
		If delegate delegate.didClickMoreApps()
	End
	
	Method didShowMoreApps:Void()
		'pass this onto the user delegate
		appsOpen = True
		If delegate delegate.didShowMoreApps()
	End
		
	Method shouldRequestInterstitialsInFirstSession:Bool()
		'pass this onto the user delegate
		If delegate Return delegate.shouldRequestInterstitialsInFirstSession()
		
		'default action
		Return True
	End
	
	'monkey api
	Method SetDelegate:Void(delegate:ChartboostDelegate)
		'this is a monkey delegate and acts as a message router from chartboost to monkey
		'it doesn't have a inheritance with chartboosts own delegate
		Self.delegate = delegate
	End
End

#Else

'unsupported device
Public
Class Chartboost
	'chartboost api
	Method StartSession:Bool(appId:String, appSignature:String)
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
		Return False
	End
	Method CacheInterstitial:Void()
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	Method CacheInterstitial:Void(location:String)
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	Method ShowInterstitial:Void()
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	Method ShowInterstitial:Void(location:String)
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	Method HasCachedInterstitial:Bool()
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	Method HasCachedInterstitial:Bool(location:String)
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	Method HasCachedMoreApps:Bool()
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End		
	End
	Method CacheMoreApps:Void()
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	Method ShowMoreApps:Void()
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
	
	'monkey api
	Method SetDelegate:Void(delegate:ChartboostDelegate)
		#If CONFIG = "debug"
		Print "Chartboost not supported on this device"
		#End
	End
End
#End

' --------------------------------- runtime stuff ---------------------------------
Private
Global chartboost:Chartboost

' --------------------------------- user api ---------------------------------
Public

'interfaces
Interface ChartboostDelegate
	'this allows for advanced usage of the api and should be implemented by your app
	Method shouldRequestInterstitial:Bool(location:String)
	Method shouldDisplayInterstitial:Bool(location:String)
	Method didCacheInterstitial:Void(location:String)
	Method didFailToLoadInterstitial:Void(location:String)
	Method didDismissInterstitial:Void(location:String)
	Method didCloseInterstitial:Void(location:String)
	Method didClickInterstitial:Void(location:String)
	Method didShowInterstitial:Void(location:String)
	Method shouldDisplayLoadingViewForMoreApps:Bool()
	Method shouldRequestMoreApps:Bool()
	Method shouldDisplayMoreApps:Bool()
	Method didCacheMoreApps:Void()
	Method didFailToLoadMoreApps:Void()
	Method didDismissMoreApps:Void()
	Method didCloseMoreApps:Void()
	Method didClickMoreApps:Void()
	Method didShowMoreApps:Void()
	Method shouldRequestInterstitialsInFirstSession:Bool()
End

'stock delegates
Class ChartboostDebugDelegate Implements ChartboostDelegate
	Method shouldRequestInterstitial:Bool(location:String)
		Print "shouldRequestInterstitial:"+location
		Return true
	End
	
	Method shouldDisplayInterstitial:Bool(location:String)
		Print "shouldDisplayInterstitial:"+location
		Return true
	End
	
	Method didCacheInterstitial:Void(location:String)
		Print "didCacheInterstitial:" + location
	End
	
	Method didFailToLoadInterstitial:Void(location:String)
		Print "didFailToLoadInterstitial:"+location
	End
	
	Method didDismissInterstitial:Void(location:String)
		Print "didDismissInterstitial:"+location
	End
	
	Method didCloseInterstitial:Void(location:String)
		Print "didCloseInterstitial:"+location
	End
	
	Method didClickInterstitial:Void(location:String)
		Print "didClickInterstitial:"+location
	End
	
	Method didShowInterstitial:Void(location:String)
		Print "didShowInterstitial:"+location
	End

	Method shouldDisplayLoadingViewForMoreApps:Bool()
		Print "shouldDisplayLoadingViewForMoreApps"
		Return true
	End		

	Method shouldRequestMoreApps:Bool()
		Print "shouldRequestMoreApps"
		Return True
	End
		
	Method shouldDisplayMoreApps:Bool()
		Print "shouldDisplayMoreApps"
		Return True
	End
	
	Method didCacheMoreApps:Void()
		Print "didCacheMoreApps"
	End
		
	Method didFailToLoadMoreApps:Void()
		Print "didFailToLoadMoreApps"
	End
				
	Method didDismissMoreApps:Void()
		Print "didDismissMoreApps"
	End
	
	Method didCloseMoreApps:Void()
		Print "didCloseMoreApps"
	End
	
	Method didClickMoreApps:Void()
		Print "didClickMoreApps"
	End
	
	Method didShowMoreApps:Void()
		Print "didShowMoreApps"
	End
		
	Method shouldRequestInterstitialsInFirstSession:Bool()
		Print "shouldRequestInterstitialsInFirstSession"
		Return true
	End
End

'api
Function ChartboostSetDelegate:Void(delegate:ChartboostDelegate)
	' --- change the delegate (monkey object) ---
	If chartboost = Null chartboost = New Chartboost
	'create global chartboost object if it hasnt been
	
	'change delegate
	chartboost.SetDelegate(delegate)
End

Function ChartboostStartSession:Bool(appId:String,appSignature:String)
	' --- start chartboost ---
	'create global chartboost object if it hasnt been
	If chartboost = Null chartboost = New Chartboost
	
	'start the chartboost session
	chartboost.StartSession(appId,appSignature)
	
	'success
	Return True
End

Function ChartboostCacheInterstitial:Void(location:String="")
	' --- cache chartboost inerstitial ---
	'send command to chartboost
	If location.Length
		'with location
		chartboost.CacheInterstitial(location)
	Else
		'without location
		chartboost.CacheInterstitial()
	Endif
End

Function ChartboostShowInterstitial:Void(location:String="")
	' --- show an interstitial ---
	'send command to chartboost
	If location.Length
		chartboost.ShowInterstitial(location)
	Else
		chartboost.ShowInterstitial()
	Endif
	ChartboostCacheInterstitial(location)
End

Function ChartboostHasCachedInterstitial:Bool(location:String="")
	' --- check for cache ---
	'send command to chartboost
	If location.Length
		Return chartboost.HasCachedInterstitial(location)
	Else
		Return chartboost.HasCachedInterstitial()
	Endif
End

Function ChartboostCacheMoreApps:Void()
	' --- cache more apps ---
	'send command to chartboost
	chartboost.CacheMoreApps()
End

Function ChartboostHasCachedMoreApps:Bool()
	' --- cache more apps ---
	'send command to chartboost
	Return chartboost.HasCachedMoreApps()
End

Function ChartboostShowMoreApps:Void()
	' --- cache more apps ---
	'send command to chartboost
	chartboost.ShowMoreApps()
End
