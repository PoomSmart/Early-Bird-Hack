#import <UIKit/UIKit.h>
#import <Preferences/Preferences.h>

__attribute__((visibility("hidden")))
@interface EBHackPreferenceController : PSListController
- (id)specifiers;
@end

@implementation EBHackPreferenceController

- (id)specifiers {
	if(_specifiers == nil) {
		_specifiers = [[self loadSpecifiersFromPlistName:@"EarlyBirdHack" target:self] retain];
  }
	return _specifiers;
}

@end
