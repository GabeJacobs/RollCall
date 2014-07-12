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

-(void)layoutSubviews{
	
	self.previewImageView.frame = self.bounds;
	
}

-(void)addDataToCell{
	int rando = rand();
	rando %= 3;
	rando += 1;
	NSString * fakeImage = [NSString stringWithFormat:@"Placeholder%d.png", rando];
	[self.previewImageView setImage:[UIImage imageNamed:fakeImage]];
	
}

@end
