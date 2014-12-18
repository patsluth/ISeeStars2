
#import "SWISeeStarsPrefsBridge.h"
#import "SWISSRatingControl.h"

#import <libsw/sluthwareios/sluthwareios.h>

#import "SWISSPrivateHeaders.h"





%hook MusicTableViewCellContentView

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
        ratingControl = [[SWISSRatingControl alloc] initWithFrame:CGRectMake(2, 4, 12, self.frame.size.height - 8)]; //4 padding
        [self addSubview:ratingControl];
    }
    
    UIImageRenderingMode renderingMode = [[SWISeeStarsPrefsBridge preferences][@"tintcolor_enabled"] boolValue] ? UIImageRenderingModeAlwaysTemplate : UIImageRenderingModeAlwaysOriginal;
    
    [ratingControl updateRenderingMode:renderingMode];
    
    if (mediaItem){
        NSNumber *rating = [mediaItem valueForProperty:MPMediaItemPropertyRating];
        ratingControl.rating = [rating integerValue];
    } else {
        ratingControl.rating = 0;
    }
}

%new
- (void)postLayoutSubviews
{
    //move artwork over
    UIView *artwork;
    
    if ([self respondsToSelector:@selector(artworkImageView)]){
        artwork = [self artworkImageView];
    } else if ([self respondsToSelector:@selector(artworkView)]){
        artwork = [self artworkView];
    }
    
    if (!artwork){
        return;
    }
    
    [artwork setOriginX:artwork.frame.origin.x + 14];
    
    
    
    
    
    UIView *primaryLabel;
    
    if ([self respondsToSelector:@selector(titleLabel)]){
        primaryLabel = [self titleLabel];
    }
    
    if (primaryLabel){
        [primaryLabel setOriginX:primaryLabel.frame.origin.x + 14];
    }
    
    
    
    
    
    UIView *secondaryLabel;
    
    if ([self respondsToSelector:@selector(artistLabel)]){
        secondaryLabel = [self artistLabel];
    } else if ([self respondsToSelector:@selector(subtitleLabel)]){
        secondaryLabel = [self subtitleLabel];
    }
    
    if (secondaryLabel){
        [secondaryLabel setOriginX:secondaryLabel.frame.origin.x + 14];
    }
    
    
    
    
    
    UIView *thirdaryLabel; //is thirdary a word?
    
    if ([self respondsToSelector:@selector(albumLabel)]){
        thirdaryLabel = [self albumLabel];
    } else if ([self respondsToSelector:@selector(detailLabel)]){
        thirdaryLabel = [self detailLabel];
    }
    
    if (thirdaryLabel){
        [thirdaryLabel setOriginX:thirdaryLabel.frame.origin.x + 14];
    }
}

%end

%hook _MusicSongListTableViewCellContentView

- (void)layoutSubviews
{
    %orig();
    
    if ([self respondsToSelector:@selector(postLayoutSubviews)]){
        [self postLayoutSubviews];
    }
}

%end

%hook MusicSongListTableViewCellContentView

- (void)layoutSubviews
{
    %orig();
    
    if ([self respondsToSelector:@selector(postLayoutSubviews)]){
        [self postLayoutSubviews];
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
    
    if (mediaItem && [mediaItem isKindOfClass:%c(MPConcreteMediaItem)]){ //only show for media items silly willy
        
        id musicCellContentView;
        
        if ([arg2 respondsToSelector:@selector(songCellContentView)]){ //iOS 7
            musicCellContentView = [arg2 songCellContentView];
        } else if ([arg2 respondsToSelector:@selector(_mediaCellContentView)]){ //iOS 8
            musicCellContentView = [arg2 _mediaCellContentView];
        }
        
        if (musicCellContentView && [musicCellContentView respondsToSelector:@selector(updateWithMediaItem:)]){
            
            [musicCellContentView performSelectorOnMainThread:@selector(updateWithMediaItem:) withObject:mediaItem waitUntilDone:NO];
            
            [musicCellContentView performSelectorOnMainThread:@selector(setTintColor:) withObject:self.navigationController.navigationBar.tintColor waitUntilDone:NO];
            [musicCellContentView layoutSubviews];
        }
    }
}

%end

%ctor
{
}




