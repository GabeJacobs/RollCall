//
//  RCUser.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <CoreData/CoreData.h>

@interface RCUser : NSManagedObject

@property (nonatomic, strong) NSString* firstName;
@property (nonatomic, strong) NSString* lastName;
@property (nonatomic, strong) NSString* userID;

+ (RCUser*)loggedInUser;
+ (NSString*)userID;
+ (NSString*)firstName;
+ (NSString*)lastName;



@end
