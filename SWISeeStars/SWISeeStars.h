//
//  SWISeeStars.h
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-07-15.
//
//

#ifndef SWISeeStars_SWISeeStars_h
#define SWISeeStars_SWISeeStars_h
#endif

#import <MediaPlayer/MediaPlayer.h>

#pragma mark MPDataSource

@interface MPUDataSource : NSObject <NSCoding>
{
    
	int _entityType;
}

@property (nonatomic,readonly) int entityType;

@end



@interface MPUQueryDataSource : MPUDataSource
{
	NSArray *_entities;
    
}

- (NSArray *)entities; //MPConcreteMediaItems array

@end

#pragma mark Table View


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

- (id)initWithFrame:(CGRect)arg1;

@end
 

@interface MusicSongTableViewCellContentView : MusicTableViewCellContentView
{
    
}

@end


@interface _MusicSongListTableViewCellContentView : MusicSongTableViewCellContentView
{
}

//new
- (void)updateWithMediaItem:(id)mediaItem;

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


