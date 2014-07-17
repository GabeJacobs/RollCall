//
//  RCThumbnailCollectionCell.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/16/14.
//
//

#import "RCThumbnailCollectionCell.h"

@implementation RCThumbnailCollectionCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
		self.previewImageView = [[UIImageView alloc] init];
		[self addSubview:self.previewImageView];
		
		self.blackLayer = [[UIView alloc] init];
		self.blackLayer.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.5];
		[self addSubview:self.blackLayer];
    }
    return self;
}

-(void)layoutSubviews{
	
	self.previewImageView.frame = self.bounds;
	self.blackLayer.frame = self.bounds;

}

-(void)addDataToCell{
	int rando = rand();
	rando %= 3;
	rando += 1;
	NSString * fakeImage = [NSString stringWithFormat:@"Placeholder%d.png", rando];
	[self.previewImageView setImage:[UIImage imageNamed:fakeImage]];
	
}

-(void)hideBlackLayer{
	self.blackLayer.hidden = YES;
}

-(void)unhideBlackLayer{
	self.blackLayer.hidden = NO;
}

@end
