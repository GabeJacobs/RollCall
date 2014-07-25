//
//  RCNetworkManager.h
//  RollCall
//
//  Created by Amadou Crookes on 7/8/14.
//
//

#import <Foundation/Foundation.h>

@class RCUser;
@class AFHTTPRequestOperationManager;

typedef void (^rcImageSuccessBlock) (UIImage* image);
typedef void (^rcFailureBlock) (NSError* error);
typedef void (^rcAuthSuccessBlock) (RCUser* user);

@interface RCNetworkManager : NSObject

+ (void)getImageAtURL:(NSString*)url
              success:(rcImageSuccessBlock)completion
              failure:(rcFailureBlock)failure;

+ (void)signUpWithNumber:(NSString*)phoneNumber
               firstName:(NSString*)firstName
                lastName:(NSString*)lastName
                password:(NSString*)password
                 success:(rcAuthSuccessBlock)success
                 failure:(rcFailureBlock)failure;

+ (void)loginWithNumber:(NSString*)phoneNumber
               password:(NSString*)password
                success:(rcAuthSuccessBlock)success
                failure:(rcFailureBlock)failure;

// AF Manager for JSON requests and responses with the auth token in the header.
+ (AFHTTPRequestOperationManager *)httpOperationManager;

@end
