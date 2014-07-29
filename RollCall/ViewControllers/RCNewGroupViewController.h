//
//  RCNewGroupViewController.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/14/14.
//
//

#import <UIKit/UIKit.h>
#import "RCGroup.h"

@protocol RCNewGroupDelegate <NSObject>
- (void)createdNewGroup:(RCGroup*)group;
@end

@interface RCNewGroupViewController : UIViewController <UITextFieldDelegate, UITableViewDataSource, UITableViewDelegate>
@property(nonatomic) id<RCNewGroupDelegate> delegate;
@end
