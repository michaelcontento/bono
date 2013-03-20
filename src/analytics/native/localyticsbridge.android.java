import com.localytics.android.*;
import android.util.Log;

class LocalyticsBridge
{
    private static final String TAG = "Bono.Localytics";
    private static LocalyticsSession localyticsSession;

    public static void StartSession(String id)
    {
        localyticsSession = new LocalyticsSession(
            BBAndroidGame.AndroidGame().GetActivity().getApplicationContext(),
            id
        );
        Resume();
    }

    public static void Suspend()
    {
        if (localyticsSession != null) {
            Log.v(TAG, "Suspend");
            localyticsSession.close();
            localyticsSession.upload();
        }
    }

    public static void Resume()
    {
        if (localyticsSession != null) {
            Log.v(TAG, "Resume");
            localyticsSession.close();
            localyticsSession.upload();
        }
    }

    public static void TagEvent(String name)
    {
        if (localyticsSession != null) {
            Log.v(TAG, "TagEvent name: " + name);
            localyticsSession.tagEvent(name);
        }
    }
}
