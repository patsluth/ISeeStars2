




ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest





BUNDLE_NAME = ISeeStarsPrefs2
ISeeStarsPrefs2_CFLAGS = -fobjc-arc
ISeeStarsPrefs2_FILES = SWISeeStarsPrefsListController.mm
ISeeStarsPrefs2_INSTALL_PATH = /Library/PreferenceBundles
ISeeStarsPrefs2_FRAMEWORKS = UIKit
ISeeStarsPrefs2_PRIVATE_FRAMEWORKS = Preferences
ISeeStarsPrefs2_LIBRARIES = sw

ADDITIONAL_CFLAGS = -Ipublic
ADDITIONAL_CFLAGS += -Ipublic/libsw
ADDITIONAL_CFLAGS += -Ipublic/libsw/libSluthware





include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk





clean::
	rm -rf .theos





internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ISeeStars2.plist$(ECHO_END)




