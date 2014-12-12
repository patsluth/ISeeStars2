
#import "SWISeeStarsPrefsHeaderView.h"

#import <libsw/sluthwareios/sluthwareios.h>
#import <libpackageinfo/libpackageinfo.h>

#import <Preferences/Preferences.h>

#import "dlfcn.h"

#define SW_ISEESTARS_HEADER_HEIGHT 200

void *handle;

@interface SWISeeStarsPrefsListController: PSListController
{
}

@property (strong, nonatomic) SWISeeStarsPrefsHeaderView *iSeeStarsPrefsHeaderView;
@property (strong, nonatomic) PIDebianPackage *packageDEB;

@end

@implementation SWISeeStarsPrefsListController

#pragma mark Init

-(id)init
{
    self = [super init];
    
    if(self){
        handle = dlopen("/usr/lib/libsw.dylib", RTLD_NOW | RTLD_GLOBAL);
    }
    
    return self;
}

- (id)specifiers
{
    if(_specifiers == nil){
        _specifiers = [self loadSpecifiersFromPlistName:@"ISeeStarsPrefs" target:self];
    }
    
    return _specifiers;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if ([SWDeviceInfo iOSVersion_First] == 8){
        
        self.table.backgroundColor = [UIColor clearColor];
        
        UIView *tableViewHeader = [[UIView alloc] init];
        tableViewHeader.frame = CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y, self.table.frame.size.width, SW_ISEESTARS_HEADER_HEIGHT);
        self.table.tableHeaderView = tableViewHeader;
        
        
        
        NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/ISeeStarsPrefs.bundle"];
        
        if (bundle){
            self.iSeeStarsPrefsHeaderView = [[SWISeeStarsPrefsHeaderView alloc] initWithImage:[UIImage
                                                                                             imageWithContentsOfFile:[bundle
                                                                                                                      pathForResource:@"I_See_Stars_Prefs_Banner_Background" ofType:@"png"]]];
            self.iSeeStarsPrefsHeaderView.frame = tableViewHeader.frame;
            [self.table.superview insertSubview:self.iSeeStarsPrefsHeaderView belowSubview:self.table];
        }
        
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
    dispatch_async(queue, ^{
        
        self.packageDEB = [PIDebianPackage packageForFile:@"/Library/PreferenceBundles/ISeeStarsPrefs.bundle"];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            PSSpecifier *spec = [self specifierForID:@"Version"];
            if (spec){
                [self reloadSpecifier:spec animated:YES];
            }
            
        });
    });
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [self scrollViewDidScroll:self.table]; //update our stretch header so it is in correct position
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    if (self.iSeeStarsPrefsHeaderView){
        [self.iSeeStarsPrefsHeaderView removeFromSuperview];
        self.iSeeStarsPrefsHeaderView = nil;
    }
    
    self.packageDEB = nil;
}

#pragma mark UIScrollView

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (self.iSeeStarsPrefsHeaderView && self.table == scrollView){
        
        CGFloat delta = 0.0f;
        CGRect stretchedFrame = CGRectMake(self.table.frame.origin.x, self.table.frame.origin.y, self.table.frame.size.width, SW_ISEESTARS_HEADER_HEIGHT);
        
        delta = fabs(MIN(0.0f, self.table.contentOffset.y));
        
        if (self.table.contentOffset.y > 0.0f){
            stretchedFrame.origin.y -= self.table.contentOffset.y;
        }
        
        stretchedFrame.size.height += delta;
        self.iSeeStarsPrefsHeaderView.frame = stretchedFrame;
    }
}

#pragma mark Twitter

- (void)viewTwitterProfile:(PSSpecifier *)specifier
{
    if (!specifier.properties[@"username"]){
        return;
    }
    
    NSURL *tweetbotURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"tweetbot:///user_profile/", specifier.properties[@"username"]]];
    NSURL *twitterURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"twitter://user?screen_name=", specifier.properties[@"username"]]];
    
    if ([[UIApplication sharedApplication] canOpenURL:tweetbotURL]){
        [[UIApplication sharedApplication] openURL:tweetbotURL];
        return;
    } else if ([[UIApplication sharedApplication] canOpenURL:twitterURL]){
        [[UIApplication sharedApplication] openURL:twitterURL];
        return;
    }
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@", @"https://twitter.com/", specifier.properties[@"username"]]]];
}

#pragma mark Helper

- (id)getVersionNumberForSpecifier:(PSSpecifier *)specifier
{
    if (self.packageDEB){
        return self.packageDEB.version;
    }
    
    return @"...";
}

- (void)_returnKeyPressed:(id)pressed
{
    [super _returnKeyPressed:pressed];
    
    //this will dismiss the keyboard and save the preferences for the selected text field
    if ([self isKindOfClass:[UIViewController class]]){
        [((UIViewController *)self).view endEditing:YES];
    }
}

- (id)readPreferenceValue:(PSSpecifier *)specifier
{
    NSDictionary *acapellaPrefs = [NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.patsluth.ISeeStarsPrefs.plist"];
    
    if (!acapellaPrefs[specifier.properties[@"key"]]){
        if (acapellaPrefs[specifier.properties[@"placeholder"]]){
            return specifier.properties[@"placeholder"];
        }
        
        return specifier.properties[@"default"];
    }
    
    return acapellaPrefs[specifier.properties[@"key"]];
}

- (void)setPreferenceValue:(id)value specifier:(PSSpecifier *)specifier
{
    NSMutableDictionary *defaults = [NSMutableDictionary dictionary];
    [defaults addEntriesFromDictionary:[NSDictionary dictionaryWithContentsOfFile:@"/User/Library/Preferences/com.patsluth.ISeeStarsPrefs.plist"]];
    [defaults setObject:value forKey:specifier.properties[@"key"]];
    [defaults writeToFile:@"/User/Library/Preferences/com.patsluth.ISeeStarsPrefs.plist" atomically:YES];
    CFStringRef mikotoPost = (__bridge CFStringRef)specifier.properties[@"PostNotification"];
    CFNotificationCenterPostNotification(CFNotificationCenterGetDarwinNotifyCenter(), mikotoPost, NULL, NULL, YES);
}

- (void)dealloc
{
    dlclose(handle);
}

@end




