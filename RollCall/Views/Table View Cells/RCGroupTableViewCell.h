//
//  RCGroupTableViewCell.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import <UIKit/UIKit.h>

@interface RCGroupTableViewCell : UITableViewCell

@property (nonatomic) UILabel*			groupName;
@property (nonatomic) UICollectionView*	previewCollectionView;
@property (nonatomic) UIView*			seperator;

@end
