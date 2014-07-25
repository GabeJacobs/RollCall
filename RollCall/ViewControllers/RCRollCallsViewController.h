//
//  RCRollCallsViewController.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import <UIKit/UIKit.h>
#import "RCGroup.h"

@interface RCRollCallsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) RCGroup *group;

@end
