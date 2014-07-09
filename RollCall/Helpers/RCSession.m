//
//  RCSession.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCSession.h"

@interface RCSession ()

@property (nonatomic, strong) RCUser* sessionUser;

@end

@implementation RCSession


+ (RCSession*)currentSession {
    static RCSession* session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[RCSession alloc] init];
        //[session readDataFromDisk];
    });
    return session;
}

+ (RCUser*)currentUser{
		return [[RCSession currentSession] sessionUser];
}

+ (void)startSessionWithUserID:(NSString*)userID{
	RCSession* session = [RCSession currentSession];
	//[self currentUser].fbUserId

}




@end
