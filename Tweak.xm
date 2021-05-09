#import <CoreGraphics/CoreGraphics.h>
#import <Foundation/Foundation.h>

static BOOL UnlimitedSwipe;
static BOOL NoDie;

static BOOL FixedScore;
static int FixedScoreValue;
static BOOL MultipleScore;
static int m; // Multiplier for scores

static BOOL Icy;

static BOOL PhoenixTimeFreeze;
static BOOL StaticBird;
static BOOL ShowFPS;
static BOOL AlwaysWin;
static BOOL HideMT2;
static BOOL NoPopUp;

static BOOL NoJB;

%group bird

%hook Ruckus_BlueBird

- (BOOL)outOfSwipes {
    return UnlimitedSwipe ? NO : %orig;
}

- (void)animDie {
    if (NoDie) return;
    %orig;
}

- (void)animBigImpact {
    if (NoDie) return;
    %orig;
}

%end

%hook Ruckus_Phoenix

- (BOOL)outOfSwipes {
    return UnlimitedSwipe ? NO : %orig;
}

- (BOOL)canDieFromThornsAndLightning {
    return NoDie ? NO : %orig;
}

- (void)animDie {
    if (NoDie) return;
    %orig;
}

- (void)animBigImpact {
    if (NoDie) return;
    %orig;
}

- (void)checkStuck {
    if (NoDie) return;
    %orig;
}

%end

%hook Ruckus_Character

- (int)usedSwipes {
    return UnlimitedSwipe ? 0 : %orig;
}

- (BOOL)alive {
    return NoDie ? YES : %orig;
}

- (BOOL)outOfSwipes {
    return UnlimitedSwipe ? NO : %orig;
}

- (BOOL)canDieFromThornsAndLightning {
    return NoDie ? NO : %orig;
}

- (void)dieWithVelocity:(CGFloat)velocity {
    if (NoDie) return;
    %orig;
}

- (void)setAlive:(BOOL)alive {
    %orig(NoDie ? YES : alive);
}

- (void)animDie {
    if (NoDie) return;
    %orig;
}

- (void)animBigImpact {
    if (NoDie) return;
    %orig;
}

- (void)checkStuck {
    if (NoDie) return;
    %orig;
}

- (void)restartFromStuck {
    if (NoDie) return;
    %orig;
}

%end

%hook Ruckus_GameObject

- (BOOL)instantDeath {
    return NoDie ? NO : %orig;
}

- (void)setInstantDeath:(BOOL)death {
    %orig(NoDie ? NO : death);
}

%end

%end

%group world

%hook Ruckus_Ledge

- (BOOL)isIcy {
    return Icy;
}

- (BOOL)isWorldEdge {
    return !Icy;
}

%end

%end

%group score

%hook Ruckus_Constants

+ (int)scoreFallBonus { int r = %orig; return (r*m); }
+ (int)scoreSlideBonus { int r = %orig; return (r*m); }
+ (int)scoreBounceBonus { int r = %orig; return (r*m); }
+ (int)scoreWindBonus { int r = %orig; return (r*m); }
+ (int)scoreBumperBonus { int r = %orig; return (r*m); }
+ (int)scorePowerPuggyBonus { int r = %orig; return (r*m); }
+ (int)scoreTimeSecondBonus { int r = %orig; return (r*m); }
+ (int)scoreTimeBonusPerfect { int r = %orig; return (r*m); }
+ (int)scoreTimeBonusLimit { int r = %orig; return (r*m); }
+ (int)scoreGoldSwipeBonus { int r = %orig; return (r*m); }
+ (int)scoreSilverSwipeBonus { int r = %orig; return (r*m); }
+ (int)scoreBronzeSwipeBonus { int r = %orig; return (r*m); }
+ (int)scoreGoldBonus { int r = %orig; return (r*m); }
+ (int)scoreSilverBonus { int r = %orig; return (r*m); }
+ (int)scoreBronzeBonus { int r = %orig; return (r*m); }
+ (int)winBronze { int r = %orig; return (r*m); }
+ (int)winSilver { int r = %orig; return (r*m); }
+ (int)winGold { int r = %orig; return (r*m); }
+ (int)winRange { int r = %orig; return (r*m); }
+ (int)numGoldsInARow { int r = %orig; return (r*m); }

%end

%end

%group gameplay

%hook AppDelegate

- (BOOL)isMyTown2Installed {
    return HideMT2 ? YES : %orig;
}

%end

%hook Ruckus_ADManager

- (void)start {
    if (NoPopUp) return;
    %orig;
}

- (void)showAd {
    if (NoPopUp) return;
    %orig;
}

%end

%hook MPInterstitialAdController

- (void)loadAD {
    if (NoPopUp) return;
    %orig;
}

%end

%hook MPAdManager

- (void)loadAdWithURL:(id)arg1 {
    if (NoPopUp) return;
    %orig;
}

- (void)setAdView:(id)arg1 {
    if (NoPopUp) return;
    %orig;
}

- (void)refreshAd {
    if (NoPopUp) return;
    %orig;
}

%end

%hook MRAdView

- (id)initWithFrame:(CGRect)frame {
    return NoPopUp ? nil : %orig;
}
- (id)initWithFrame:(CGRect)frame allowsExpansion:(BOOL)arg2 closeButtonStyle:(unsigned int)arg3 placementType:(unsigned int)arg4 {
    return NoPopUp ? nil : %orig;
}

%end

%hook MRAdViewBrowsingController

- (id)initWithAdView:(id)arg1 {
    return NoPopUp ? nil : %orig;
}

%end

%hook MRAdViewDisplayController

- (id)view {
    return NoPopUp ? nil : %orig;
}
- (void)setView:(id)view {
    if (NoPopUp) return;
    %orig;
}

%end

%hook Ruckus_Game

- (BOOL)didWin {
    return AlwaysWin ? YES : %orig;
}

- (unsigned int)score {
    return FixedScore ? FixedScoreValue : %orig;
}

%end

%hook Ruckus_HUD

- (void)showNoSwipes {
    if (UnlimitedSwipe) return;
    %orig;
}

%end

%hook Ruckus_CircleTimer

- (BOOL)running {
    return PhoenixTimeFreeze ? NO : %orig;
}

- (void)update:(CGFloat)arg1 {
    if (PhoenixTimeFreeze) return;
    %orig;
}

- (void)start {
    if (PhoenixTimeFreeze) return;
    %orig;
}

%end

%hook Ruckus_ZoneSelectBird

- (void)jump {
    if (StaticBird) return;
    %orig;
}

- (void)jumpDone {
    if (StaticBird) return;
    %orig;
}

- (void)land {
    if (StaticBird) return;
    %orig;
}

- (void)landDone {
    if (StaticBird) return;
    %orig;
}

%end

%end

%group system

%hook CCDirector

- (BOOL)displayFPS {
    return ShowFPS ? YES : %orig;
}

- (void)setDisplayFPS:(BOOL)fps {
    %orig(ShowFPS ? YES : fps);
}

%end

%hook TapjoyConnect

- (BOOL)isJailBroken {
    return NoJB ? NO : %orig;
}

%end

%hook FlurrySession

+ (BOOL)deviceIsJailbroken {
    return NoJB ? NO : %orig;
}

%end

%end

static void loadHacks() {
    NSDictionary *dict = [NSDictionary dictionaryWithContentsOfFile:@"/var/mobile/Library/Preferences/com.PS.EarlyBirdHack.plist"];
    id unlimitedswipe = [dict objectForKey:@"unlimitedSwipe"]; // mv
    id nodie = [dict objectForKey:@"noDie"];
    
    id fixedscore = [dict objectForKey:@"fixedScore"];
    int readFixedScoreValue = [dict objectForKey:@"fixedScoreValue"] ? [[dict objectForKey:@"fixedScoreValue"] integerValue] : 50000;
    id multiplescore = [dict objectForKey:@"multipleScore"];
    int readMultipleScoreValue = [dict objectForKey:@"multiplierValue"] ? [[dict objectForKey:@"multiplierValue"] integerValue] : 1;
    
    id icy = [dict objectForKey:@"iCy"];
    
    id phoenixtimefreeze = [dict objectForKey:@"phoenixTimeFreeze"];
    id staticbird = [dict objectForKey:@"staticBird"];
    id showfps = [dict objectForKey:@"showFPS"];
    id alwayswin = [dict objectForKey:@"alwaysWin"];
    id hidemt2 = [dict objectForKey:@"hideMT2"];
    id nopopup = [dict objectForKey:@"noPopUp"];
    
    id nojb = [dict objectForKey:@"noJB"];
    
    UnlimitedSwipe = unlimitedswipe ? [unlimitedswipe boolValue] : YES;
    NoDie = nodie ? [nodie boolValue] : YES;
    
    FixedScore = fixedscore ? [fixedscore boolValue] : YES;
    if (readFixedScoreValue < 0)
        readFixedScoreValue = 50000;
    if (readFixedScoreValue != FixedScoreValue)
        FixedScoreValue = readFixedScoreValue;
    MultipleScore = multiplescore ? [multiplescore boolValue] : YES;
    if (readMultipleScoreValue < 1)
        readMultipleScoreValue = 1;
    if (readMultipleScoreValue != m)
        m = readMultipleScoreValue;
    
    Icy = icy ? [icy boolValue] : YES;
    
    PhoenixTimeFreeze = phoenixtimefreeze ? [phoenixtimefreeze boolValue] : YES;
    StaticBird = staticbird ? [staticbird boolValue] : YES;
    ShowFPS = showfps ? [showfps boolValue] : YES;
    AlwaysWin = alwayswin ? [alwayswin boolValue] : YES;
    HideMT2 = hidemt2 ? [hidemt2 boolValue] : YES;
    NoPopUp = nopopup ? [nopopup boolValue] : YES;
    
    NoJB = nojb ? [nojb boolValue] : YES;
}

static void PostNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo) {
    loadHacks();
}

%ctor {
    @autoreleasepool {
        CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PostNotification, CFSTR("com.PS.EarlyBirdHack.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
        loadHacks();
        %init(bird);
        %init(world);
        %init(score);
        %init(gameplay);
        %init(system);
    }
}