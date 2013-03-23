GO_EASY_ON_ME = 1

include theos/makefiles/common.mk
export ARCHS = armv7
TWEAK_NAME = EarlyBirdHack
EarlyBirdHack_FILES = Tweak.xm

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = EarlyBirdHackSettings
EarlyBirdHackSettings_FILES = EBHackPreferenceController.m
EarlyBirdHackSettings_INSTALL_PATH = /Library/PreferenceBundles
EarlyBirdHackSettings_PRIVATE_FRAMEWORKS = Preferences
EarlyBirdHackSettings_FRAMEWORKS = UIKit

include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/EarlyBirdHack.plist$(ECHO_END)
	$(ECHO_NOTHING)find $(THEOS_STAGING_DIR) -name .DS_Store | xargs rm -rf$(ECHO_END)
