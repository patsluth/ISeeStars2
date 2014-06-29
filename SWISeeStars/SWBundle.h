//
//  SWBundle.h
//  SWGestureMusicControls
//
//  Created by Pat Sluth on 2014-02-25.
//
//

@interface SWBundle : NSObject

+ (NSBundle *)bundleAtPath:(NSString *)path andLoad:(BOOL)load;
+ (NSBundle *)mainBundleAndLoad:(BOOL)load;

+ (UIImage *)imageInMainBundleNamed:(NSString *)imageName ofType:(NSString *)imageType;
+ (UIImage *)imageInBundle:(NSBundle *)bundle named:(NSString *)imageName ofType:(NSString *)imageType;

@end




