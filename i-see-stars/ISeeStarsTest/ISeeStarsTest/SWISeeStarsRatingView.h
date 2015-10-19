//
//  SWISeeStarsRatingView.h
//  ISeeStarsTest
//
//  Created by Pat Sluth on 2015-07-12.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import <UIKit/UIKit.h>





@interface SWISeeStarsRatingView : UIView

- (id)initWithDotsImage:(UIImage *)dotsImage andStarsImage:(UIImage *)starsImage;

@property (nonatomic) NSInteger rating;

@end




