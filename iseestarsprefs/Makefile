




ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:7.0





BUNDLE_NAME = ISeeStarsPrefs
ISeeStarsPrefs_CFLAGS = -fobjc-arc
ISeeStarsPrefs_FILES = SWISeeStarsPrefsListController.mm
ISeeStarsPrefs_INSTALL_PATH = /Library/PreferenceBundles
ISeeStarsPrefs_FRAMEWORKS = UIKit
ISeeStarsPrefs_PRIVATE_FRAMEWORKS = Preferences
ISeeStarsPrefs_LIBRARIES = sw

ADDITIONAL_CFLAGS = -Ipublic
ADDITIONAL_CFLAGS += -Ipublic/libsw
ADDITIONAL_CFLAGS += -Ipublic/libsw/libSluthware





include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk





clean::
	rm -r .theos





internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/ISeeStars.plist$(ECHO_END)




