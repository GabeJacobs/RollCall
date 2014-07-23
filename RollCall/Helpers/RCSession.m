//
//  RCSession.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "AppDelegate.h"
#import "RCSession.h"
#import "NSUserDefaults+MPSecureUserDefaults.h"

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
	
    BOOL accessTokenValid;
	BOOL loggedInValid;
	BOOL userIDValid;
	
    NSNumber *userID = [userDefaults secureObjectForKey:kUserDefaultsUserIDKey
                                                  valid:&userIDValid];
    self.accessToken = [userDefaults secureStringForKey:kUserDefaultsAccessTokenKey
                                                  valid:&accessTokenValid];
    self.loggedIn = [userDefaults secureBoolForKey:kUserDefaultsLoggedInKey
                                             valid:&loggedInValid];
    self.sessionUser = [RCSession fetchSessionUserWithID:userID];
    // If any of these are false we should unauthenticate and get a new access token.
    // Will not happen unless someone tries to hack into the keychain - probably
    // will not happen but just in case.
    if (!accessTokenValid || ! loggedInValid || ! userIDValid) {
        NSLog(@"Keychain was tampered with");
        [self endSession];
    }
    // If one of these things is not present clear everything.
    if (!self.sessionUser || !self.accessToken || !self.loggedIn) {
        NSLog(@"Not all the user information was stored correctly");
        [self endSession];
    }
}

- (void)writeDataToDisk {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setSecureObject:self.sessionUser.userID
                     forKey:kUserDefaultsUserIDKey];
    [userDefaults setSecureObject:self.accessToken
                     forKey:kUserDefaultsAccessTokenKey];
    [userDefaults setSecureBool:self.loggedIn forKey:kUserDefaultsLoggedInKey];
    [userDefaults synchronize];
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
    [self clearSessionStore];
}

- (void)clearSessionStore {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults removeObjectForKey:kUserDefaultsUserIDKey];
    [userDefaults removeObjectForKey:kUserDefaultsAccessTokenKey];
    [userDefaults removeObjectForKey:kUserDefaultsLoggedInKey];
    [userDefaults synchronize];
}

+ (RCUser*)currentUser{
    return [[RCSession currentSession] sessionUser];
}

+ (NSString*)accessToken {
    return [[RCSession currentSession] accessToken];
}

// Fetches the user with the given ID. If it is not found - returns nil.
+ (RCUser*)fetchSessionUserWithID:(NSString *)userID {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSManagedObjectContext *context = [AppDelegate mainManagedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass([RCUser class])
                                              inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    // Specify criteria for filtering which objects to fetch
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID ==  %@", userID];
    [fetchRequest setPredicate:predicate];
    fetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        NSLog(@"There was no user found with fetch for ID %@", userID);
        return nil;
    }
    return fetchedObjects.firstObject;
}

@end
