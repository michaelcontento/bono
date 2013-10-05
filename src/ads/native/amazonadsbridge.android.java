import android.app.Activity;
import android.widget.LinearLayout;

import com.amazon.device.ads.AdRegistration;
import com.amazon.device.ads.AdTargetingOptions;
import com.amazon.device.ads.AdLayout;

class AmazonAdsBridge
{
    private static AdLayout adView;

    public static void StartSession(String id)
    {
        AdRegistration.setAppKey(id);
    }

    public static void Show()
    {
        if (adView == null) {
            adView = new AdLayout(MonkeyGame.activity);

            MonkeyGame.activity.runOnUiThread(new Runnable() {
                public void run() {
                    LinearLayout layout = (LinearLayout) MonkeyGame.activity.findViewById(R.id.amazonAdsView);
                    LinearLayout.LayoutParams lp = new LinearLayout.LayoutParams(
                            LinearLayout.LayoutParams.MATCH_PARENT,
                            LinearLayout.LayoutParams.WRAP_CONTENT);
                    layout.addView(adView, lp);
                }
            });
        }

        if (!adView.isAdLoading()) {
            MonkeyGame.activity.runOnUiThread(new Runnable() {
                public void run() {
                    adView.loadAd(new AdTargetingOptions());
                }
            });
        }
    }

    public static void Hide()
    {
        if (adView == null) {
            return;
        }

        MonkeyGame.activity.runOnUiThread(new Runnable() {
            public void run() {
                LinearLayout layout = (LinearLayout) MonkeyGame.activity.findViewById(R.id.amazonAdsView);
                layout.removeView(adView);
                adView.destroy();
                adView = null;
            }
        });
    }

    public static void EnableTesting()
    {
        AdRegistration.enableLogging(true);
        AdRegistration.enableTesting(true);
    }

    public static void DisableTesting()
    {
        AdRegistration.enableTesting(false);
        AdRegistration.enableLogging(false);
    }
}
