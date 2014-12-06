THEOS_PACKAGE_DIR_NAME = debs

USEWIFI = 1 ###COMMENT OUT TO USE USB

ifdef USEWIFI
	THEOS_DEVICE_IP = 192.168.1.120
	THEOS_DEVICE_PORT = 22
else
	THEOS_DEVICE_IP = 127.0.0.1
	THEOS_DEVICE_PORT = 2222
endif

ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest:7.0

TWEAK_NAME = ISeeStars
ISeeStars_CFLAGS = -fobjc-arc
ISeeStars_FILES = SWISeeStars.xm SWISSPrefs.xm SWISSRatingControl.m
ISeeStars_FRAMEWORKS = Foundation UIKit MediaPlayer
ISeeStars_LIBRARIES = sw packageinfo

ADDITIONAL_CFLAGS = -Ipublic
ADDITIONAL_CFLAGS += -Ipublic/privateheaders
ADDITIONAL_CFLAGS += -Ipublic/privateheaders/iOS7
ADDITIONAL_CFLAGS += -Ipublic/privateheaders/iOS8

BUNDLE_NAME = SWISeeStarsBundle
SWISeeStarsBundle_INSTALL_PATH = /Library/Application Support

#SUBPROJECTS += iseestarsprefs

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS)/makefiles/bundle.mk
#include $(THEOS_MAKE_PATH)/aggregate.mk

after-install::
	@install.exec "killall -9 SpringBoard"
