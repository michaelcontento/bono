#import <vunglepub/vunglepub.h>

@class MyVungleDelegate;
@interface MyVungleDelegate : NSObject<VGVunglePubDelegate>
{
}
- (void)vungleMoviePlayed:(VGPlayData*)playData;
@end
@implementation MyVungleDelegate
- (void)vungleMoviePlayed:(VGPlayData*)playData
{
    if (app && app->audio) app->audio->ResumeMusic();
}
@end

class VungleBridge
{
public:
    void static StartWithPubAppID(String id)
    {
        VGUserData* data  = [VGUserData defaultUserData];
        NSString* appID = id.ToNSString();
        MyVungleDelegate* delegate = [MyVungleDelegate alloc];

        [VGVunglePub allowAutoRotate:YES];
        [VGVunglePub startWithPubAppID:appID userData:data];
        [VGVunglePub setDelegate:delegate];
    }

    bool static AdIsAvailable()
    {
        return [VGVunglePub adIsAvailable];
    }

    void static PlayModalAd()
    {
        MonkeyAppDelegate* delegate = (MonkeyAppDelegate*) [[UIApplication sharedApplication] delegate];
        if (!delegate || !delegate.viewController) return;

        if (app && app->audio) app->audio->PauseMusic();
        [VGVunglePub playModalAd:delegate.viewController animated:YES];
    }
};
