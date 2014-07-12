//
//  RCRollCallTableViewCell.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#define X_PADDIING 10.0f
#define Y_PADDIING 10.0f

#import "RCRollCallTableViewCell.h"

@implementation RCRollCallTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateOfCreationLabel = [[UILabel alloc] init];
		self.dateOfCreationLabel.font = [UIFont fontWithName:@"Avenir" size:14];
		self.dateOfCreationLabel.textColor = RC_DARKER_GRAY;
		self.dateOfCreationLabel.text = @"June 28th, 2014 - 3:45 PM";
		[self addSubview:self.dateOfCreationLabel];
		
		self.timeLeftLabel = [[UILabel alloc] init];
		self.timeLeftLabel.font = [UIFont fontWithName:@"Avenir" size:12];
		self.timeLeftLabel.textColor = RC_DARKER_GRAY;
		self.timeLeftLabel.text = @"24 Mins";
		self.timeLeftLabel.backgroundColor = [UIColor redColor];
		[self addSubview:self.timeLeftLabel];
		
		self.clockIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Clock"]];
		[self addSubview:self.clockIcon];
	
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
	
	self.dateOfCreationLabel.frame = CGRectMake(X_PADDIING, Y_PADDIING, self.bounds.size.width - 120, 25);
	self.clockIcon.frame = CGRectMake(CGRectGetMaxX(self.dateOfCreationLabel.frame) + 30, Y_PADDIING, self.clockIcon.frame.size.width, self.clockIcon.frame.size.height);
	self.clockIcon.center = CGPointMake(self.clockIcon.center.x, self.dateOfCreationLabel.center.y);
	self.timeLeftLabel.frame = CGRectMake(CGRectGetMaxX(self.clockIcon.frame) + 5, Y_PADDIING, 50, 20);

}


@end
