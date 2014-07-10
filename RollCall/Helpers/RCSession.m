//
//  RCSession.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCSession.h"

static NSString * const kUserDefaultsUserIDKey = @"UserDefaultsUserIDKey";
static NSString * const kUserDefaultsAccessTokenKey = @"UserDefaultsAccessTokenKey";
static NSString * const kUserDefaultsLoggedInKey = @"UserDefaultsLoggedInKey";

@interface RCSession ()
@property (nonatomic) RCUser *sessionUser;
@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic) BOOL loggedIn;
@end

@implementation RCSession

+ (RCSession*)currentSession {
    static RCSession* session = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        session = [[RCSession alloc] init];
        [session readDataFromDisk];
    });
    return session;
}

+ (void)startSessionWithAccessToken:(NSString*)accessToken user:(RCUser*)user {
    NSAssert(accessToken, @"+loginWithAccessToken - accessToken cannot be nil");
    NSAssert(user, @"+loginWithAccessToken - user cannot be nil");
    RCSession *session = [RCSession currentSession];
    session.sessionUser = user;
    session.accessToken = accessToken;
    session.loggedIn = YES;
    [session writeDataToDisk];
}

// Gets the relevant data from the disk.
- (void)readDataFromDisk {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    NSNumber *userID = [userDefaults objectForKey:kUserDefaultsUserIDKey];
    self.accessToken = [userDefaults stringForKey:kUserDefaultsAccessTokenKey];
    self.loggedIn = [userDefaults boolForKey:kUserDefaultsLoggedInKey];
    self.sessionUser = [RCSession fetchSessionUserWithID:userID];
    // If one of these things is not present clear everything.
    if (!self.sessionUser || !self.accessToken || !self.loggedIn) {
        [self endSession];
    }
}

// TODO(amadou): This should be encrypted - there is a github project for that.
- (void)writeDataToDisk {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:self.sessionUser.userID
                     forKey:kUserDefaultsUserIDKey];
    [userDefaults setObject:self.accessToken
                     forKey:kUserDefaultsAccessTokenKey];
    [userDefaults setBool:self.loggedIn forKey:kUserDefaultsLoggedInKey];
}

+ (void)storeSession {
    [[RCSession currentSession] writeDataToDisk];
}

+ (void)endSession {
    [[RCSession currentSession] endSession];
}

- (void)endSession {
    self.sessionUser = nil;
    self.accessToken = nil;
    self.loggedIn = NO;
    [self writeDataToDisk];
}

+ (RCUser*)currentUser{
    return [[RCSession currentSession] sessionUser];
}

+ (NSString*)accessToken {
    return [[RCSession currentSession] accessToken];
}

// Fetches the user with the given ID. If it is not found - returns nil.
+ (RCUser*)fetchSessionUserWithID:(NSNumber *)userID {
    NSAssert(userID, @"+fetchSessionUserWithID userID cannot be nil");
    // TODO(amadou): Should fetch the user here.
    return nil;
}

@end
