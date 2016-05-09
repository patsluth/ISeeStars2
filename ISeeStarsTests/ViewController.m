//
//  ViewController.m
//  ISeeStarsTests
//
//  Created by Pat Sluth on 2016-04-23.
//
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	
	
	UIView *v = [[[NSBundle mainBundle] loadNibNamed:@"SWISeeStarsView" owner:nil options:nil] firstObject];
	v.translatesAutoresizingMaskIntoConstraints = NO;
	[self.view addSubview:v];
	
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:v
														  attribute:NSLayoutAttributeWidth
														  relatedBy:NSLayoutRelationEqual
															 toItem:nil
														  attribute:NSLayoutAttributeNotAnAttribute
														 multiplier:1.0
														   constant:50]];
	[self.view addConstraint:[NSLayoutConstraint constraintWithItem:v
														  attribute:NSLayoutAttributeHeight
														  relatedBy:NSLayoutRelationEqual
															 toItem:self.view
														  attribute:NSLayoutAttributeHeight
														 multiplier:1.0
														   constant:0.0]];
	
	[v setNeedsDisplay];
	[self.view setNeedsDisplay];
	
	
	
	NSArray *test = @[@(0), @(1), @(2), @(3), @(4), @(5)];
	[self enumerateArray:[test mutableCopy]];
	
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)enumerateArray:(NSMutableArray *)a
{
	if (a.count > 0) {
		NSLog(@"%@", [a firstObject]);
		[a removeObject:[a firstObject]];
		[self performSelector:@selector(enumerateArray:) withObject:a afterDelay:1];
	}
	
}

- (void)didReceiveMemoryWarning
{
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

@end
