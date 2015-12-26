




FINALPACKAGE = 1
PACKAGE_VERSION = 1.0-5





ARCHS = armv7 armv7s arm64
TARGET = iphone:clang:latest





TWEAK_NAME = ISeeStars2
ISeeStars2_CFLAGS += -fobjc-arc
ISeeStars2_FILES = SWISeeStars.xm SWISeeStarsRatingView.m
ISeeStars2_FRAMEWORKS = Foundation UIKit CoreGraphics
ISeeStars2_LIBRARIES = sw packageinfo

ADDITIONAL_CFLAGS = -Ipublic





BUNDLE_NAME = ISeeStarsSupport
ISeeStarsSupport_INSTALL_PATH = /Library/Application Support





SUBPROJECTS += ISeeStarsPrefs





include theos/makefiles/common.mk
include theos/makefiles/tweak.mk
include theos/makefiles/bundle.mk
include theos/makefiles/aggregate.mk
include theos/makefiles/swcommon.mk





after-install::
	$(ECHO_NOTHING)install.exec "killall -9 Music > /dev/null 2> /dev/null"; echo -n '';$(ECHO_END)




