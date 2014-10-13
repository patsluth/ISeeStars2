//
//  SWISSPSHeaderCell.m
//
//
//  Created by Pat Sluth on 2014-09-28.
//
//

#import "SWISSPrefsBundle.h"

#import "SWISSPSHeaderCell.h"
#import "SWISSPrefsBundle.h"
#import <libsw/sluthwareios/SWGradientView.h>

#import <Preferences/Preferences.h>

@implementation SWISSPSHeaderCell

- (id)initWithStyle:(int)style reuseIdentifier:(id)identifier specifier:(id)specifier
{
    self = [super initWithStyle:style reuseIdentifier:identifier specifier:specifier];
    
    if (self){
        
        NSBundle *bundle = [NSBundle bundleWithPath:SW_ISS_PREFS_BUNDLE_PATH];
        
        if (bundle){
            
            SWGradientView *gradient = [[SWGradientView alloc] initWithFrame:self.frame
                                        andColours:@[(id)[[UIColor colorWithRed:0.97 green:1.00 blue:0.00 alpha:1.0] CGColor],
                                                     (id)[[UIColor colorWithRed:1.00 green:0.71 blue:0.00 alpha:1.0] CGColor]]];
            gradient.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            [self.contentView addSubview:gradient];
            
            
            
            /*UIImage *star = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"SW_ISS_Star" ofType:@"png"]];
             UIImageView *image = [[UIImageView alloc] initWithImage:star];
             image.contentMode = UIViewContentModeScaleAspectFill;
             
             [self.contentView addSubview:image];*/
            
            
            
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:gradient.frame];
            titleLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
            titleLabel.font = [UIFont systemFontOfSize:29];
            titleLabel.textColor = [UIColor blackColor];
            titleLabel.textAlignment = NSTextAlignmentCenter;
            titleLabel.text = @"I See Stars";
            [gradient addSubview:titleLabel];
        }
    }
    
    return self;
}

@end









