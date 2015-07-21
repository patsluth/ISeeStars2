//
//  ViewController.m
//  ISeeStarsTest
//
//  Created by Pat Sluth on 2015-07-12.
//  Copyright (c) 2015 Pat Sluth. All rights reserved.
//

#import "ViewController.h"
#import "SWISeeStarsRatingView.h"

#import <MediaPlayer/MediaPlayer.h>

#import <objc/runtime.h>





@interface ViewController ()
{
}

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end





@implementation ViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    MPMediaItemPropertyAlbumTitle
    SWISeeStarsRatingView *rating;
    
    for (UIView *view in cell.subviews){
        if ([view isKindOfClass:[SWISeeStarsRatingView class]]){
            rating = (SWISeeStarsRatingView *)view;
            break;
        }
    }
    
    if (!rating){
        rating = [[SWISeeStarsRatingView alloc] initWithDotsImage:[UIImage imageNamed:@"Dots"]
                                                    andStarsImage:[UIImage imageNamed:@"Stars"]];
        
        [cell addSubview:rating];
        
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:rating
                                                         attribute:NSLayoutAttributeCenterY
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:cell
                                                         attribute:NSLayoutAttributeCenterY
                                                        multiplier:1.0
                                                          constant:0.0]];
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:rating
                                                         attribute:NSLayoutAttributeWidth
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0
                                                          constant:15]];
        [cell addConstraint:[NSLayoutConstraint constraintWithItem:rating
                                                         attribute:NSLayoutAttributeHeight
                                                         relatedBy:NSLayoutRelationEqual
                                                            toItem:nil
                                                         attribute:NSLayoutAttributeNotAnAttribute
                                                        multiplier:1.0
                                                          constant:cell.frame.size.height - 4]];
        [cell setNeedsLayout];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", (long)indexPath.row];
    rating.rating = indexPath.row;
    
    return cell;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

@end




