//
//  RCGroupTableViewCell.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import "RCGroupTableViewCell.h"

#import "RCGroup.h"

#define X_PADDIING 10.0f
#define Y_PADDIING 10.0f

@implementation RCGroupTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.groupName = [[UILabel alloc] init];
		self.groupName.font = [UIFont fontWithName:@"Avenir-Heavy" size:20.0];
		self.groupName.textAlignment = NSTextAlignmentCenter;
		self.groupName.text = @"Roll Call iOS Dev Team";
		self.groupName.textColor = RC_DARKER_GRAY;
		[self addSubview:self.groupName];
		

		self.seperator = [[UIView alloc] init];
		self.seperator.backgroundColor = RC_DARKER_GRAY;
		[self addSubview:self.seperator];
		
		self.horizontalSeperator = [[UIView alloc] init];
		self.horizontalSeperator.backgroundColor = RC_DARKER_GRAY;
		[self addSubview:self.horizontalSeperator];
		
		self.clockIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Clock"]];
		[self addSubview:self.clockIcon];
		
		self.timeLabel = [[UILabel alloc] init];
		self.timeLabel.font = [UIFont fontWithName:@"Avenir" size:15.0];
		self.timeLabel.text = @"24 mins left";
		self.timeLabel.textColor = RC_DARKER_GRAY;
		[self addSubview:self.timeLabel];
		
		self.startCallButton = [UIButton buttonWithType:UIButtonTypeCustom];
		UIImage *startCallImage = [UIImage imageNamed:@"StartRollCall"];
		[self.startCallButton setImage:startCallImage forState:UIControlStateNormal];
		self.startCallButton.frame = CGRectMake(0, 0, startCallImage.size.width, startCallImage.size.height);
		[self.startCallButton addTarget:self action:@selector(startRollCall) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.startCallButton];
		self.startCallButton.hidden = YES;
		
		self.replyButton = [UIButton buttonWithType:UIButtonTypeCustom];
		UIImage *replyImage = [UIImage imageNamed:@"ReplyButton"];
		[self.replyButton setImage:replyImage forState:UIControlStateNormal];
		self.replyButton.frame = CGRectMake(0, 0, replyImage.size.width, replyImage.size.height);
		[self addSubview:self.replyButton];
		self.replyButton.hidden = YES;
		
		
    }
    return self;
}

- (void)layoutSubviews {
	self.groupName.frame = CGRectMake(X_PADDIING, Y_PADDIING, self.contentView.frame.size.width - (X_PADDIING * 2), 30);
	[self.groupName sizeToFit];
	
	self.clockIcon.frame = CGRectMake(X_PADDIING, CGRectGetMaxY(self.groupName.frame) + Y_PADDIING, 15, 15);
	self.seperator.frame = CGRectMake(0 , self.frame.size.height - 1 , self.frame.size.width, 1);
	self.timeLabel.frame = CGRectMake(CGRectGetMaxX(self.clockIcon.frame) + X_PADDIING, self.clockIcon.frame.origin.y, 100, self.clockIcon.frame.size.height);
	[self.timeLabel sizeToFit];
	self.timeLabel.center = CGPointMake(self.timeLabel.center.x, self.clockIcon.center.y);
	
	self.startCallButton.frame = CGRectMake(CGRectGetMaxX(self.frame) - X_PADDIING*1.5 - self.startCallButton.frame.size.width + 5, self.frame.size.height/2 - self.startCallButton.frame.size.height/2, self.startCallButton.frame.size.width, self.startCallButton.frame.size.height);
	
	self.replyButton.frame = CGRectMake(CGRectGetMaxX(self.frame) - X_PADDIING*1.5 - self.replyButton.frame.size.width + 5, self.frame.size.height/2 - self.replyButton.frame.size.height/2, self.replyButton.frame.size.width, self.replyButton.frame.size.height);
	self.replyButton.center = CGPointMake(self.startCallButton.center.x, self.replyButton.center.y);

	
	self.horizontalSeperator.frame = CGRectMake( CGRectGetMinX(self.startCallButton.frame) - X_PADDIING*2, 0, 1, self.frame.size.height - Y_PADDIING *2 - 10);
	self.horizontalSeperator.center = CGPointMake(self.horizontalSeperator.center.x, self.startCallButton.center.y);
	
	
	
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)addDataToCell:(NSDictionary *)data {
	// REPLACE PLACEHOLDERS
}

- (void)setupCellWithGroup:(RCGroup*)group {
    self.groupName.text = group.name;
	if([group.name isEqual:@"Roll Call"]){
		self.replyButton.hidden = NO;
	}
	else{
		self.startCallButton.hidden = NO;
	}
}

//****************************************
//****************************************
#pragma mark - Gestures
//****************************************
//****************************************

-(void)tappedAvatars{
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"TappedAvatar"
	 object:self];
}

-(void)startRollCall {
	
}

@end
