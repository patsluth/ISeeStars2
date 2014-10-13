#import "SWISSPrefsBundle.h"

#import <Preferences/Preferences.h>
#import <libpackageinfo/libpackageinfo.h>

@interface ISeeStarsPrefsListController: PSListController
{
}

@property (strong, nonatomic) PIDebianPackage *packageDEB;

@end

@implementation ISeeStarsPrefsListController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0ul);
    dispatch_async(queue, ^{
        
        self.packageDEB = [PIDebianPackage packageForFile:SW_ISS_PREFS_BUNDLE_PATH];
        
        dispatch_sync(dispatch_get_main_queue(), ^{
            
            PSSpecifier *spec = [self specifierForID:@"Version"];
            if (spec){
                [self reloadSpecifier:spec animated:YES];
            }
            
        });
    });
}

- (id)specifiers
{
	if(_specifiers == nil){
		_specifiers = [self loadSpecifiersFromPlistName:@"ISeeStarsPrefs" target:self];
	}
    
	return _specifiers;
}

- (id)getVersionNumberForSpecifier:(PSSpecifier *)specifier
{
    if (self.packageDEB){
        return self.packageDEB.version;
    }
    
    return @"...";
}

@end




