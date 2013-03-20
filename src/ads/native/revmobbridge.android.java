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
        revmob = RevMob.start(BBAndroidGame.AndroidGame().GetActivity(), id);
    }

    public static void ShowFullscreen()
    {
        if (revmob == null) { return; }
        revmob.showFullscreen(BBAndroidGame.AndroidGame().GetActivity());
    }

    public static void ShowBanner()
    {
        if (revmob == null) { return; }

        final RevMobBanner banner = revmob.createBanner(BBAndroidGame.AndroidGame().GetActivity());
        BBAndroidGame.AndroidGame().GetActivity().runOnUiThread(new Runnable() {
            public void run() {
                LinearLayout layout = (LinearLayout) BBAndroidGame.AndroidGame().GetActivity().findViewById(R.id.banner);
                layout.removeAllViews();
                layout.addView(banner);
            }
        });
    }

    public static void HideBanner()
    {
        BBAndroidGame.AndroidGame().GetActivity().runOnUiThread(new Runnable() {
            public void run() {
                LinearLayout layout = (LinearLayout) BBAndroidGame.AndroidGame().GetActivity().findViewById(R.id.banner);
                layout.removeAllViews();
            }
        });
    }

    public static void OpenAdLink()
    {
        if (revmob == null) { return; }
        revmob.openAdLink(BBAndroidGame.AndroidGame().GetActivity(), null);
    }

    public static void ShowPopup()
    {
        if (revmob == null) { return; }
        revmob.showPopup(BBAndroidGame.AndroidGame().GetActivity());
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
