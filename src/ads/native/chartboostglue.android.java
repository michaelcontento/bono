import com.chartboost.sdk.Chartboost;
import com.chartboost.sdk.ChartboostDelegate;
import com.chartboost.sdk.Analytics.CBAnalytics;

//glue
class ChartboostGlue {
	public static ChartboostGlue instance;
	public static Chartboost cb;

	//monkey callbacks
	public boolean shouldRequestInterstitial(String location) { return true; }
	public boolean shouldDisplayInterstitial(String location) { return true; }
	public void didCacheInterstitial(String location) {}
	public void didFailToLoadInterstitial(String location) {}
	public void didDismissInterstitial(String location) {}
	public void didCloseInterstitial(String location) {}
	public void didClickInterstitial(String location) {}
	public void didShowInterstitial(String location) {}
	public boolean shouldDisplayLoadingViewForMoreApps() { return true; }
	public boolean shouldRequestMoreApps() { return true; }
	public boolean shouldDisplayMoreApps() { return true; }
	public void didCacheMoreApps() {}
	public void didFailToLoadMoreApps() {}
	public void didDismissMoreApps() {}
	public void didCloseMoreApps() {}
	public void didClickMoreApps() {}
	public void didShowMoreApps() {}
	public boolean shouldRequestInterstitialsInFirstSession() { return true; }

	//delegate glue
	private static ChartboostDelegate chartboostDelegateGlue = new ChartboostDelegate() {
	    @Override
	    public void didFailToLoadUrl(String url) {}

		@Override
		public boolean shouldRequestInterstitial(String location) { return true; }

		@Override
		public boolean shouldDisplayInterstitial(String location) { return true; }

		@Override
		public void didCacheInterstitial(String location) { ChartboostGlue.instance.didCacheInterstitial(location); }

		@Override
		public void didFailToLoadInterstitial(String location) { ChartboostGlue.instance.didFailToLoadInterstitial(location); }

		@Override
		public void didDismissInterstitial(String location) { ChartboostGlue.instance.didDismissInterstitial(location); }

		@Override
		public void didCloseInterstitial(String location) { ChartboostGlue.instance.didCloseInterstitial(location); }

		@Override
		public void didClickInterstitial(String location) { ChartboostGlue.instance.didClickInterstitial(location); }

		@Override
		public void didShowInterstitial(String location) { ChartboostGlue.instance.didShowInterstitial(location); }

		@Override
		public boolean shouldDisplayLoadingViewForMoreApps() { return true; }

		@Override
		public boolean shouldRequestMoreApps() { return true; }

		@Override
		public boolean shouldDisplayMoreApps() { return true; }

		@Override
		public void didCacheMoreApps() { ChartboostGlue.instance.didCacheMoreApps(); }

		@Override
		public void didFailToLoadMoreApps() { ChartboostGlue.instance.didFailToLoadMoreApps(); }

		@Override
		public void didDismissMoreApps() { ChartboostGlue.instance.didDismissMoreApps(); }

		@Override
		public void didCloseMoreApps() { ChartboostGlue.instance.didCloseMoreApps(); }

		@Override
		public void didClickMoreApps() { ChartboostGlue.instance.didClickMoreApps(); }

		@Override
		public void didShowMoreApps() { ChartboostGlue.instance.didShowMoreApps(); }

		@Override
		public boolean shouldRequestInterstitialsInFirstSession() { return true; }
	};

	//api
	public void StartSession(final String appId, final String appSignature) {
		// --- start a session with chartboost ---
		//store global pointer to glue instance
		instance = this;

        MonkeyGame.activity.runOnUiThread(new Runnable() {
            public void run() {
                //get shared chartboost object
                cb = Chartboost.sharedChartboost();

                //finalise setup
                cb.onCreate(MonkeyGame.activity, appId, appSignature, chartboostDelegateGlue);
                cb.startSession();
                cb.onStart(MonkeyGame.activity);
                cb.cacheInterstitial();
            }
        });
	}

	public void CacheInterstitial() {
		// --- cache interstitial at defaul location ---
		//cache it
        MonkeyGame.activity.runOnUiThread(new Runnable() {
            public void run() {
                cb.cacheInterstitial();
            }
        });
	}

	public void CacheInterstitial(final String location) {
		// --- cache interstitial at locationd location ---
		//cache it
        MonkeyGame.activity.runOnUiThread(new Runnable() {
            public void run() {
                cb.cacheInterstitial(location);
            }
        });
	}

	public void ShowInterstitial() {
		// --- show a interstitial ---
		//show it!
        MonkeyGame.activity.runOnUiThread(new Runnable() {
            public void run() {
                cb.showInterstitial();
            }
        });
	}

	public void ShowInterstitial(final String location) {
		// --- show a locationd interstitial ---
		//show it!
        MonkeyGame.activity.runOnUiThread(new Runnable() {
            public void run() {
                cb.showInterstitial(location);
            }
        });
	}

	public boolean HasCachedInterstitial() {
		// --- check if has default cache ---
		//return it!
		return cb.hasCachedInterstitial();
	}

	public boolean HasCachedInterstitial(String location) {
		// --- check if has locationd cache ---
		//return it!
		return cb.hasCachedInterstitial(location);
	}

	public void CacheMoreApps() {
		// --- cache more apps page ---
		//cache it
		cb.cacheMoreApps();
	}

	public boolean HasCachedMoreApps() {
		// --- check if has apps cache ---
		//return it!
		return cb.hasCachedMoreApps();
	}

	public void ShowMoreApps() {
		// --- show more apps page ---
		//show it
		cb.showMoreApps();
	}
};
