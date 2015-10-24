
#import "SWISeeStarsRatingView.h"

#import "libsw/libSluthware/libSluthware.h"

#import <MediaPlayer/MediaPlayer.h>

#import <objc/runtime.h>





@interface MusicEntityValueProviding : NSObject
{
}

//<MusicEntityValueProviding> MPConcreteMediaItem ?????
//Double check class at runtime
- (id)baseEntityValueProvider;

@end


@interface MusicEntityAbstractLockupView : UIView
{
}

@property (nonatomic, retain) MusicEntityValueProviding *entityValueProvider;

@end





%hook MusicEntityAbstractLockupView

%new
- (void)iSeeStars_addRatingView
{
    SWISeeStarsRatingView *rating = (SWISeeStarsRatingView *)[self viewWithTag:696969];
    NSInteger ratingValue = 0;
    
    id entityProvider = self.entityValueProvider.baseEntityValueProvider;
    
    if (entityProvider && [[entityProvider class] isSubclassOfClass:[MPMediaEntity class]]){
        
        MPMediaEntity *mediaItem = (MPMediaEntity *)entityProvider;
        NSNumber *itemRating = [mediaItem valueForProperty:MPMediaItemPropertyRating];
        
        if (!itemRating){
            if (rating){ [rating removeFromSuperview]; }
            return;
        }
        
        ratingValue = [itemRating integerValue];
        
    } else { //if the cell doesnt have a media item, it isnt a media cell
        if (rating){ [rating removeFromSuperview]; }
        return;
    }
    
    if (!rating){
        
        NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/Application Support/ISeeStarsSupport.bundle"];
        
        if (bundle){
            
            UIImage *dots = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"Dots" ofType:@"png"]];
            UIImage *stars = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"Stars" ofType:@"png"]];
            
            rating = [[SWISeeStarsRatingView alloc] initWithDotsImage:dots
                                                        andStarsImage:stars];
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
    
    if (rating){
        rating.rating = ratingValue;
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
    
    if (viewIvar != nil){
        view = object_getIvar(cell, viewIvar);
    } else {
        viewIvar = class_getInstanceVariable([cell class], [@"_lockupView" UTF8String]);
        if (viewIvar != nil){
            view = object_getIvar(cell, viewIvar);
        }
    }
    
    if (view && [view respondsToSelector:@selector(iSeeStars_addRatingView)]){
        [view performSelectorOnMainThread:@selector(iSeeStars_addRatingView) withObject:nil waitUntilDone:NO];
    }
}

%end





%ctor
{
}




