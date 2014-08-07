//
//  RCPreviewCollectionCell.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import "RCPreviewCollectionCell.h"

@implementation RCPreviewCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.previewImageView = [[UIImageView alloc] init];
		[self addSubview:self.previewImageView];
    }
    return self;
}

- (void)layoutSubviews{
	
	self.previewImageView.frame = self.bounds;
	
}

- (void)gotImageForCurrentURL:(UIImage *)image {
    self.previewImageView.image = image;
}

+ (UIImage*)randomImage {
	int rando = rand();
	rando %= 3;
	rando += 1;
	NSString * fakeImage = [NSString stringWithFormat:@"Placeholder%d.png", rando];
    return [UIImage imageNamed:fakeImage];
}

@end
