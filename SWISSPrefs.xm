//
//  SWISSPrefs.xm
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-06-29.
//
//

#import "SWISSPrefs.h"

static NSDictionary *_preferences;

@implementation SWISSPrefs

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
    _preferences = [[NSDictionary alloc] initWithContentsOfFile:SW_ISS_PREFS_PATH];
}

%ctor
{
    CFNotificationCenterRef darwin = CFNotificationCenterGetDarwinNotifyCenter();
    CFNotificationCenterAddObserver(darwin,
                                    nil,
                                    prefsChanged,
                                    CFSTR(SW_ISS_PREFS_CHANGED_NOTIFICATION),
                                    nil,
                                    CFNotificationSuspensionBehaviorCoalesce);
    // Load preferences
    prefsChanged(nil, nil, nil, nil, nil);
}




