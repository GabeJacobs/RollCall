//
//  RCRollCallTableViewCell.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import <UIKit/UIKit.h>

@interface RCRollCallTableViewCell : UITableViewCell <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic) UILabel			*dateOfCreationLabel;
@property (nonatomic) UILabel			*timeLeftLabel;
@property (nonatomic) UICollectionView	*responsesCollectionView;
@property (nonatomic) UIView			*seperator;
@property (nonatomic) UILabel			*rollCallNameLabel;
@property (nonatomic) UIButton			*collageButton;
@property (nonatomic) UIButton			*mapButton;
@property (nonatomic) UIButton			*shareButton;
@property (nonatomic) UIImageView		*clockIcon;

@end
