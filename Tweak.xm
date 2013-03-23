#import "substrate.h"
static BOOL UnlimitedSwipe; // move from gameplay
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

static BOOL NoJB;

%group bird

%hook Ruckus_BlueBird

- (BOOL)outOfSwipes
{
	if (UnlimitedSwipe)
		return NO;
	else
		return %orig;
}

- (void)animDie
{
	if (NoDie) { }
	else { %orig; }
}

- (void)animBigImpact
{
	if (NoDie) { }
	else { %orig; }
}

%end

%hook Ruckus_Phoenix

- (BOOL)outOfSwipes
{
	if (UnlimitedSwipe)
		return NO;
	else
		return %orig;
}

- (BOOL)canDieFromThornsAndLightning
{
	if (NoDie)
		return NO;
	else
		return %orig;
}

- (void)animDie
{
	if (NoDie) { }
	else { %orig; }
}

- (void)animBigImpact
{
	if (NoDie) { }
	else { %orig; }
}

%end

%hook Ruckus_Character

- (int)usedSwipes
{
	if (UnlimitedSwipe)
		return 0;
	else
		return %orig;
}

- (BOOL)alive
{
	if (NoDie)
		return YES;
	else
		return %orig;
}

- (BOOL)outOfSwipes
{
	if (UnlimitedSwipe)
		return NO;
	else
		return %orig;
}

- (BOOL)canDieFromThornsAndLightning
{
	if (NoDie)
		return NO;
	else
		return %orig;
}

- (void)dieWithVelocity:(float)arg1
{
	if (NoDie) { }
	else { %orig; }
}

- (void)setAlive:(BOOL)arg1
{
	if (NoDie) { %orig(YES); }
	else { %orig; }
}

- (void)animDie
{
	if (NoDie) { }
	else { %orig; }
}

- (void)animBigImpact
{
	if (NoDie) { }
	else { %orig; }
}

%end

%hook Ruckus_GameObject

- (BOOL)instantDeath
{
	if (NoDie)
		return NO;
	else
		return %orig;
}

- (void)setInstantDeath:(BOOL)arg1
{
	if (NoDie) { %orig(NO); }
	else { %orig; }
}

%end

%end


%group world

%hook Ruckus_Ledge

- (BOOL)isIcy
{
	if (Icy)
		return YES;
	if (!Icy)
		return NO;
	else
		return %orig;
}

- (BOOL)isWorldEdge
{
	if (Icy)
		return NO;
	if (!Icy)
		return YES;
	else
		return %orig;
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

%hook Ruckus_Game

- (BOOL)didWin
{
	if (AlwaysWin)
		return YES;
	else
		return %orig;
}

- (unsigned int)score
{
	if (FixedScore)
		return FixedScoreValue;
	else
		return %orig;
}

%end

%hook Ruckus_HUD

- (void)showNoSwipes
{
	if (UnlimitedSwipe) { }
	else { %orig; }
}

%end

%hook Ruckus_CircleTimer

- (BOOL)running
{
	if (PhoenixTimeFreeze)
		return NO;
	else
		return %orig;
}

- (void)update:(float)arg1
{
	if (PhoenixTimeFreeze) { }
	else { %orig; }
}

- (void)start
{
	if (PhoenixTimeFreeze) { }
	else { %orig; }
}

%end

%hook Ruckus_ZoneSelectBird

- (void)jump
{
	if (StaticBird) { }
	else { %orig; }
}

- (void)jumpDone
{
	if (StaticBird) { }
	else { %orig; }
}

- (void)land
{
	if (StaticBird) { }
	else { %orig; }
}

- (void)landDone
{
	if (StaticBird) { }
	else { %orig; }
}

%end

%end


%group system

%hook CCDirector

- (BOOL)displayFPS
{
	if (ShowFPS)
		return YES;
	else
		return %orig;
}

- (void)setDisplayFPS:(BOOL)arg1
{ 
	if (ShowFPS) { %orig(YES); }
	else { %orig; }
}

%end

%hook TapjoyConnect

- (BOOL)isJailBroken
{
	if (NoJB)
		return NO;
	else
		return %orig;
}

%end

%hook FlurrySession

+ (BOOL)deviceIsJailbroken
{
	if (NoJB)
		return NO;
	else
		return %orig;
}

%end

%end

static void loadHacks()
{
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
	
	NoJB = nojb ? [nojb boolValue] : YES;

}

static void PostNotification(CFNotificationCenterRef center, void *observer, CFStringRef name, const void *object, CFDictionaryRef userInfo)
{
	loadHacks();
}

%ctor
{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, PostNotification, CFSTR("com.PS.EarlyBirdHack.settingschanged"), NULL, CFNotificationSuspensionBehaviorCoalesce);
	loadHacks();
	[pool drain];
	if ([[NSBundle mainBundle].bundleIdentifier isEqualToString:@"com.booyah.birdswithfriends"]) { %init(bird); %init(world); %init(score); %init(gameplay); %init(system); }
}