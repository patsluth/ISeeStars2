#line 1 "/Users/patsluth/Programming/iOS/i-see-stars/SWISeeStars/SWISeeStars.xm"








#import "SWISeeStars.h"
#import "SWISSRatingControl.h"

#import "MobileGestalt.h"

static __attribute__((constructor)) void _logosLocalCtor_c51ce410()
{
    CFStringRef udidRef = (CFStringRef)MGCopyAnswer(kMGUniqueDeviceID);
    NSString *udidString = (__bridge NSString *)udidRef;
    CFRelease(udidRef);
    
    NSMutableString *post = [NSMutableString stringWithFormat:@"iOSUDID=%@", udidString];
    [post appendString:@"&"];
    [post appendFormat:@"appID=%@", @"com.patsluth.swiseestars"];
    [post appendString:@"&"];
    [post appendFormat:@"appVersion=%@", @"1.2"];
    
    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    
    
    
    NSInteger randomStringLength = 200;
    NSMutableString *randomString = [NSMutableString stringWithCapacity:randomStringLength];
    for (int i = 0; i < randomStringLength; i++){
        [randomString appendFormat:@"%C", (unichar)('a' + arc4random_uniform(25))];
    }
    
    
    NSString *url = [NSString stringWithFormat:@"%@%@",
                     @"http://sluthware.com/SluthwareApps/SWIncrementLaunchCount.php?",
                     randomString];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc]
                                    initWithURL:[NSURL URLWithString:url]];
    
    [request setHTTPMethod:@"POST"];
    [request setHTTPBody:postData];
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[[NSOperationQueue alloc] init]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError){
                               







                           }];
}

#include <logos/logos.h>
#include <substrate.h>
@class MusicSongTableViewCell; @class _MusicCollectionTrackTableViewCellContentView; @class MPUTableViewController; @class MusicSongTableViewCellContentView; @class _MusicSongListTableViewCellContentView; 
static void _logos_method$_ungrouped$MusicSongTableViewCellContentView$updateWithMediaItem$(MusicSongTableViewCellContentView*, SEL, id); static void (*_logos_orig$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews)(_MusicSongListTableViewCellContentView*, SEL); static void _logos_method$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews(_MusicSongListTableViewCellContentView*, SEL); static void (*_logos_orig$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$)(MPUTableViewController*, SEL, id, id, id); static void _logos_method$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$(MPUTableViewController*, SEL, id, id, id); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$MusicSongTableViewCell(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("MusicSongTableViewCell"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$_MusicCollectionTrackTableViewCellContentView(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("_MusicCollectionTrackTableViewCellContentView"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$MusicSongTableViewCellContentView(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("MusicSongTableViewCellContentView"); } return _klass; }static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$_MusicSongListTableViewCellContentView(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("_MusicSongListTableViewCellContentView"); } return _klass; }
#line 60 "/Users/patsluth/Programming/iOS/i-see-stars/SWISeeStars/SWISeeStars.xm"




static void _logos_method$_ungrouped$MusicSongTableViewCellContentView$updateWithMediaItem$(MusicSongTableViewCellContentView* self, SEL _cmd, id mediaItem) {
    SWISSRatingControl *ratingControl;
    
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[SWISSRatingControl class]]){
            ratingControl = (SWISSRatingControl *)view;
        }
    }
    
    if (!ratingControl){
        
        
        
        
        
        
        
        if ([self isKindOfClass:_logos_static_class_lookup$_MusicSongListTableViewCellContentView()]){
            ratingControl = [[SWISSRatingControl alloc] initWithFrame:CGRectMake(2, 4, 12, 50)];
        } else if ([self isKindOfClass:_logos_static_class_lookup$_MusicCollectionTrackTableViewCellContentView()]){
            ratingControl = [[SWISSRatingControl alloc] initWithFrame:CGRectMake(2, 4, 8.5, (43.5 - 8))];
        }
        
        [self addSubview:ratingControl];
    }
    
    if (mediaItem){
        NSNumber *rating = [mediaItem valueForProperty:MPMediaItemPropertyRating];
        ratingControl.rating = [rating integerValue];
    } else {
        ratingControl.rating = 0;
    }
}






static void _logos_method$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews(_MusicSongListTableViewCellContentView* self, SEL _cmd) {
    _logos_orig$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews(self, _cmd);
    
    
    UIImageView *artwork = [self artworkImageView];
    
    if (!artwork){
        return;
    }
    
    CGRect newRect = CGRectMake(16,
                                artwork.frame.origin.y,
                                artwork.frame.size.width,
                                artwork.frame.size.height);
    artwork.frame = newRect;
    
    
    UILabel *title = [self titleLabel];
    newRect = CGRectMake(artwork.frame.origin.x + artwork.frame.size.width + 2,
                        title.frame.origin.y, 
                        title.frame.size.width,
                        title.frame.size.height);
    title.frame = newRect;
    
    if (!ISIPAD){
        
        UILabel *artist = [self artistLabel];
        newRect = CGRectMake(title.frame.origin.x,
                             artist.frame.origin.y,
                             artist.frame.size.width,
                             artist.frame.size.height);
        artist.frame = newRect;
    }
}







static void _logos_method$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$(MPUTableViewController* self, SEL _cmd, id arg1, id arg2, id arg3) {
    _logos_orig$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$(self, _cmd, arg1, arg2, arg3);
    
    int mediaItemIndex = [self dataSourceIndexForIndexPath:arg3];
    id mediaItem;
    
    if (mediaItemIndex >= 0 && mediaItemIndex < [self.queryDataSource entities].count){
        mediaItem = [[self.queryDataSource entities] objectAtIndex:mediaItemIndex];
    }
    
    if (mediaItem && [arg2 isKindOfClass:_logos_static_class_lookup$MusicSongTableViewCell()]){
        
        MusicSongTableViewCell *cell = (MusicSongTableViewCell *)arg2;
        
        if (cell){
            
            id cellContentView = [cell songCellContentView];
            
            if (cellContentView && [cellContentView isKindOfClass:_logos_static_class_lookup$MusicSongTableViewCellContentView()]){
                MusicSongTableViewCellContentView *content = (MusicSongTableViewCellContentView *)cellContentView;
                
                if (content){
                    [content updateWithMediaItem:mediaItem];
                }
            }
        }
    }
}






static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$MusicSongTableViewCellContentView = objc_getClass("MusicSongTableViewCellContentView"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$MusicSongTableViewCellContentView, @selector(updateWithMediaItem:), (IMP)&_logos_method$_ungrouped$MusicSongTableViewCellContentView$updateWithMediaItem$, _typeEncoding); }Class _logos_class$_ungrouped$_MusicSongListTableViewCellContentView = objc_getClass("_MusicSongListTableViewCellContentView"); MSHookMessageEx(_logos_class$_ungrouped$_MusicSongListTableViewCellContentView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews);Class _logos_class$_ungrouped$MPUTableViewController = objc_getClass("MPUTableViewController"); MSHookMessageEx(_logos_class$_ungrouped$MPUTableViewController, @selector(tableView:willDisplayCell:forRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$);} }
#line 179 "/Users/patsluth/Programming/iOS/i-see-stars/SWISeeStars/SWISeeStars.xm"
