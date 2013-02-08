@class _DeviceUIAlertDelegate;

static _DeviceUIAlertDelegate* _deviceuialertdelegate;
static NSInteger _lastButtonIndex;
static NSString* _lastButtonTitle;
static int _alertId = 0;

@interface _DeviceUIAlertDelegate : NSObject<UIAlertViewDelegate>
{}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@implementation _DeviceUIAlertDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    ++_alertId;
    _lastButtonIndex = buttonIndex;
    _lastButtonTitle = [alertView buttonTitleAtIndex:buttonIndex];
}
@end

class Device
{
public:
    int static GetTimestamp()
    {
        time_t unixTime = (time_t) [[NSDate date] timeIntervalSince1970];
        return static_cast<int>(unixTime);
    }

    void static OpenUrl(String url)
    {
        NSString *stringUrl = url.ToNSString();
        NSURL *nsUrl = [NSURL URLWithString:stringUrl];
        [[UIApplication sharedApplication] openURL:nsUrl];
    }

    String static GetLanguage()
    {
        NSString *language = [[NSLocale preferredLanguages] objectAtIndex:0];
        return String(language);
    }

    void static _ShowAlert(String title, String message, Array<String> buttons)
    {
        if (!_deviceuialertdelegate) {
            _deviceuialertdelegate = [_DeviceUIAlertDelegate alloc];
        }

        UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:title.ToNSString()
            message:message.ToNSString()
            delegate:_deviceuialertdelegate
            cancelButtonTitle:buttons.At(0).ToNSString()
            otherButtonTitles:nil];

        for (int i = 1; i < buttons.Length(); i++) {
            [alert addButtonWithTitle:buttons.At(i).ToNSString()];
        }

        [alert show];
        [alert release];
    }

    int static _GetAlertId()
    {
        return _alertId;
    }

    int static _GetAlertIndex()
    {
        return _lastButtonIndex;
    }

    String static _GetAlertTitle()
    {
        return _lastButtonTitle;
    }
};
