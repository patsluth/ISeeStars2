//
//  SWISeeStars.xm
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-06-29.
//
//

#import "SWISSBundle.h"
#import "SWISSPrefs.h"
#import "SWISSRatingControl.h"
#import "SWISSPrivateHeaders.h"

%hook MusicSongTableViewCellContentView

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
        // _MusicSongListTableViewCellContentView size = CGSize(x, 58)
        //_MusicCollectionTrackTableViewCellContentView size = CGSize(x, 43.5)
        
        //8 padding on height
        //(43.5 - 8)/50 = 0.71
        //12 * 0.71 = 10.44
        
        if ([self isKindOfClass:%c(_MusicSongListTableViewCellContentView)]){
            ratingControl = [[SWISSRatingControl alloc] initWithFrame:CGRectMake(2, 4, 12, 50)];
        } else if ([self isKindOfClass:%c(_MusicCollectionTrackTableViewCellContentView)]){
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

%end

%hook _MusicSongListTableViewCellContentView

- (void)layoutSubviews
{
    %orig();
    
    //move artwork over
    UIImageView *artwork = [self artworkImageView];
    
    if (!artwork){
        return;
    }
    
    
    artwork.frame = CGRectMake(16,
                               artwork.frame.origin.y,
                               artwork.frame.size.width,
                               artwork.frame.size.height);
    
    //move title label over
    UILabel *title = [self titleLabel];
    title.frame = CGRectMake(artwork.frame.origin.x + artwork.frame.size.width + 2,
                             title.frame.origin.y,
                             title.frame.size.width,
                             title.frame.size.height);
    
    if (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad){
        //move artist label over
        UILabel *artist = [self artistLabel];
        artist.frame = CGRectMake(title.frame.origin.x,
                                  artist.frame.origin.y,
                                  artist.frame.size.width,
                                  artist.frame.size.height);
    }
}

%end


%hook MPUTableViewController

- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3
{
    %orig(arg1, arg2, arg3);
    
    
    //PREFS DISABLED FOR THIS VERSION
    //if (![[SWISSPrefs preferences][@"enabled"] boolValue]){
    //    return;
    //}
    
    int mediaItemIndex = [self dataSourceIndexForIndexPath:arg3];
    id mediaItem;
    
    if (mediaItemIndex >= 0 && mediaItemIndex < [self.queryDataSource entities].count){
        mediaItem = [[self.queryDataSource entities] objectAtIndex:mediaItemIndex];
    }
    
    if (mediaItem && [arg2 isKindOfClass:%c(MusicSongTableViewCell)]){
        
        MusicSongTableViewCell *cell = (MusicSongTableViewCell *)arg2;
        
        if (cell){
            
            id cellContentView = [cell songCellContentView];
            
            if (cellContentView && [cellContentView isKindOfClass:%c(MusicSongTableViewCellContentView)]){
                MusicSongTableViewCellContentView *content = (MusicSongTableViewCellContentView *)cellContentView;
                
                if (content){
                    [content updateWithMediaItem:mediaItem];
                }
            }
        }
    }
}

%end

%ctor
{
}




