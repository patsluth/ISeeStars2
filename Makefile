




FINALPACKAGE = 1
DEBUG = 0
PACKAGE_VERSION = 1.0-6





ifeq ($(DEBUG), 1)
    ARCHS = arm64
else
    ARCHS = armv7 armv7s arm64
endif
TARGET = iphone:clang:latest:7.0





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




