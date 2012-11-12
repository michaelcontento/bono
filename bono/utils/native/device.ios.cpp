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
};
