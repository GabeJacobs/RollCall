//
//  RCNewRollCallViewController.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/24/14.
//
//

#import <UIKit/UIKit.h>
#import "RCGroup.h"

@interface RCNewRollCallViewController : UIViewController

-(void)loadDataForGroup:(RCGroup*)group;
@property (nonatomic) RCGroup *group;

@end
