//
//  SWISSPrefs.h
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-06-29.
//
//

#define SW_ISS_PREFS_PATH @"/User/Library/Preferences/com.patsluth.swissprefs.plist"
#define SW_ISS_PREFS_CHANGED_NOTIFICATION "com.patsluth.swissprefs.prefschanged"

@interface SWISSPrefs : NSObject
{
}

+ (NSDictionary *)preferences;

@end




