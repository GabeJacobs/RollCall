//
//  RCContactTableViewCell.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import "RCContactTableViewCell.h"

#define X_PADDIING 10.0f
#define Y_PADDIING 10.0f

@implementation RCContactTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
		
		self.nameLabel = [[UILabel alloc] init];
		self.nameLabel.backgroundColor = [UIColor clearColor];
		self.nameLabel.font = [UIFont fontWithName:@"Avenir" size:17.0f];
		self.nameLabel.textColor = [UIColor blackColor];
		self.nameLabel.text = @"Name";
		[self addSubview:self.nameLabel];
		
		self.selectButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.selectButton setImage:[UIImage imageNamed:@"contactUnselected"] forState:UIControlStateNormal];
		[self.selectButton addTarget:self action:@selector(contactTouched) forControlEvents:UIControlEventTouchUpInside];
		[self.contentView addSubview:self.selectButton];

		
    }
    return self;
}

- (void)layoutSubviews {
	self.nameLabel.frame = CGRectMake(13, 0, 100, 30);
	[self.nameLabel sizeToFit];
	self.nameLabel.frame = CGRectMake(13, self.contentView.frame.size.height/2 - self.nameLabel.frame.size.height/2, self.nameLabel.frame.size.width, self.nameLabel.frame.size.height);
	
	self.selectButton.frame = CGRectMake(CGRectGetMaxX(self.contentView.frame) - 40, 0, 27, 27);
	self.selectButton.center = CGPointMake(self.selectButton.center.x, self.contentView.center.y);
	
	
}

-(void)populateWithContact:(ABRecordRef)contact{
	
	self.contact = contact;
	
	NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonFirstNameProperty));
	NSString *lastName = (__bridge NSString *)(ABRecordCopyValue(contact, kABPersonLastNameProperty));
	
	if(lastName == nil){
		lastName = @"";
	}
	self.nameLabel.text = [NSString  stringWithFormat:@"%@ %@", firstName, lastName];
	[self layoutIfNeeded];

}


-(void)contactTouched{
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"TappedContact"
	 object:self];
	
}

-(void)changeContactButton{
	
	if(self.contactSelected){
		[self.selectButton setImage:[UIImage imageNamed:@"contactUnselected"] forState:UIControlStateNormal];
		self.contactSelected = NO;
	}
	else{
		[self.selectButton setImage:[UIImage imageNamed:@"ContactSelected"] forState:UIControlStateNormal];
		self.contactSelected = YES;
	}
}


- (void)addDataToCell:(NSDictionary *)data {
	// REPLACE PLACEHOLDERS
}


@end
