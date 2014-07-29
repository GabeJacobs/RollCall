//
//  RCNewRollCallViewController.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/24/14.
//
//

#import <UIKit/UIKit.h>
#import "RCGroup.h"

@interface RCNewRollCallViewController : UIViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate>

@property (nonatomic) RCGroup *group;

-(void)loadDataForGroup:(RCGroup*)group;

@end
