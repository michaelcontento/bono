#import "appirater/Appirater.h"

class AppiraterBridge
{
public:
    static void Launched(bool canPrompt)
    {
        [Appirater appLaunched:canPrompt];
    }

    static void EnteredForeground(bool canPrompt)
    {
        [Appirater appEnteredForeground:canPrompt];
    }

    static void UserDidSignificantEvent(bool canPrompt)
    {
        [Appirater userDidSignificantEvent:canPrompt];
    }

    static void SetAppId(String id)
    {
        [Appirater setAppId:id.ToNSString()];
    }

    static void SetDaysUntilPrompt(int days)
    {
        [Appirater setDaysUntilPrompt:days];
    }

    static void SetUsesUntilPrompt(int days)
    {
        [Appirater setUsesUntilPrompt:days];
    }

    static void SetSignificantEventsUntilPrompt(int uses)
    {
        [Appirater setSignificantEventsUntilPrompt:uses];
    }

    static void SetTimeBeforeReminding(int time)
    {
        [Appirater setTimeBeforeReminding:time];
    }

    static void SetDebug(bool flag)
    {
        [Appirater setDebug:flag];
    }
};
