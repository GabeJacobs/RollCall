//
//  RCContactTableViewCell.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/23/14.
//
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>

@interface RCContactTableViewCell : UITableViewCell

@property (nonatomic) UILabel *nameLabel;
@property (nonatomic) UIButton *selectButton;
@property (nonatomic) BOOL	contactSelected;
@property (nonatomic) ABRecordRef contact;

-(void)populateWithContact:(ABRecordRef)contact;
-(void)changeContactButton;

@end
