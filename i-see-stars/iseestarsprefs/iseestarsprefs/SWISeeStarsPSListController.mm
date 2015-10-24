//
//  SWISeeStarsPSListController.m
//  iseestarsprefs
//
//  Created by Pat Sluth on 2015-04-25.
//
//

#import "SWISeeStarsPSListController.h"

#import <Preferences/Preferences.h>

#import "libsw/libSluthware/libSluthware.h"
#import "libsw/SWPSTwitterCell.h"





@interface SWISeeStarsPSListController()
{
}

@end





@implementation SWISeeStarsPSListController

#pragma mark Twitter

- (void)viewTwitterProfile:(PSSpecifier *)specifier
{
    [SWPSTwitterCell performActionWithSpecifier:specifier];
}

@end




