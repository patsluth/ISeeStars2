




ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:7.0





BUNDLE_NAME = ISeeStarsPrefs2
ISeeStarsPrefs2_CFLAGS = -fobjc-arc
ISeeStarsPrefs2_FILES = SWISeeStarsPSListController.mm
ISeeStarsPrefs2_INSTALL_PATH = /Library/PreferenceBundles
ISeeStarsPrefs2_FRAMEWORKS = UIKit
ISeeStarsPrefs2_PRIVATE_FRAMEWORKS = Preferences
ISeeStarsPrefs2_LIBRARIES = sw

ADDITIONAL_CFLAGS = -Ipublic





include theos/makefiles/common.mk
include theos/makefiles/bundle.mk
include theos/makefiles/swcommon.mk





internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ISeeStars2.plist$(ECHO_END)




