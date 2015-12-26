
#import "SWISeeStarsRatingView.h"
#import "libsw/libSluthware/libSluthware.h"

#import "MusicCoalescingEntityValueProvider.h"

#import <objc/runtime.h>





@interface MusicEntityAbstractLockupView : UIView
{
}

@property (nonatomic, retain) MusicCoalescingEntityValueProvider *entityValueProvider;

@end





%hook MusicEntityAbstractLockupView

%new
- (void)iSeeStars_addRatingView
{
    
    
//    if (!bundle) {
//        return;
//    }
//    
//    UIImageView *expl = MSHookIvar<UIImageView *>(self, "_explicitBadgeImageView");
//    expl.contentMode = UIViewContentModeScaleAspectFit;
//    CGRect originFrame = expl.frame;
//    NSLog(@"Cello %@", expl);
//    UIImage *explicitHeart = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"Heart_Explicit" ofType:@"png"]];
//    explicitHeart = [explicitHeart imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
//    expl.image = explicitHeart;
//    expl.frame = originFrame;
//    
//    
////    if ([arg1 isEqualToString:@"isExplicit"]) {
////        if (%orig(@"likedState")) {
////            return @(YES);
////        }
////    }
//    
//    
//    
//    
    SWISeeStarsRatingView *rating = (SWISeeStarsRatingView *)[self viewWithTag:696969];
    NSNumber *itemRating;
    NSNumber *itemLikedState; // heart
    
    
    
    id entityProvider = self.entityValueProvider.baseEntityValueProvider;
    
    if (entityProvider && [[entityProvider class] isSubclassOfClass:%c(MPConcreteMediaItem)]) { // media cell
        
        itemRating = [self.entityValueProvider valueForEntityProperty:@"rating"];
        itemLikedState = [self.entityValueProvider valueForEntityProperty:@"likedState"];
        
    } else { // not a media cell
        if (rating) {
            [rating removeFromSuperview];
        }
        return;
    }
    
    
    
    if (!rating) {
        
        NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/Application Support/ISeeStarsSupport.bundle"];
        
        if (bundle) {
            
            UIImage *dots = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"Dots" ofType:@"png"]];
            UIImage *stars = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"Stars" ofType:@"png"]];
            UIImage *hearts = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"Hearts" ofType:@"png"]];
            
            rating = [[SWISeeStarsRatingView alloc] initWithDotsImage:dots
                                                        andStarsImage:stars
                                                        andHeartsImage:hearts];
            [self addSubview:rating];
            
            [self addConstraint:[NSLayoutConstraint constraintWithItem:rating
                                                             attribute:NSLayoutAttributeLeading
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeLeading
                                                            multiplier:1.0
                                                              constant:0.0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:rating
                                                             attribute:NSLayoutAttributeWidth
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:16]]; //artwork origin (taken from flex)
            [self addConstraint:[NSLayoutConstraint constraintWithItem:rating
                                                             attribute:NSLayoutAttributeCenterY
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:self
                                                             attribute:NSLayoutAttributeCenterY
                                                            multiplier:1.0
                                                              constant:0.0]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:rating
                                                             attribute:NSLayoutAttributeHeight
                                                             relatedBy:NSLayoutRelationEqual
                                                                toItem:nil
                                                             attribute:NSLayoutAttributeNotAnAttribute
                                                            multiplier:1.0
                                                              constant:CGRectGetHeight(self.bounds) - 4]]; //2 pixel padding on top/bottom
            [self setNeedsLayout];
            
        }
        
    }
    
    if (rating) {
        rating.rating = [itemRating integerValue];
        rating.likedStatus = [itemLikedState integerValue];
    }
    
}

%end





%hook MusicLibraryBrowseTableViewController

- (void)tableView:(id)tableView willDisplayCell:(id)cell forRowAtIndexPath:(id)indexPath
{
    %orig();
    
    //the viewcontrollers are both descendents of the same class, as are the content views.
    //but the cell classes are different, and the variable names are different, so we will try both.
    
    id view = nil;
    Ivar viewIvar = class_getInstanceVariable([cell class], [@"_tracklistItemView" UTF8String]);
    
    if (viewIvar != nil) {
        view = object_getIvar(cell, viewIvar);
    } else {
        viewIvar = class_getInstanceVariable([cell class], [@"_lockupView" UTF8String]);
        if (viewIvar != nil) {
            view = object_getIvar(cell, viewIvar);
        }
    }
    
    if (view && [view respondsToSelector:@selector(iSeeStars_addRatingView)]) {
        [view performSelectorOnMainThread:@selector(iSeeStars_addRatingView) withObject:nil waitUntilDone:NO];
    }
}

%end





%ctor
{
}




