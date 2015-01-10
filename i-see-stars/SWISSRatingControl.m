
#import "SWISSRatingControl.h"

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
        
        NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/Application Support/ISeeStarsSupport.bundle"];
        
        if (bundle){
            
            UIImage *star = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"SW_ISS_Star" ofType:@"png"]];
            UIImage *dot = [UIImage imageWithContentsOfFile:[bundle pathForResource:@"SW_ISS_Circle" ofType:@"png"]];
            
            NSMutableArray *tempStars = [[NSMutableArray alloc] init];
            NSMutableArray *tempDots = [[NSMutableArray alloc] init];
            
            for (NSInteger x = 0; x < 5; x++){
                
                UIImageView *starImage = [[UIImageView alloc] initWithImage:star];
                UIImageView *dotImage = [[UIImageView alloc] initWithImage:dot];
                
                starImage.contentMode = UIViewContentModeScaleAspectFit;
                dotImage.contentMode = UIViewContentModeScaleAspectFit;
                
                starImage.frame = CGRectMake(0,
                                             (self.frame.size.height / 5) * x,
                                             self.frame.size.width,
                                             self.frame.size.height / 5);
                
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

- (void)updateRenderingMode:(UIImageRenderingMode)renderingMode
{
    for (NSInteger x = 0; x < 5; x++){
        
        UIImageView *starImage = (UIImageView *)self.stars[x];
        UIImageView *dotImage = (UIImageView *)self.dots[x];
        
        if (starImage.image.renderingMode != renderingMode){
            starImage.image = [starImage.image imageWithRenderingMode:renderingMode];
        }
        
        if (dotImage.image.renderingMode != renderingMode){
            dotImage.image = [dotImage.image imageWithRenderingMode:renderingMode];
        }
        
    }
}

@end



