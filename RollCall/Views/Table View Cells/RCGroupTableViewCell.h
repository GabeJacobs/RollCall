//
//  RCGroupTableViewCell.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import <UIKit/UIKit.h>

@class RCGroup;

@interface RCGroupTableViewCell : UITableViewCell

@property (nonatomic) UILabel			*groupName;
@property (nonatomic) UIView			*seperator;
@property (nonatomic) UIView			*horizontalSeperator;
@property (nonatomic) UIButton			*startCallButton;
@property (nonatomic) UIButton			*replyButton;
@property (nonatomic) UIImageView		*clockIcon;
@property (nonatomic) UILabel			*timeLabel;
@property (nonatomic) BOOL				hasCurrentCall;

- (void)setupCellWithGroup:(RCGroup*)group;

@end
