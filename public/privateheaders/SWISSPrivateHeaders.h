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
