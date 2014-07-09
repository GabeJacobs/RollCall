//
//  RCUser.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCUser.h"

@implementation RCUser

@dynamic fbUserId;
@dynamic lastName;
@dynamic firstName;


+ (NSString*)fbUserId {
    return [[RCUser loggedInUser] fbUserId];
}

+ (NSString*)firstName {
    return [[RCUser loggedInUser] firstName];
}

+ (NSString*)lastName {
    return [[RCUser loggedInUser] lastName];
}


@end
