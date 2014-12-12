
#import <MediaPlayer/MediaPlayer.h>

#pragma mark MPDataSource

@interface MPUDataSource : NSObject <NSCoding>
{
}

@end

@interface MPUQueryDataSource : MPUDataSource
{
	NSArray *_entities;
}

- (NSArray *)entities; //MPConcreteMediaItems array

@end

#pragma mark TableView

@interface MPUTableViewController
{
    MPUQueryDataSource *_queryDataSource;
}

@property (nonatomic, retain) MPUQueryDataSource *queryDataSource;

- (void)tableView:(id)arg1 willDisplayCell:(id)arg2 forRowAtIndexPath:(id)arg3;
- (int)dataSourceIndexForIndexPath:(id)arg1; //convert cell index path to index in queryDataSource.entities array

@end

@interface MusicTableViewCellContentView : UIView
{
}

//iOS 7 & 8
- (UIView *)titleLabel;

//iOS 7
- (UIView *)artistLabel;
- (UIView *)albumLabel;
- (UIView *)artworkImageView;
- (id)songCellContentView;

//iOS 8
- (UIView *)subtitleLabel;
- (UIView *)detailLabel;
- (UIView *)artworkView;
- (id)_mediaCellContentView;

- (void)updateWithMediaItem:(id)mediaItem;
- (void)postLayoutSubviews;

@end

@interface _MusicSongListTableViewCellContentView : MusicTableViewCellContentView //iOS 7
{
}

@end

@interface MusicSongListTableViewCellContentView : MusicTableViewCellContentView //iOS 8
{
}

@end




