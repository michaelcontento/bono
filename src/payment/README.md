# Payment [![Flattr this git repo](http://api.flattr.com/button/flattr-badge-large.png)](https://flattr.com/submit/auto?user_id=kaffeefleck&url=https://github.com/michaelcontento/bono&title=Bono&language=en_GB&tags=github&category=software)

Handle in-app purchasing (IAP) in various markets with ease.

## Overview

![Class diagramm](http://yuml.me/77696e4e)

## Manager

This thing is just a helper to get a nice API, totally optional and can be
skipped (just talk directly to the desired payment provider). But with this
helper you get:

1. Singleton behaviour (`PaymentManager.GetInstance()`)
2. Logging to stdout if `Target.IS_DEBUG` is true
3. Clean API 
4. ID prefixing
5. ID aliasing

### Clean API?

Just a short example:

    ' -- NICE API
    PaymentManager.GetInstance().RestorePreviousPurchases()

    ' -- NOT SO NICE ...
    If Target.IS_IOS
        Local manager:PaymentManager = PaymentManager.GetInstance()
        Local provider:PaymentProvider = manager.GetProvider()
        PaymentProviderAppleIos(provider).RestorePreviousPurchases()
    End

### ID prefixing?

Your IAP IDs are prefix with your reversed domain name (e.g. `com.example.`)?
And you don't want to repeat this prefix all the time? Take this:

    PaymentManager.GetInstance().idPrefix = "com.example."
    If PaymentManager.GetInstance().IsPurchased("foo")
        Print "Yay! com.example.foo has been purchased!"
    End

### ID aliasing?

This goes into the same direction as the ID prefixing thing, but one step
further. Instead of a simple prefix we define "virtual names" that are used
when talking with the payment provider. With this we can handle different IAP
IDs on different targets without headache.

    ' -- ONE TIME SETUP
    Local manager:PaymentManager = PaymentManager.GetInstance()
    If Target.IS_IOS
        manager.idAlias.Set("foo", "com.example.ios.foo")
    ElseIf Target.IS_ANDROID
        manager.isAlias.Set("foo", "com.example.android.foo")
    End

    ' -- AND SOMEWHERE ELSE
    If manager.IsPurchased("foo") Then Print "Yay! Purchased!"

## Providers

Providers are the heart of this whole module and are responsible for the
communication between some native SDK and Monkey. And all this is done via a
thin interface (currently three methods) so it should be easy to add new stuff
in the future.

**Important:** Most providers require some configuration stuff and third-party
dependencies. Just take a look at the source of each provider to get a detailed
description what need to be done OR keep an eye on [this][1].

### AppleIos

Supports iOS > 3.0 and both iPhone and iPad. It's built based on the [iap][]
module for Monkey and [MKStorekit][].

### AndroidAmazon

Support for the android target and the Amazon App Store. Should run on Android
API > 13 and the whole setup is done in a few minutes. Just use the official
jar-file and stick to the docs regarding the `AndroidManifest.xml`.

**Important:** Read the docs at the top of `paymentproviderandroidamazon.monkey`!

**Important:** The current android market is selected based on
`#BONO_ANDROID_MARKET`!

### AndroidSamsung

Support for the android target and the Samsung App Store. Should run on Android
API > 13 and the whole setup is done in a few minutes. Just use the official
jar-file and stick to the docs regarding the `AndroidManifest.xml`.

**Important:** Read the docs at the top of `paymentproviderandroidsamsung.monkey`!

**Important:** The current android market is selected based on
`#BONO_ANDROID_MARKET`!

### AndroidGoogle

Support for the android target and the Google Play Store. Should run on Android
API > 13 and the whole thing is pretty complicated to setup, as you need a lot
of java code. Luckily the most stuff can be reused from the official IAP example
and a little bit of glue code out of [Horizon-for-Monkey][].

**Important:** Read the docs at the top of `paymentproviderandroidgoogle.monkey`!

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

## Links

* [Bono Tests](https://github.com/michaelcontento/bono/tree/master/tests/payment)
* [Apple IAP](http://goo.gl/j1Sbb)
* [Amazon IAP](https://developer.amazon.com/sdk/in-app-purchasing.html)
* [Google IAP](http://developer.android.com/google/play/billing/billing_overview.html)

  [iap]: http://www.monkeycoder.co.nz/Community/posts.php?topic=1219#29629
  [MKStorekit]: https://github.com/MugunthKumar/MKStoreKit
  [Horizon-for-Monkey]: https://github.com/JochenHeizmann/Horizon-for-Monkey
  [1]: https://github.com/michaelcontento/bono/issues/15
