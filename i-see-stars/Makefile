




PACKAGE_VERSION = 1.0-4





ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest





TWEAK_NAME = ISeeStars2
ISeeStars2_CFLAGS += -fobjc-arc
#ISeeStars2_LDFLAGS += -Wl,-segalign,4000
ISeeStars2_FILES = SWISeeStars.xm ISeeStarsTest/ISeeStarsTest/SWISeeStarsRatingView.m
ISeeStars2_FRAMEWORKS = Foundation UIKit MediaPlayer CoreGraphics
ISeeStars2_LIBRARIES = sw packageinfo

ADDITIONAL_CFLAGS = -Ipublic
ADDITIONAL_CFLAGS += -IISeeStarsTest/ISeeStarsTest/
ADDITIONAL_CFLAGS += -Ipublic/libsw
ADDITIONAL_CFLAGS += -Ipublic/libsw/libSluthware





BUNDLE_NAME = ISeeStarsSupport
ISeeStarsSupport_INSTALL_PATH = /Library/Application Support





SUBPROJECTS += iseestarsprefs/iseestarsprefs





include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS)/makefiles/bundle.mk
include $(THEOS_MAKE_PATH)/aggregate.mk





clean::
	rm -rf debs
	rm -rf .theos





after-install::
	install.exec "killall -9 backboardd"




