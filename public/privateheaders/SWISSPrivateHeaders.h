//
//  SWISeeStars.h
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-07-15.
//
//

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

#pragma mark TableView Cells
 

//base cell for displaying individual songs
@interface MusicSongTableViewCell : UIView
{
}

- (id)songCellContentView;

@end

//cell shown in artist and album tabs
@interface MusicCollectionTrackTableViewCell : MusicSongTableViewCell
{
}

@end

//cell shown in song and playlist tab
@interface _MusicSongListTableViewCell : MusicSongTableViewCell
{
}

@end


@interface MusicTableViewCellContentView : UIView
{
}

@end


@interface MusicSongTableViewCellContentView : MusicTableViewCellContentView
{
}

//%new
- (void)updateWithMediaItem:(id)mediaItem;

@end


//content view for MusicCollectionTrackTableViewCell
@interface _MusicCollectionTrackTableViewCellContentView : MusicSongTableViewCellContentView
{
}

@end


//content view for _MusicSongListTableViewCell
@interface _MusicSongListTableViewCellContentView : MusicSongTableViewCellContentView
{
}

- (UILabel *)titleLabel;
- (UILabel *)artistLabel;
- (UILabel *)albumLabel;
- (UIImageView *)artworkImageView;

@end




