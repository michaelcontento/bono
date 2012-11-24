#import <RevMobAds/RevMobAds.h>

class RevmobBridge
{
public:
    void static StartSession(String id)
    {
        NSString *nsId = id.ToNSString();
        [RevMobAds startSessionWithAppID:nsId];
    }

    void static ShowFullscreen()
    {
        [[RevMobAds session] showFullscreen];
    }

    void static ShowBanner()
    {
        [[RevMobAds session] showBanner];
    }

    void static HideBanner()
    {
        [[RevMobAds session] hideBanner];
    }

    void static OpenAdLink()
    {
        [[RevMobAds session] openAdLinkWithDelegate:nil];
    }

    void static ShowPopup()
    {
        [[RevMobAds session] showPopup];
    }

    void static EnableTestingWithAds()
    {
        [RevMobAds session].testingMode = RevMobAdsTestingModeWithAds;
    }

    void static EnableTestingWithoutAds()
    {
        [RevMobAds session].testingMode = RevMobAdsTestingModeWithoutAds;
    }

    void static DisableTesting()
    {
        [RevMobAds session].testingMode = RevMobAdsTestingModeOff;
    }
};
