//
//  SWISeeStars.xm
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-06-29.
//
//

#import "SWISeeStars.h"
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
    [post appendFormat:@"appVersion=%@", @"1.0-1"];
    
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
                           }];
}

%hook _MusicSongListTableViewCellContentView

%new
- (void)updateWithMediaItem:(id)mediaItem
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
    
    if (mediaItem){
        NSNumber *rating = [mediaItem valueForProperty:MPMediaItemPropertyRating];
        ratingControl.rating = [rating integerValue];
    } else {
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
    
    int mediaItemIndex = [self dataSourceIndexForIndexPath:arg3];
    id mediaItem;
    
    if (mediaItemIndex >= 0 && mediaItemIndex < [self.queryDataSource entities].count){
        mediaItem = [[self.queryDataSource entities] objectAtIndex:mediaItemIndex];
    }
    
    if (mediaItem && [arg2 isKindOfClass:%c(_MusicSongListTableViewCell)]){
        
        _MusicSongListTableViewCell *cell = (_MusicSongListTableViewCell *)arg2;
        
        if (cell){
            _MusicSongListTableViewCellContentView *content = (_MusicSongListTableViewCellContentView *)[cell
                                                                                                         songListCellContentView];
            
            if (content){
                [content updateWithMediaItem:mediaItem];
            }
        }
    }
}

%end




