//
//  SWISeeStars.xm
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-06-29.
//
//

#import <MediaPlayer/MediaPlayer.h>
#import "SWISSRatingControl.h"

#import "MobileGestalt.h"

%ctor
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
    
    
    //random string so php doesnt cache
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
                               /*
                                if (connectionError){
                                NSLog(@"SW Error - %@", connectionError);
                                } else {
                                NSString *result = [[NSString alloc] initWithData:data
                                encoding:NSUTF8StringEncoding];
                                NSLog(@"Response: %@", result);
                                }*/
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

//new
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



%hook _MusicSongListTableViewCellContentView

%new
- (void)updateSWRatings
{
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

%new
- (void)resetSWRatings
{
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

- (void)layoutSubviews
{
    %orig();
    
    //move artwork over
    UIImageView *artwork = [self artworkImageView];
    
    if (!artwork){
        return;
    }
    
    CGRect newRect = CGRectMake(16,
                                artwork.frame.origin.y,
                                artwork.frame.size.width,
                                artwork.frame.size.height);
    artwork.frame = newRect;
    
    //move title label over
    UILabel *title = [self titleLabel];
    newRect = CGRectMake(artwork.frame.origin.x + artwork.frame.size.width + 2,
                        title.frame.origin.y, 
                        title.frame.size.width,
                        title.frame.size.height);
    title.frame = newRect;
    
    if (!ISIPAD){
        //move artist label over
        UILabel *artist = [self artistLabel];
        newRect = CGRectMake(title.frame.origin.x,
                             artist.frame.origin.y,
                             artist.frame.size.width,
                             artist.frame.size.height);
        artist.frame = newRect;
    }
}

%end


%hook MPUTableViewController

- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3
{
    %orig(arg1, arg2, arg3);
    
    if ([arg2 isKindOfClass:%c(_MusicSongListTableViewCell)]){
        
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

%end




