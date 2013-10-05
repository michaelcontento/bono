#import <Chartboost/Chartboost.h>

//delegate glue
@interface ChartboostDelegateGlue : NSObject <ChartboostDelegate> {
}

-(BOOL) shouldRequestInterstitial:(NSString *)location;
-(BOOL) shouldDisplayInterstitial:(NSString *)location;
-(void) didCacheInterstitial:(NSString *)location;
-(void) didFailToLoadInterstitial:(NSString *)location;
-(void) didDismissInterstitial:(NSString *)location;
-(void) didCloseInterstitial:(NSString *)location;
-(void) didClickInterstitial:(NSString *)location;
-(void) didShowInterstitial:(NSString *)location;
-(BOOL) shouldDisplayLoadingViewForMoreApps;
-(BOOL) shouldRequestMoreApps;
-(BOOL) shouldDisplayMoreApps;
-(void) didCacheMoreApps;
-(void) didFailToLoadMoreApps;
-(void) didDismissMoreApps;
-(void) didCloseMoreApps;
-(void) didClickMoreApps;
-(void) didShowMoreApps;
-(BOOL) shouldRequestInterstitialsInFirstSession;
@end

//glue
class ChartboostGlue : public Object {
public:
	static ChartboostGlue *instance;
	
	//monkey work arounds
	bool _hasCachedMoreApps;
	
	//monkey callbacks
	virtual bool shouldRequestInterstitial(String location);
	virtual bool shouldDisplayInterstitial(String location);
	virtual void didCacheInterstitial(String location);
	virtual void didFailToLoadInterstitial(String location);
	virtual void didDismissInterstitial(String location);
	virtual void didCloseInterstitial(String location);
	virtual void didClickInterstitial(String location);
	virtual void didShowInterstitial(String location);
	virtual bool shouldDisplayLoadingViewForMoreApps();
	virtual bool shouldRequestMoreApps();
	virtual bool shouldDisplayMoreApps();
	virtual void didCacheMoreApps();
	virtual void didFailToLoadMoreApps();
	virtual void didDismissMoreApps();
	virtual void didCloseMoreApps();
	virtual void didClickMoreApps();
	virtual void didShowMoreApps();
	virtual bool shouldRequestInterstitialsInFirstSession();

	//api
	void StartSession(String appId,String appSignature);
	void CacheInterstitial();
	void CacheInterstitial(String location);
	void ShowInterstitial();
	void ShowInterstitial(String location);
	bool HasCachedInterstitial();
	bool HasCachedInterstitial(String location);
	void CacheMoreApps();
	bool HasCachedMoreApps();
	void ShowMoreApps();
};

//delegate glue
@implementation ChartboostDelegateGlue
-(BOOL) shouldRequestInterstitial:(NSString *)location { return ChartboostGlue::instance->shouldRequestInterstitial(String([location UTF8String],[location length])); }
-(BOOL) shouldDisplayInterstitial:(NSString *)location { return ChartboostGlue::instance->shouldDisplayInterstitial(String([location UTF8String],[location length])); }
-(void) didCacheInterstitial:(NSString *)location { ChartboostGlue::instance->didCacheInterstitial(String([location UTF8String],[location length])); }
-(void) didFailToLoadInterstitial:(NSString *)location { ChartboostGlue::instance->didFailToLoadInterstitial(String([location UTF8String],[location length])); }
-(void) didDismissInterstitial:(NSString *)location { ChartboostGlue::instance->didDismissInterstitial(String([location UTF8String],[location length])); }
-(void) didCloseInterstitial:(NSString *)location { ChartboostGlue::instance->didCloseInterstitial(String([location UTF8String],[location length])); }
-(void) didClickInterstitial:(NSString *)location { ChartboostGlue::instance->didClickInterstitial(String([location UTF8String],[location length])); }
-(void) didShowInterstitial:(NSString *)location { ChartboostGlue::instance->didShowInterstitial(String([location UTF8String],[location length])); }
-(BOOL) shouldDisplayLoadingViewForMoreApps { return ChartboostGlue::instance->shouldDisplayLoadingViewForMoreApps(); }
-(BOOL) shouldRequestMoreApps { return ChartboostGlue::instance->shouldRequestMoreApps(); }
-(BOOL) shouldDisplayMoreApps { return ChartboostGlue::instance->shouldDisplayMoreApps(); }
-(void) didCacheMoreApps {
	//fix here to manually store apps cache flag (ios SDK doesnt have built in method to check hasCachedMoreApps)
	ChartboostGlue::instance->_hasCachedMoreApps = true;
	
	//send to monkey as normal
	ChartboostGlue::instance->didCacheMoreApps();
}
-(void) didFailToLoadMoreApps { ChartboostGlue::instance->didFailToLoadMoreApps(); }
-(void) didDismissMoreApps { ChartboostGlue::instance->didDismissMoreApps(); }
-(void) didCloseMoreApps { ChartboostGlue::instance->didCloseMoreApps(); }
-(void) didClickMoreApps { ChartboostGlue::instance->didClickMoreApps(); }
-(void) didShowMoreApps {
	//fix here to manually store apps cache flag (ios SDK doesnt have built in method to check hasCachedMoreApps)
	ChartboostGlue::instance->_hasCachedMoreApps = false;
	
	//send to monkey as normal
	ChartboostGlue::instance->didShowMoreApps();
}
-(BOOL) shouldRequestInterstitialsInFirstSession { return ChartboostGlue::instance->shouldRequestInterstitialsInFirstSession(); }
@end

//glue
//class ChartboostGlue
ChartboostGlue *ChartboostGlue::instance;

//monkey callbacks
bool ChartboostGlue::shouldRequestInterstitial(String location) { return true; }
bool ChartboostGlue::shouldDisplayInterstitial(String location) { return true; }
void ChartboostGlue::didCacheInterstitial(String location) {}
void ChartboostGlue::didFailToLoadInterstitial(String location) {}
void ChartboostGlue::didDismissInterstitial(String location) {}
void ChartboostGlue::didCloseInterstitial(String location) {}
void ChartboostGlue::didClickInterstitial(String location) {}
void ChartboostGlue::didShowInterstitial(String location) {}
bool ChartboostGlue::shouldDisplayLoadingViewForMoreApps() { return true; }
bool ChartboostGlue::shouldRequestMoreApps() { return true; }
bool ChartboostGlue::shouldDisplayMoreApps() { return true; }
void ChartboostGlue::didCacheMoreApps() {}
void ChartboostGlue::didFailToLoadMoreApps() {}
void ChartboostGlue::didDismissMoreApps() {}
void ChartboostGlue::didCloseMoreApps() {}
void ChartboostGlue::didClickMoreApps() {}
void ChartboostGlue::didShowMoreApps() {}
bool ChartboostGlue::shouldRequestInterstitialsInFirstSession() { return true; }

//api
void ChartboostGlue::StartSession(String appId,String appSignature) {
	// --- start a session with chartboost ---
	//store global pointer to glue instance
	ChartboostGlue::instance = this;
	
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//setup chartboost
	cb.appId = appId.ToNSString();
	cb.appSignature = appSignature.ToNSString();
	cb.delegate = [[ChartboostDelegateGlue alloc] init];
	
	//start chartboost session
	[cb startSession];
}

void ChartboostGlue::CacheInterstitial() {
	// --- cache interstitial at defaul location ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//cache it
	[cb cacheInterstitial];
}

void ChartboostGlue::CacheInterstitial(String location) {
	// --- cache interstitial at locationd location ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//cache it
	[cb cacheInterstitial:location.ToNSString()];
}

void ChartboostGlue::ShowInterstitial() {
	// --- show a interstitial ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//show it!
	[cb showInterstitial];
}

void ChartboostGlue::ShowInterstitial(String location) {
	// --- show a locationd interstitial ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//show it!
	[cb showInterstitial:location.ToNSString()];
}

bool ChartboostGlue::HasCachedInterstitial() {
	// --- check if has default cache ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//return it!
	return [cb hasCachedInterstitial];
}

bool ChartboostGlue::HasCachedInterstitial(String location) {
	// --- check if has locationd cache ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//return it!
	return [cb hasCachedInterstitial:location.ToNSString()];
}

void ChartboostGlue::CacheMoreApps() {
	// --- cache more apps page ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//cache it
	[cb cacheMoreApps];
}

bool ChartboostGlue::HasCachedMoreApps() {
	// --- check if has apps cache ---
	//this is currently missing on the ios SDK so we have emulated it
	//get shared chartboost object
	//Chartboost *cb = [Chartboost sharedChartboost];
	
	//return it!
	//return [cb hasCachedMoreApps];
	return _hasCachedMoreApps;
}

void ChartboostGlue::ShowMoreApps() {
	// --- show more apps page ---
	//get shared chartboost object
	Chartboost *cb = [Chartboost sharedChartboost];
	
	//cache it
	[cb showMoreApps];
}
