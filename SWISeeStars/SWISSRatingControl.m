//
//  SWISSRatingControl.m
//  SWISeeStars
//
//  Created by Pat Sluth on 2014-06-29.
//
//

#import "SWISSRatingControl.h"
#import "SWBundle.h"

@interface SWISSRatingControl()
{
}

@property (strong, nonatomic) NSArray *stars;
@property (strong, nonatomic) NSArray *dots;

@end

@implementation SWISSRatingControl

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        UIImage *star = [SWBundle imageInMainBundleNamed:@"SW_ISS_Star" ofType:@"png"];
        UIImage *dot = [SWBundle imageInMainBundleNamed:@"SW_ISS_Circle" ofType:@"png"];
        
        NSMutableArray *tempStars = [[NSMutableArray alloc] init];
        NSMutableArray *tempDots = [[NSMutableArray alloc] init];
        
        for (NSInteger x = 0; x < 5; x++){
            
            UIImageView *starImage = [[UIImageView alloc] initWithImage:star];
            UIImageView *dotImage = [[UIImageView alloc] initWithImage:dot];
            
            starImage.frame = CGRectMake(0, star.size.height * x, star.size.width, star.size.height);
            starImage.center = CGPointMake(self.frame.size.width / 2, starImage.center.y);
            
            dotImage.frame = starImage.frame;
            
            //keep dots underneath stars
            [self addSubview:dotImage];
            [self addSubview:starImage];
            
            [tempDots addObject:dotImage];
            [tempStars addObject:starImage];
        }
        
        self.stars = tempStars;
        self.dots = tempDots;
        
        self.rating = 0;
    }
    return self;
}

- (void)setRating:(NSInteger)rating
{
    _rating = rating;
    
    for (NSInteger x = 0; x < 5; x++){
        
        UIImageView *starImage = (UIImageView *)self.stars[x];
        UIImageView *dotImage = (UIImageView *)self.dots[x];
        
        if (_rating > x){
            starImage.hidden = NO;
            dotImage.hidden = YES;
        } else {
            starImage.hidden = YES;
            dotImage.hidden = NO;
        }
    }
}

@end




