//
//  SWISeeStarsRatingView.m
//  ISeeStarsTest
//
//  Created by Pat Sluth on 2015-07-12.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "SWISeeStarsRatingView.h"





@interface SWISeeStarsRatingView()
{
}

@property (strong, nonatomic) UIImageView *dots;
@property (strong, nonatomic) UIImageView *stars;

@end





@implementation SWISeeStarsRatingView

- (id)init
{
    self = [super init];
    
    if (self){
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.clipsToBounds = YES;
        self.backgroundColor = [UIColor clearColor];
        
        self.dots = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Dots"]];
        self.dots.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.dots];
        
        self.stars = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Stars"]];
        self.stars.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.stars];
        
        self.rating = 0;
    }
    
    return self;
}

- (void)setRating:(NSInteger)rating
{
    if (rating < 0) rating = 0;
    if (rating > 5) rating = 5;
    
    if (!CGRectIsEmpty(self.bounds)){
        
        CGRect starFrame = self.bounds;
        self.dots.frame = starFrame;
        
        CGFloat singleStarOffset = -CGRectGetMaxY(starFrame) / 5.0; //the offset needed to hide 1 star
        CGFloat totalOffset = singleStarOffset * (float)(5 - _rating); //the offset needed to hide our rating
        starFrame.origin.y = totalOffset;
        self.stars.frame = starFrame;
        
    }
    
    _rating = rating;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.rating = self.rating;
}

@end




