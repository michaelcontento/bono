import android.app.Activity;
import com.revmob.RevMob;
import com.revmob.RevMobTestingMode;
import com.revmob.ads.banner.RevMobBanner;
import android.widget.LinearLayout;

class RevmobBridge
{
    private static RevMob revmob;

    public static void StartSession(String id)
    {
        revmob = RevMob.start(MonkeyGame.activity, id);
    }

    public static void ShowFullscreen()
    {
        if (revmob == null) { return; }
        revmob.showFullscreen(MonkeyGame.activity);
    }

    public static void ShowBanner()
    {
        if (revmob == null) { return; }
        RevMobBanner banner = revmob.createBanner(MonkeyGame.activity);
        LinearLayout layout = (LinearLayout) MonkeyGame.activity.findViewById(R.id.banner);
        layout.removeAllViews();
        layout.addView(banner);
    }

    public static void HideBanner()
    {
        LinearLayout layout = (LinearLayout) MonkeyGame.activity.findViewById(R.id.banner);
        layout.removeAllViews();
    }

    public static void OpenAdLink()
    {
        if (revmob == null) { return; }
        revmob.openAdLink(MonkeyGame.activity, null);
    }

    public static void ShowPopup()
    {
        if (revmob == null) { return; }
        revmob.showPopup(MonkeyGame.activity);
    }

    public static void EnableTestingWithAds()
    {
        if (revmob == null) { return; }
        revmob.setTestingMode(RevMobTestingMode.WITH_ADS);
    }

    public static void EnableTestingWithoutAds()
    {
        if (revmob == null) { return; }
        revmob.setTestingMode(RevMobTestingMode.WITHOUT_ADS);
    }

    public static void DisableTesting()
    {
        if (revmob == null) { return; }
        revmob.setTestingMode(RevMobTestingMode.DISABLED);
    }
}
