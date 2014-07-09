//
//  RCSession.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RCUser.h"

@interface RCSession : NSObject

+ (void)startSessionWithUserID:(NSString*)userID;
+ (RCUser*)currentUser;

@end
