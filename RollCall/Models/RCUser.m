//
//  RCUser.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCUser.h"

@implementation RCUser

@dynamic userID;
@dynamic lastName;
@dynamic firstName;

// TODO(amadou): Actually implement this and move it to RCSession.
+ (RCUser *)loggedInUser {
    return nil;
}

+ (NSString*)userID {
    return [[RCUser loggedInUser] userID];
}

+ (NSString*)firstName {
    return [[RCUser loggedInUser] firstName];
}

+ (NSString*)lastName {
    return [[RCUser loggedInUser] lastName];
}


@end
