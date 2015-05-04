
#import "SWISeeStarsPrefsBridge.h"

#define SW_ISEESTARS_PREFERENCES_PATH @"/User/Library/Preferences/com.patsluth.ISeeStarsPrefs.plist"

static NSDictionary *_preferences;

@implementation SWISeeStarsPrefsBridge

+ (NSDictionary *)preferences
{
    return _preferences;
}

@end

static void prefsChanged(CFNotificationCenterRef center,
                         void *observer,
                         CFStringRef name,
                         const void *object,
                         CFDictionaryRef userInfo)
{
    _preferences = [[NSDictionary alloc] initWithContentsOfFile:SW_ISEESTARS_PREFERENCES_PATH];
}

%ctor
{
    CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(darwin,
                                    nil,
                                    prefsChanged,
                                    CFSTR("com.patsluth.ISeeStarsPrefs.changed"),
                                    nil,
                                    CFNotificationSuspensionBehaviorCoalesce);
    // Load preferences
    prefsChanged(nil, nil, nil, nil, nil);
}




