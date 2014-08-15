export ARCHS = armv7 armv7s arm64
export TARGET = iphone:clang:7.1:7.1

include theos/makefiles/common.mk

THEOS_DEVICE_IP = 192.168.1.149
THEOS_DEVICE_PORT = 22

TWEAK_NAME = ISeeStars
ISeeStars_FILES = SWISeeStars.xm SWISSRatingControl.m
ISeeStars_CFLAGS = -fobjc-arc
ISeeStars_FRAMEWORKS = UIKit MediaPlayer
ISeeStars_LIBRARIES = MobileGestalt

include $(THEOS_MAKE_PATH)/tweak.mk

BUNDLE_NAME = SWISeeStarsBundle
SWISeeStarsBundle_INSTALL_PATH = /Library/Application Support

include $(THEOS)/makefiles/bundle.mk

after-install::
	install.exec "killall -9 backboardd"
	
	