//
//  RCUser.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCRecord.h"

@interface RCUser : RCRecord

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* userID;
@property (nonatomic) NSDate* joined;
@property (nonatomic) NSDate* lastActive;
@property (nonatomic) NSString* avatar;
@property (nonatomic) NSString* phoneNumber;

@end
