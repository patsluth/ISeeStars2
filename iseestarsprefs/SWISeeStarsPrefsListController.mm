//
//  SWISeeStarsPrefsListController.m
//  libsw
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWISeeStarsPrefsListController.h"

#import <Preferences/Preferences.h>

#import "libSluthware.h"
#import "SWPSTwitterCell.h"





@interface SWISeeStarsPrefsListController()
{
}

@end





@implementation SWISeeStarsPrefsListController

#pragma mark Init

- (id)specifiers
{
    if(_specifiers == nil){
        _specifiers = [self loadSpecifiersFromPlistName:@"ISeeStarsPrefs" target:self];
    }
    
    return _specifiers;
}

#pragma mark - Override

- (NSString *)bundlePath
{
    return @"/Library/PreferenceBundles/ISeeStarsPrefs.bundle";
}

- (NSString *)displayName
{
    return @"I See Stars";
}

- (NSString *)plistPath
{
    return @"/User/Library/Preferences/com.patsluth.ISeeStarsPrefs.plist";
}

#pragma mark Twitter

- (void)viewTwitterProfile:(PSSpecifier *)specifier
{
    [SWPSTwitterCell performActionWithSpecifier:specifier];
}

@end




