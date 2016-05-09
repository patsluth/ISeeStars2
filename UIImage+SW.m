//
//  UIImage+SW.m
//  ISeeStars2
//
//  Created by Pat Sluth on 2016-05-08.
//
//

#import "UIImage+SW.h"





@implementation UIImage(SW)

- (UIImage *)resizeImage:(CGSize)newSize
{
	CGRect newRect = CGRectIntegral(CGRectMake(0.0, 0.0, newSize.width, newSize.height));
	CGImageRef imageRef = self.CGImage;
	
	UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	
	// Set the quality level to use when rescaling
	CGContextSetInterpolationQuality(context, kCGInterpolationHigh);
	CGAffineTransform flipVertical = CGAffineTransformMake(1.0, 0.0, 0.0, -1.0, 0.0, newSize.height);
	
	CGContextConcatCTM(context, flipVertical);
	// Draw into the context; this scales the image
	CGContextDrawImage(context, newRect, imageRef);
	
	// Get the resized image from the context and a UIImage
	CGImageRef newImageRef = CGBitmapContextCreateImage(context);
	UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
	
	CGImageRelease(newImageRef);
	UIGraphicsEndImageContext();
	
	return newImage;
}

@end




