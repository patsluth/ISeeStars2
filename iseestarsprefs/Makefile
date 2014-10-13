ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:7.0

BUNDLE_NAME = ISeeStarsPrefs
ISeeStarsPrefs_CFLAGS = -fobjc-arc
ISeeStarsPrefs_FILES = ISeeStarsPrefs.mm SWISSPSHeaderCell.m
ISeeStarsPrefs_INSTALL_PATH = /Library/PreferenceBundles
ISeeStarsPrefs_FRAMEWORKS = UIKit
ISeeStarsPrefs_PRIVATE_FRAMEWORKS = Preferences
ISeeStarsPrefs_LDFLAGS = -lsw -lpackageinfo

ADDITIONAL_CFLAGS = -Ipublic

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/bundle.mk

internal-stage::
	$(ECHO_NOTHING)mkdir -p $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences$(ECHO_END)
	$(ECHO_NOTHING)cp entry.plist $(THEOS_STAGING_DIR)/Library/PreferenceLoader/Preferences/SWISSPrefs.plist$(ECHO_END)