#import <vunglepub/vunglepub.h>

class VungleBridge
{
public:
    void static StartWithPubAppID(String id)
    {
        VGUserData*  data  = [VGUserData defaultUserData];
        NSString*    appID = id.ToNSString();

        [VGVunglePub allowAutoRotate:YES];
        [VGVunglePub startWithPubAppID:appID userData:data];
    }

    bool static AdIsAvailable()
    {
        return [VGVunglePub adIsAvailable];
    }

    void static PlayModalAd()
    {
        MonkeyAppDelegate* delegate = (MonkeyAppDelegate*) [[UIApplication sharedApplication] delegate];
        if (!delegate || !delegate.viewController) return;
        [VGVunglePub playModalAd:delegate.viewController animated:YES];
    }
};
