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
@property (strong, nonatomic) UIImageView *hearts;

@end





@implementation SWISeeStarsRatingView

- (id)initWithDotsImage:(UIImage *)dotsImage andStarsImage:(UIImage *)starsImage andHeartsImage:(UIImage *)heartsImage;
{
    self = [super init];
    
    if (self) {
        
        self.translatesAutoresizingMaskIntoConstraints = NO;
        self.clipsToBounds = YES;
        self.tag = 696969;
        self.backgroundColor = [UIColor clearColor];
        
        
        self.dots = [[UIImageView alloc] initWithImage:[dotsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.dots.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.dots];
        
        
        self.stars = [[UIImageView alloc] initWithImage:[starsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.stars.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.stars];
        
        
        self.hearts = [[UIImageView alloc] initWithImage:[heartsImage imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate]];
        self.hearts.contentMode = UIViewContentModeScaleAspectFit;
        [self addSubview:self.hearts];
        
        
        self.rating = 0;
    }
    
    return self;
}

- (void)setRating:(NSInteger)rating
{
    if (rating < 0) rating = 0;
    if (rating > 5) rating = 5;
    
    _rating = rating;
    
    if (!CGRectIsEmpty(self.bounds)) {
        
        CGRect frame = self.bounds;
        self.dots.frame = frame;
        
        CGFloat singleStarOffset = -CGRectGetMaxY(frame) / 5.0; //the offset needed to hide 1 star
        CGFloat totalOffset = singleStarOffset * (CGFloat)(5 - _rating); //the offset needed to hide our rating
        frame.origin.y = totalOffset;
        
        self.stars.frame = frame;
        self.hearts.frame = frame;
        
    }
}

- (void)setLikedStatus:(NSInteger)likedStatus
{
    _likedStatus = likedStatus;
    
    if (_likedStatus == 2) { // is liked
        
        if (self.rating <= 0) {
            self.rating = 1; // force show a heart
        }
        
        self.stars.hidden = YES;
        self.hearts.hidden = NO;
        
    } else {
        self.stars.hidden = NO;
        self.hearts.hidden = YES;
    }
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.rating = self.rating;
}

@end




