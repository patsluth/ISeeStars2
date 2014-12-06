
#import "MusicMediaTableViewCell.h"

#import "SWISSRatingControl.h"
#import <libsw/sluthwareios/sluthwareios.h>

@implementation SWISSMusicCellContentView

+ (void)updateView:(UIView *)view withMediaItem:(id)mediaItem
{
    SWISSRatingControl *ratingControl;
    
    for (UIView *v in view.subviews)
    {
        if ([v isKindOfClass:[SWISSRatingControl class]]){
            ratingControl = (SWISSRatingControl *)v;
        }
    }
    
    if (!ratingControl){
        ratingControl = [[SWISSRatingControl alloc] initWithFrame:CGRectMake(2, 4, 12, self.frame.size.height - 8)]; //4 padding
        [view addSubview:ratingControl];
    }
    
    if (mediaItem){
        NSNumber *rating = [mediaItem valueForProperty:MPMediaItemPropertyRating];
        ratingControl.rating = [rating integerValue];
    } else {
        ratingControl.rating = 0;
    }
}

@end




