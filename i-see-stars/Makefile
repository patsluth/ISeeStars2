




THEOS_PACKAGE_DIR_NAME = debs
PACKAGE_VERSION = 1.0-1





#USEWIFI = 1 ###COMMENT OUT TO USE USB

ifdef USEWIFI
    THEOS_DEVICE_IP = 192.168.1.123
    THEOS_DEVICE_PORT = 22
else
    THEOS_DEVICE_IP = 127.0.0.1
    THEOS_DEVICE_PORT = 2222
endif





ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest





TWEAK_NAME = ISeeStars
ISeeStars_CFLAGS = -fobjc-arc
ISeeStars_FILES = SWISeeStars.xm ISeeStarsTest/ISeeStarsTest/SWISeeStarsRatingView.m
ISeeStars_FRAMEWORKS = Foundation UIKit MediaPlayer CoreGraphics
ISeeStars_LIBRARIES = sw packageinfo

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
	@install.exec "killall -9 SpringBoard"




