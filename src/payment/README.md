# Payment

Handle in-app purchasing (IAP) in various markets with ease.

## Overview

![Class diagramm](http://yuml.me/c91e5a6b)

## Manager

**TODO**

## Providers

Most providers require some configuration stuff and third-party dependencies.
Just take a look at the source of each provider to get a detailed description
what need to be done OR keep an eye on [this][1].

### AppleIos

Supports iOS > 3.0 and both iPhone and iPad. It's built based on the [iap][]
module for Monkey and [MKStorekit][].

### AndroidAmazon

Support for the android target and the Amazon App Store. Should run on Android
API > 13 and the whole setup is done in a few minutes. Just use the official
jar-file and stick to the docs regarding the `AndroidManifest.xml`.

**Important:** The current android market is selected based on
`#BONO_ANDROID_MARKET`!

### AndroidGoogle

Support for the android target and the Google Play Store. Should run on Android
API > 13 and the whole thing is pretty complicated to setup, as you need a lot
of java code. Luckily the most stuff can be reused from the official IAP example
and a little bit of glue code out of [Horizon-for-Monkey][].

**Important:** The current android market is selected based on
`#BONO_ANDROID_MARKET`!

### AutoUnlock

Pretty simple behaviour: `IsPurchased()` returns `False` until
`Purchase()` is called with the same id. Default provider if there is no
alternative.

### Alias

This is not a real payment provider and just an alias that points, with a little
Monkey preprocessor magic, to the right provider for the current target.

## Example

```
Strict

' -- CHANGE ANDROID MARKET
#BONO_ANDROID_MARKET="amazon"

Import bono
Import bono.src.payment

Function Main:Int()
    ' --- SETUP
	Local payment:PaymentManager = PaymentManager().GetInstance()
	payment.idAlias.Set("fullversion", "com.example.app.fullversion")

	' --- PURCHASE
	payment.Purchase("fullversion")
	While payment.IsProcessing()
	  Print "processing ..."
	End

	' --- HANDLE STATE
	If payment.IsPurchased("fullversion")
	  Print "... purchased :)"
	Else
	  Print "... not purchased :("
	End

	Return 0
End
```

## Links

* [Bono Tests](https://github.com/michaelcontento/bono/tree/master/tests/payment)
* [Apple IAP](http://goo.gl/j1Sbb)
* [Amazon IAP](https://developer.amazon.com/sdk/in-app-purchasing.html)
* [Google IAP](http://developer.android.com/google/play/billing/billing_overview.html)

  [iap]: http://www.monkeycoder.co.nz/Community/posts.php?topic=1219#29629
  [MKStorekit]: https://github.com/MugunthKumar/MKStoreKit
  [Horizon-for-Monkey]: https://github.com/JochenHeizmann/Horizon-for-Monkey
  [1]: https://github.com/michaelcontento/bono/issues/15
