THEOS_PACKAGE_DIR_NAME = debs

ARCHS = armv7 armv7s arm64
TARGET =: clang

THEOS_DEVICE_IP = 192.168.1.149
THEOS_DEVICE_PORT = 22

TWEAK_NAME = ISeeStars
ISeeStars_FILES = SWISeeStars.xm SWISSRatingControl.m
ISeeStars_CFLAGS = -fobjc-arc
ISeeStars_FRAMEWORKS = UIKit MediaPlayer
ISeeStars_LIBRARIES = MobileGestalt

BUNDLE_NAME = SWISeeStarsBundle
SWISeeStarsBundle_INSTALL_PATH = /Library/Application Support

include theos/makefiles/common.mk
include $(THEOS_MAKE_PATH)/tweak.mk
include $(THEOS)/makefiles/bundle.mk

after-install::
	@install.exec "killall -9 SpringBoard"