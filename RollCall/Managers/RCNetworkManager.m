//
//  RCNetworkManager.m
//  RollCall
//
//  Created by Amadou Crookes on 7/8/14.
//
//

#import "RCNetworkManager.h"
#import <AFNetworking/AFHTTPRequestOperationManager.h>
#import "RCSession.h"

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
    AFHTTPRequestOperationManager* manager = [[AFHTTPRequestOperationManager alloc] init];
    manager.responseSerializer = [AFImageResponseSerializer serializer];
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, UIImage* image) {
        success(image);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

+ (void)signUpWithNumber:(NSString*)phoneNumber
               firstName:(NSString*)firstName
                lastName:(NSString*)lastName
                password:(NSString*)password
                 success:(rcAuthSuccessBlock)success
                 failure:(rcFailureBlock)failure {
    NSDictionary* params =
        @{
          @"phone":phoneNumber,
          @"first_name":firstName,
          @"last_name":lastName,
          @"password":password
        };
    AFHTTPRequestOperationManager* manager =
        [[AFHTTPRequestOperationManager alloc] init];
    NSString* url = [kRCBaseUrl stringByAppendingPathComponent:@"/authentication"];
    // TODO(amadou): Remove this.
    success(nil);
    return;
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // TODO(amadou): Turn the response object into an RCUser.
        // Save to core data.
        // Start session with user and access token.
        // [RCSession startSessionWithAccessToken:@"access_token" user:[RCUser alloc]];
        success(responseObject /* should be RCUser */);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO(amadou): Turn the error into an error that is RC specific.
        // -phone number taken
        // -internet not available
        // -phone number already signed up
        // -etc...
        failure(error);
    }];
}

+ (void)loginWithNumber:(NSString*)phoneNumber
               password:(NSString*)password
                success:(rcAuthSuccessBlock)success
                failure:(rcFailureBlock)failure {
    NSDictionary* params = @{@"phone":phoneNumber, @"password":password};
    AFHTTPRequestOperationManager* manager =
        [[AFHTTPRequestOperationManager alloc] init];
    NSString* url = [kRCBaseUrl stringByAppendingPathComponent:@"/login"];
    // TODO(amadou): same as stuff for pre signup callback calls.
    // Make functions to handle the work for this part.
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(error);
    }];
}

#pragma mark - Setters and Getters

- (NSCache*)imageCache {
    if (_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache;
}

@end

