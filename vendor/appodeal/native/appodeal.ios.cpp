#import "Appodeal/Appodeal.h"

const int INTERSTITIAL  = 1;
const int VIDEO         = 2;
const int BANNER        = 4;
const int BANNER_BOTTOM = 8;
const int BANNER_TOP    = 16;
const int BANNER_CENTER = 32;
const int BANNER_CENTER = 32;
const int REWARDED_VIDEO = 128;
const int NON_SKIPPABLE_VIDEO = 128;

void showAlert(NSString* message)
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Testing alert"
                                                    message:message
                                                   delegate:nil
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
    [alert show];
}

int nativeAdTypesForType(int adTypes) {
    int nativeAdTypes = 0;

    if ((adTypes & INTERSTITIAL) > 0) {
        nativeAdTypes |= AppodealAdTypeInterstitial;
    }

    if ((adTypes & VIDEO) > 0) {
        nativeAdTypes |= AppodealAdTypeVideo;
    }

    if ((adTypes & BANNER) > 0 ||
        (adTypes & BANNER_TOP) > 0 ||
        (adTypes & BANNER_CENTER) > 0 ||
        (adTypes & BANNER_BOTTOM) > 0) {

        nativeAdTypes |= AppodealAdTypeBanner;
    }

    return nativeAdTypes;
}

int nativeShowStyleForType(int adTypes) {
    bool isInterstitial = (adTypes & INTERSTITIAL) > 0;
    bool isVideo = (adTypes & VIDEO) > 0;

    if (isInterstitial && isVideo) {
        return AppodealShowStyleVideoOrInterstitial;
    } else if (isVideo) {
        return AppodealShowStyleVideo;
    } else if (isInterstitial) {
        return AppodealShowStyleInterstitial;
    }

    if ((adTypes & BANNER_TOP) > 0) {
        return AppodealShowStyleBannerTop;
    }

    if ((adTypes & BANNER_CENTER) > 0) {
        return AppodealShowStyleBannerCenter;
    }

    if ((adTypes & BANNER_BOTTOM) > 0) {
        return AppodealShowStyleBannerBottom;
    }

    return 0;
}

class BBAppodeal{

    static BBAppodeal *_appodeal;

public:

    BBAppodeal();

    static BBAppodeal *GetAppodeal();

    void initialize(String _id, int adType);
    bool show(int adType);
    void hide(int adType);
    void setAutoCache(int adType, bool state);
    void disableNetwork(String network);
    void disableLocationPermissionCheck();

};

BBAppodeal *BBAppodeal::_appodeal;

BBAppodeal::BBAppodeal() {
}

BBAppodeal *BBAppodeal::GetAppodeal() {
    if( !_appodeal ) _appodeal=new BBAppodeal();
    return _appodeal;
}

void BBAppodeal::initialize(String _id, int adType) {
    NSString* appID = _id.ToNSString();
    [Appodeal disableNetworkForAdType:AppodealAdTypeInterstitial name:kAppodealYandexNetworkName];
    [Appodeal initializeWithApiKey:appID types:nativeAdTypesForType(adType)];
}

bool BBAppodeal::show(int adType) {
    return [Appodeal showAd:nativeShowStyleForType(adType) rootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

void BBAppodeal::hide(int adType) {
    [Appodeal hideBanner];
}

void BBAppodeal::setAutoCache(int adType, bool state) {
    [Appodeal setAutocache:state types:nativeAdTypesForType(adType)];
}

void BBAppodeal::disableNetwork(String network) {
    [Appodeal disableNetworkForAdType:AppodealAdTypeAll name:network.ToNSString()];
}

void BBAppodeal::disableLocationPermissionCheck() {
    [Appodeal disableLocationPermissionCheck];
}
