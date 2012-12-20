#import <Flurry/Flurry.h>

class FlurryBridge
{
public:
    void static uncaughtExceptionHandler(NSException *exception)
    {
        [Flurry logError:@"Uncaught Exception" message:@"Crash!" exception:exception];
    }

    void static StartSession(String id)
    {
        Print(String("[Flurry StartSession] id:") + id);
        NSSetUncaughtExceptionHandler(&FlurryBridge::uncaughtExceptionHandler);

        [Flurry startSession:id.ToNSString()];
        [Flurry setSessionReportsOnCloseEnabled:YES];
        [Flurry setSessionReportsOnPauseEnabled:YES];
    }

    void static LogEvent(String name)
    {
        Print(String("[Flurry LogEvent] name:") + name);
        [Flurry logEvent:name.ToNSString()];
    }

    void static LogEventTimed(String name)
    {
        Print(String("[Flurry LogEventTimed] name:") + name);
        [Flurry logEvent:name.ToNSString() timed:YES];
    }

    void static EndTimedEvent(String name)
    {
        Print(String("[Flurry EndTimedEvent] name:") + name);
        [Flurry endTimedEvent:name.ToNSString() withParameters:nil];
    }
};
