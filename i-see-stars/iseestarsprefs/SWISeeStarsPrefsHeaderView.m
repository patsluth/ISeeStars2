
#import "SWISeeStarsPrefsHeaderView.h"

#import <libsw/sluthwareios/sluthwareios.h>

@interface SWISeeStarsPrefsHeaderView()
{
}

@property (strong, nonatomic) UIImageView *iseestarsImage;
@property (strong, nonatomic) UILabel *iseestarsText;

@end





@implementation SWISeeStarsPrefsHeaderView

- (id)initWithImage:(UIImage *)image
{
	self = [super initWithImage:image];
	
	if (self){
	
		self.contentMode = UIViewContentModeScaleToFill;
		
		NSBundle *bundle = [NSBundle bundleWithPath:@"/Library/PreferenceBundles/ISeeStarsPrefs.bundle"];
    
		if (bundle){
    		self.iseestarsImage = [[UIImageView alloc] initWithImage:[UIImage
    																imageWithContentsOfFile:[bundle
    																pathForResource:@"I_See_Stars_Prefs_Banner_Image" ofType:@"png"]]];
    		self.iseestarsImage.contentMode = UIViewContentModeScaleAspectFit;
    		[self addSubview:self.iseestarsImage];
    	}
	
		self.iseestarsText = [[UILabel alloc] init];
		self.iseestarsText.text = @"I See Stars";
		self.iseestarsText.textColor = [UIColor whiteColor];
		
		[self addSubview:self.iseestarsText];
	}
	
	return self;
}

- (void)setFrame:(CGRect)frame
{
	[super setFrame:frame];
	
	[self.iseestarsImage setSize:CGSizeMake(self.frame.size.height / 1.5, self.frame.size.height / 3)];
	[self.iseestarsImage setCenterX:self.frame.size.width / 2];
	
	//stretch our views
	self.iseestarsText.font = [UIFont systemFontOfSize:self.frame.size.height / 5];
	[self.iseestarsText sizeToFit];
	[self.iseestarsText setOriginY:self.frame.size.height - self.iseestarsText.frame.size.height - 10];
	[self.iseestarsText setCenterX:self.frame.size.width / 2];
	
	[self.iseestarsImage setOriginY:self.iseestarsText.frame.origin.y - self.iseestarsText.frame.size.height - 15];
}

@end









