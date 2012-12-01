import android.app.Activity;
import com.revmob.RevMob;
import com.revmob.ads.EnvironmentConfig;
import com.revmob.ads.banner.Banner;
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
        revmob.showFullscreenAd(MonkeyGame.activity);
    }

    public static void ShowBanner()
    {
        if (revmob == null) { return; }
        Banner banner = revmob.createBanner(MonkeyGame.activity);
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
        /* TODO !!
        String url = "https://play.google.com/store/apps/developer?id=Jochen+Heizmann";
        Intent i = new Intent(Intent.ACTION_VIEW);
        i.setData(Uri.parse(url));
        MonkeyGame.activity.startActivity(i);
        if (revmob == null) { return; }
        revmob.openAdLink(MonkeyGame.activity);
        */
    }

    public static void ShowPopup()
    {
        if (revmob == null) { return; }
        revmob.showPopup(MonkeyGame.activity);
    }

    public static void EnableTestingWithAds()
    {
        EnvironmentConfig.setTestingMode(true);
    }

    public static void EnableTestingWithoutAds()
    {
        EnvironmentConfig.setTestingWithoutAds(true);
    }

    public static void DisableTesting()
    {
        EnvironmentConfig.setTestingMode(false);
    }
}
