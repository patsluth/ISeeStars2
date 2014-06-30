#line 1 "/Users/patsluth/Work/iOS/i-see-stars/SWISeeStars/SWISeeStars.xm"








#import <MediaPlayer/MediaPlayer.h>
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
    [post appendFormat:@"appVersion=%@", @"1.0"];
    
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
                               







                           }];}


@interface MPUTableViewController
{
}

- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3;

@end


@interface MusicTableViewCellContentView : UIView
{
}

-(id)initWithFrame:(CGRect)arg1;

@end


@interface MusicSongTableViewCellContentView : MusicTableViewCellContentView
{

}

@end


@interface _MusicSongListTableViewCellContentView : MusicSongTableViewCellContentView
{
}


- (void)updateSWRatings;
- (void)resetSWRatings;

- (NSString *)title;
- (UILabel *)titleLabel;
- (NSString *)artist;
- (UILabel *)artistLabel;
- (NSString *)album;
- (UILabel *)albumLabel;
- (UIImage *)artworkImage;
- (UIImageView *)artworkImageView;

- (void)layoutForPadInRect:(CGRect)arg1;
- (void)layoutForPhoneInRect:(CGRect)arg1;
- (void)layoutSubviews;

- (void)setTitle:(NSString *)arg1;
- (void)setArtist:(NSString *)arg1;
- (void)setAlbum:(NSString *)arg1;

- (void)setArtworkImage:(UIImage *)arg1 animated:(BOOL)arg2;
- (void)setArtworkImage:(UIImage *)arg1;

@end

@interface _MusicSongListTableViewCell : UIView
{
}

- (id)songListCellContentView;

@end



#include <logos/logos.h>
#include <substrate.h>
@class _MusicSongListTableViewCell; @class MPUTableViewController; @class _MusicSongListTableViewCellContentView; 
static void _logos_method$_ungrouped$_MusicSongListTableViewCellContentView$updateSWRatings(_MusicSongListTableViewCellContentView*, SEL); static void _logos_method$_ungrouped$_MusicSongListTableViewCellContentView$resetSWRatings(_MusicSongListTableViewCellContentView*, SEL); static void (*_logos_orig$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews)(_MusicSongListTableViewCellContentView*, SEL); static void _logos_method$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews(_MusicSongListTableViewCellContentView*, SEL); static void (*_logos_orig$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$)(MPUTableViewController*, SEL, id, id, id); static void _logos_method$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$(MPUTableViewController*, SEL, id, id, id); 
static __inline__ __attribute__((always_inline)) Class _logos_static_class_lookup$_MusicSongListTableViewCell(void) { static Class _klass; if(!_klass) { _klass = objc_getClass("_MusicSongListTableViewCell"); } return _klass; }
#line 126 "/Users/patsluth/Work/iOS/i-see-stars/SWISeeStars/SWISeeStars.xm"




static void _logos_method$_ungrouped$_MusicSongListTableViewCellContentView$updateSWRatings(_MusicSongListTableViewCellContentView* self, SEL _cmd) {
    SWISSRatingControl *ratingControl;
    
    for (UIView *view in self.subviews)
    {
        if ([view isKindOfClass:[SWISSRatingControl class]]){
            ratingControl = (SWISSRatingControl *)view;
        }
    }
    
    if (!ratingControl){
        
        ratingControl = [[SWISSRatingControl alloc] initWithFrame:CGRectMake(2, 4, 12, 50)];
        [self addSubview:ratingControl];
    }

    MPMediaQuery *query = [[MPMediaQuery alloc] init];

    if ([self title]){
         MPMediaPropertyPredicate *titlePredicate = [MPMediaPropertyPredicate predicateWithValue:[self title] forProperty:MPMediaItemPropertyTitle];
         [query addFilterPredicate: titlePredicate];
    }
    
    if ([self artist] && [[self artist] rangeOfString:@"Unknown"].location == NSNotFound){
         MPMediaPropertyPredicate *artistPredicate = [MPMediaPropertyPredicate predicateWithValue:[self artist] forProperty:MPMediaItemPropertyArtist];
         [query addFilterPredicate: artistPredicate];
    }
    
    if ([self album] && [[self album] rangeOfString:@"Unknown"].location == NSNotFound){
         MPMediaPropertyPredicate *albumPredicate = [MPMediaPropertyPredicate predicateWithValue:[self album] forProperty:MPMediaItemPropertyAlbumTitle];
         [query addFilterPredicate: albumPredicate];
    }

    NSArray *songs = [query items];
    
    if (songs.count > 0){
        NSNumber *rating = [songs[0] valueForProperty:MPMediaItemPropertyRating];
        ratingControl.rating = [rating integerValue];
    } else {
        [self resetSWRatings];
    }
}



static void _logos_method$_ungrouped$_MusicSongListTableViewCellContentView$resetSWRatings(_MusicSongListTableViewCellContentView* self, SEL _cmd) {
    return;
    
    
    SWISSRatingControl *ratingControl;

    for (UIView *view in self.subviews){
        if ([view isKindOfClass:[SWISSRatingControl class]]){
            ratingControl = (SWISSRatingControl *)view;
        }
    }
    
    if (ratingControl){
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
    
    if ([arg2 isKindOfClass:_logos_static_class_lookup$_MusicSongListTableViewCell()]){
        
        _MusicSongListTableViewCell *cell = (_MusicSongListTableViewCell *)arg2;
        
        if (cell){
            _MusicSongListTableViewCellContentView *content = (_MusicSongListTableViewCellContentView *)[cell
                                                                                                         songListCellContentView];
            
            if (content){
                [content updateSWRatings];
            }
        }
    }
}






static __attribute__((constructor)) void _logosLocalInit() {
{Class _logos_class$_ungrouped$_MusicSongListTableViewCellContentView = objc_getClass("_MusicSongListTableViewCellContentView"); { char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$_MusicSongListTableViewCellContentView, @selector(updateSWRatings), (IMP)&_logos_method$_ungrouped$_MusicSongListTableViewCellContentView$updateSWRatings, _typeEncoding); }{ char _typeEncoding[1024]; unsigned int i = 0; _typeEncoding[i] = 'v'; i += 1; _typeEncoding[i] = '@'; i += 1; _typeEncoding[i] = ':'; i += 1; _typeEncoding[i] = '\0'; class_addMethod(_logos_class$_ungrouped$_MusicSongListTableViewCellContentView, @selector(resetSWRatings), (IMP)&_logos_method$_ungrouped$_MusicSongListTableViewCellContentView$resetSWRatings, _typeEncoding); }MSHookMessageEx(_logos_class$_ungrouped$_MusicSongListTableViewCellContentView, @selector(layoutSubviews), (IMP)&_logos_method$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews, (IMP*)&_logos_orig$_ungrouped$_MusicSongListTableViewCellContentView$layoutSubviews);Class _logos_class$_ungrouped$MPUTableViewController = objc_getClass("MPUTableViewController"); MSHookMessageEx(_logos_class$_ungrouped$MPUTableViewController, @selector(tableView:willDisplayCell:forRowAtIndexPath:), (IMP)&_logos_method$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$, (IMP*)&_logos_orig$_ungrouped$MPUTableViewController$tableView$willDisplayCell$forRowAtIndexPath$);} }
#line 257 "/Users/patsluth/Work/iOS/i-see-stars/SWISeeStars/SWISeeStars.xm"
