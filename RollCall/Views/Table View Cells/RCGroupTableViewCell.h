//
//  RCGroupTableViewCell.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import <UIKit/UIKit.h>

@class RCGroup;

@interface RCGroupTableViewCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UILabel			*groupName;
@property (nonatomic) UICollectionView	*avatarsCollectionView;
@property (nonatomic) UIView			*seperator;
@property (nonatomic) UIButton			*startCallButton;

- (void)setupCellWithGroup:(RCGroup*)group;

@end
