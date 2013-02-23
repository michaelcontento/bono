#include <ctime>

class AlertDelegate : public Object
{
public:
    virtual void Call(int buttonIndex, String buttonTitle) = 0;
};

#if __APPLE__
#include <CoreFoundation/CoreFoundation.h>
#endif

class Device
{
public:
    int static GetTimestamp()
    {
        return std::time(0);
    }

    void static OpenUrl(const String url)
    {
        String cmd("open ");
        cmd += url;
        system(cmd.ToCString<char>());
    }

    String static GetLanguage()
    {
        return "en";
    }

#if __APPLE__
    void static ShowAlertNative(String title, String message, Array<String> buttons, AlertDelegate* delegate)
    {
        CFOptionFlags cfRes;
        CFUserNotificationDisplayAlert(0, kCFUserNotificationNoteAlertLevel,
               NULL, NULL, NULL,
               CFStringCreateWithCString(NULL, title.ToCString<char>(), kCFStringEncodingASCII),
               CFStringCreateWithCString(NULL, message.ToCString<char>(), kCFStringEncodingASCII),
               CFStringCreateWithCString(NULL, buttons.At(0).ToCString<char>(), kCFStringEncodingASCII),
               CFStringCreateWithCString(NULL, buttons.At(1).ToCString<char>(), kCFStringEncodingASCII),
               CFStringCreateWithCString(NULL, buttons.At(2).ToCString<char>(), kCFStringEncodingASCII),
               &cfRes);

        switch (cfRes)
        {
            case kCFUserNotificationDefaultResponse:
                delegate->Call(0, buttons.At(0));
                break;
            case kCFUserNotificationAlternateResponse:
                delegate->Call(1, buttons.At(1));
                break;
            case kCFUserNotificationOtherResponse:
                delegate->Call(2, buttons.At(2));
                break;
            default:
                break;
        }
    }
#endif

};
