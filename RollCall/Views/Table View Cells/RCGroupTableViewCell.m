//
//  RCGroupTableViewCell.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import "RCGroupTableViewCell.h"
#import "RCGroupPreviewCollectionViewCell.h"

#define X_PADDIING 10.0f
#define Y_PADDIING 10.0f

@implementation RCGroupTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
        self.groupName = [[UILabel alloc] init];
		self.groupName.font = [UIFont fontWithName:@"Avenir-Book" size:16.0];
		self.groupName.textAlignment = NSTextAlignmentCenter;
		self.groupName.text = @"Roll Call iOS Dev Team";
		self.groupName.textColor = RC_DARKER_GRAY;
		[self addSubview:self.groupName];
		
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		[flowLayout setItemSize:CGSizeMake(200, 200)];
		[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
		
		self.previewCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		[self.previewCollectionView registerClass:[RCGroupPreviewCollectionViewCell class] forCellWithReuseIdentifier:@"previewCell"];

		self.previewCollectionView.delegate = self;
		self.previewCollectionView.dataSource = self;
		[self addSubview:self.previewCollectionView];
		self.previewCollectionView.backgroundColor = RC_BACKGROUND_GRAY;
		
		self.seperator = [[UIView alloc] init];
		self.seperator.backgroundColor = RC_DARKER_GRAY;
		[self addSubview:self.seperator];
    }
    return self;
}

-(void)layoutSubviews
{
	self.groupName.frame = CGRectMake(X_PADDIING, Y_PADDIING, self.contentView.frame.size.width - (X_PADDIING * 2), 30);
	self.previewCollectionView.frame = CGRectMake(X_PADDIING, Y_PADDIING + CGRectGetMaxY(self.groupName.frame), self.frame.size.width - (X_PADDIING * 2), 100);
	self.seperator.frame = CGRectMake(X_PADDIING*2 , self.frame.size.height - 1 , self.frame.size.width - (X_PADDIING * 4), 1);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addDataToCell:(NSDictionary *)data {
	// REPLACE PLACEHOLDERS
}

//****************************************
//****************************************
#pragma mark - UICollectionView Datasource/Delegate
//****************************************
//****************************************

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *cellIdentifier = @"previewCell";
	
    RCGroupPreviewCollectionViewCell *cell = (RCGroupPreviewCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	
	[cell addDataToCell];
    return cell;
	
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(70, 100);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	
	return 1;
}

@end
