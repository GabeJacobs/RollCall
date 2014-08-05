//
//  RCNetworkManager.m
//  RollCall
//
//  Created by Amadou Crookes on 7/8/14.
//
//

#import "AppDelegate.h"
#import "RCNetworkManager.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "RCSession.h"

static NSString * const kRCAuthResponseUserIDKey = @"user_id";
static NSString * const kRCAuthResponseAuthTokenKey = @"auth_key";
static NSString * const kRCAuthResponseFirstNameKey = @"first_name";
static NSString * const kRCAuthResponseLastNameKey = @"last_name";
static NSString * const kRCAuthResponsePhoneNumberKey = @"phone_number";

@interface RCNetworkManager ()
@property (nonatomic) NSCache *imageCache;
@end

@implementation RCNetworkManager

+ (RCNetworkManager*)sharedManager {
    static RCNetworkManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RCNetworkManager alloc] init];
    });
    return manager;
}

+ (void)getImageAtURL:(NSString*)url
              success:(rcImageSuccessBlock)success
              failure:(rcFailureBlock)failure {
    RCNetworkManager* manager = [RCNetworkManager sharedManager];
    UIImage* cachedImage = [manager.imageCache objectForKey:url];
    if (cachedImage) {
        success(cachedImage);
        return;
    }
    AFHTTPRequestOperationManager* httpManager = [[AFHTTPRequestOperationManager alloc] init];
    httpManager.responseSerializer = [AFImageResponseSerializer serializer];
    [httpManager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage* image) {
        [manager.imageCache setObject:image forKey:url];
        success(image);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)sendImage:(UIImage*)image
		 location:(NSString*)location
		    group:(NSNumber*)groupID
		 rollCall:(NSNumber*)rollCallID
		  success:(rcImageSuccessBlock)completion
		  failure:(rcFailureBlock)failure{
	
	//NSAssert(image && groupID && rollCallID, @"Must pass valid image, groupID and RollCall ID");
	
    NSDictionary *params = @{@"group_id":groupID, @"roll_call_id":rollCallID, @"location":location, @"auth_key":[RCSession accessToken]};
	
	AFHTTPRequestOperationManager* manager =
	[[AFHTTPRequestOperationManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString* url = [kRCBaseUrl stringByAppendingPathComponent:@"/photos"];

	NSData *imageData = UIImageJPEGRepresentation(image, 0.2);
	
	[manager POST:url parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
		[formData appendPartWithFormData:imageData name:@"image_data"];
	} success:^(AFHTTPRequestOperation *operation, id responseObject) {
		NSLog(@"Success: %@", responseObject);
	} failure:^(AFHTTPRequestOperation *operation, NSError *error) {
		NSLog(@"Error: %@", error);
	}];
	
}

+ (void)signUpWithNumber:(NSString*)phoneNumber
               firstName:(NSString*)firstName
                lastName:(NSString*)lastName
                password:(NSString*)password
                 success:(rcAuthSuccessBlock)success
                 failure:(rcFailureBlock)failure {
    NSAssert(phoneNumber && firstName && lastName && password,
             @"Must pass valid phone number, first/last name, and password to this function");
    NSDictionary* params =
        @{
          @"phone_number":phoneNumber,
          @"first_name":firstName,
          @"last_name":lastName,
          @"password":password
        };
    AFHTTPRequestOperationManager* manager =
        [[AFHTTPRequestOperationManager alloc] init];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSString* url = [kRCBaseUrl stringByAppendingPathComponent:@"/users"];

    [manager POST:url
       parameters:params
    success:^(AFHTTPRequestOperation *operation, NSDictionary *responseDict) {
        // TODO(amadou): Remove these lines.
        RCUser *user = [RCNetworkManager startSessionFromAuthResponse:responseDict];
        user.phoneNumber = phoneNumber;
        user.firstName = firstName;
        user.lastName = lastName;
        if (success) {
            success(user);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO(amadou): Turn the error into an error that is RC specific.
        // phone number taken, internet not available, phone number already signed up, etc...
        if (failure) {
            failure(error);
        }
    }];
}

+ (void)loginWithNumber:(NSString*)phoneNumber
               password:(NSString*)password
                success:(rcAuthSuccessBlock)success
                failure:(rcFailureBlock)failure {
    NSDictionary* params = @{
        kRCAuthResponsePhoneNumberKey:phoneNumber,
        @"password":password
    };
    AFHTTPRequestOperationManager* manager =
        [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString* url = [kRCBaseUrl stringByAppendingPathComponent:@"/login"];
    // TODO(amadou): same as stuff for pre signup callback calls.
    // Make functions to handle the work for this part.
    [manager GET:url parameters:params
    success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        RCUser *user = [RCNetworkManager startSessionFromAuthResponse:responseObject];
        // TODO(amadou): Remove the below line once server sends user info.
        success(user);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Login response: %@", operation.responseString);
        failure(error);
    }];
}

// TODO(amadou): This should not return anything - just this way until David returns all user info.
+ (RCUser*)startSessionFromAuthResponse:(NSDictionary*)response {
    RCUser *user = [self userFromAuthResponse:response[@"user"]];
    NSString *authToken = response[@"auth_key"][@"auth_key"];
    [RCSession startSessionWithAccessToken:authToken user:user];
    return user;
}

+ (RCUser*)userFromAuthResponse:(NSDictionary*)userDict {
    // TODO(amadou): user id should probably be a number not a string.
    NSString *userID = userDict[@"id"];
    RCUser *user = [RCNetworkManager userWithUserID:userID];
    if (!user) {
        user = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([RCUser class])
                                             inManagedObjectContext:[AppDelegate mainManagedObjectContext]];
    }
    user.firstName = userDict[@"first_name"];
    user.lastName = userDict[@"last_name"];
    user.phoneNumber = userDict[@"phone_number"];
    user.userID = userID;
    [AppDelegate saveContext];
    return user;
}

+ (RCUser*)userWithUserID:(NSString*)userID {
    NSManagedObjectContext *context = [AppDelegate mainManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity =
    [NSEntityDescription entityForName:NSStringFromClass([RCUser class])
                inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userID == %@", userID];
    [fetchRequest setPredicate:predicate];
    fetchRequest.fetchLimit = 1;
    
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    if (fetchedObjects == nil) {
        return nil;
    }
    return fetchedObjects.firstObject;
}

+ (AFHTTPRequestOperationManager *)httpOperationManager {
    AFHTTPRequestOperationManager *manager =
        [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer =
        [AFJSONRequestSerializer serializer];
    [requestSerializer setValue:[RCSession accessToken] forHTTPHeaderField:@"auth_token"];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    return manager;
}


#pragma mark - Setters and Getters

- (NSCache*)imageCache {
    if (_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache;
}

@end
