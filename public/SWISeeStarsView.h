//
//  SWISeeStarsView.h
//  ISeeStars2
//
//  Created by Pat Sluth on 2016-04-23.
//
//

@import Foundation;
@import UIKit;





@interface SWISeeStarsView : UIView
{
}

@property (strong, nonatomic) IBOutletCollection(UIImageView) NSArray *imageViewCollection;

@property (nonatomic) NSInteger rating;
@property (nonatomic) NSInteger likedStatus;

@property (strong, nonatomic) UIImage *dotImage;
@property (strong, nonatomic) UIImage *starImage;
@property (strong, nonatomic) UIImage *heartImage;

@end




