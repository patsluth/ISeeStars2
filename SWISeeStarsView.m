//
//  SWISeeStarsView.m
//  ISeeStars2
//
//  Created by Pat Sluth on 2016-04-23.
//
//

#import "SWISeeStarsView.h"





@interface SWISeeStarsView()
{
}

@end





@implementation SWISeeStarsView

- (void)awakeFromNib
{
	[super awakeFromNib];
	
	self.tag = 696969;
	self.translatesAutoresizingMaskIntoConstraints = NO;
	
	self.rating = 0;
	self.likedStatus = 0;
}

- (void)setRating:(NSInteger)rating
{
	_rating = MAX(0, MIN(5, rating));
	
	for (NSUInteger x = 0; x < self.imageViewCollection.count; x++) {
		
		UIImageView *imageView = [self.imageViewCollection objectAtIndex:x];
		
		if (x >= _rating) {
			
			imageView.image = self.dotImage;
			
		} else {
			
			if (self.likedStatus == 2) { // 2 = isLiked
				imageView.image = self.heartImage;
			} else {
				imageView.image = self.starImage;
			}
			
		}
		
	}
}

- (void)setLikedStatus:(NSInteger)likedStatus
{
	_likedStatus = likedStatus;
	
	if (_likedStatus == 2) { // 2 = isLiked
		
		if (self.rating <= 0) { // Force show a single heart
			self.rating = 1;
			return;
		}
	}
	
	self.rating = self.rating; // Update views
	
}

@end




