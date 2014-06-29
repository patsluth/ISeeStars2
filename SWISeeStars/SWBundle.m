//
//  SWBundle.m
//  SWGestureMusicControls
//
//  Created by Pat Sluth on 2014-02-25.
//
//

#import "SWBundle.h"

#define SW_GMC_MAIN_BUNDLE_PATH @"/Library/Application Support/SWISS/SWISeeStars.bundle"

@implementation SWBundle

+ (NSBundle *)bundleAtPath:(NSString *)path andLoad:(BOOL)load
{
    NSBundle *bundle = [NSBundle bundleWithPath:path];
    
    if (!bundle){
        NSLog(@"SW - Error loading bundle at path %@", path);
    }
    
    if (load && bundle && !bundle.isLoaded){
        [bundle load];
    }
    
    return bundle;
}

+ (NSBundle *)mainBundleAndLoad:(BOOL)load;
{
    return [SWBundle bundleAtPath:SW_GMC_MAIN_BUNDLE_PATH andLoad:load];
}

+ (UIImage *)imageInMainBundleNamed:(NSString *)imageName ofType:(NSString *)imageType
{
    return [SWBundle imageInBundle:[SWBundle mainBundleAndLoad:YES]
                             named:imageName
                            ofType:imageType];
}

+ (UIImage *)imageInBundle:(NSBundle *)bundle named:(NSString *)imageName ofType:(NSString *)imageType
{
    UIImage *image;
    
    if (bundle){
        NSString *imagePath = [bundle pathForResource:imageName ofType:imageType];
        image = [UIImage imageWithContentsOfFile:imagePath];
    }
    
    if (!image){
        NSLog(@"SW - Error loading image named %@ from bundle %@", imageName, bundle.bundleIdentifier);
    }
    
    return image;
}

@end




