class AlertDelegate : public Object
{
public:
    virtual void Call(int buttonIndex, String buttonTitle) = 0;

    void mark() { 
        Object::mark();
    };
};

@class AlertDelegateObjectiveC;
@interface AlertDelegateObjectiveC : NSObject<UIAlertViewDelegate>
{
    @public AlertDelegate* delegate;
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end
@implementation AlertDelegateObjectiveC
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    delegate->Call(buttonIndex, [alertView buttonTitleAtIndex:buttonIndex]);
}
@end

class DeviceNative
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

    void static ShowAlertNative(String title, String message, Array<String> buttons, AlertDelegate* delegate)
    {
        AlertDelegateObjectiveC* delegateObjc = [AlertDelegateObjectiveC alloc];
        delegateObjc->delegate = delegate;

        UIAlertView *alert = [[UIAlertView alloc]
            initWithTitle:title.ToNSString()
            message:message.ToNSString()
            delegate:delegateObjc
            cancelButtonTitle:buttons.At(0).ToNSString()
            otherButtonTitles:nil];

        for (int i = 1; i < buttons.Length(); i++) {
            [alert addButtonWithTitle:buttons.At(i).ToNSString()];
        }

        [alert show];
        [alert release];
    }

    bool static FileExistsNative(String path)
    {
        String realPath = String(BBIosGame::BBIosGame().PathToFilePath(path));
        typedef struct stat stat_t;
        stat_t st;
        if (stat(realPath.ToCString<char>(), &st)) return false;
        switch (st.st_mode & S_IFMT) {
            case S_IFREG: return true;
            case S_IFDIR: return false;
        }
        return false;
    }

    void static Close()
    {
    }
};
