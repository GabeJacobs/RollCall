//
//  RCUser.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCRecord.h"

@interface RCUser : RCRecord

// Attributes.
@property (nonatomic) NSString* avatar;
@property (nonatomic) NSString* firstName;
@property (nonatomic) NSString* lastName;
@property (nonatomic) NSDate* joined;
@property (nonatomic) NSDate* lastActive;
@property (nonatomic) NSString* userID;
@property (nonatomic) NSString* phoneNumber;

// Relationships.
@property (nonatomic) NSMutableSet* groups;
@property (nonatomic) NSMutableSet* likes;
@property (nonatomic) NSMutableSet* rollCalls;
@property (nonatomic) NSMutableSet* selfies;

@end
