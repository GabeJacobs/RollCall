//
//  RCServer.m
//  
//
//  Created by Amadou Crookes on 7/10/14.
//
//

#import "RCServer.h"
#import "RCSession.h"
#import <AFNetworking/AFNetworking.h>

static BOOL kRCServerUsesLocalData = YES;

@implementation RCServer

+ (void)startRequestWithURN:(NSString *)URN
                       data:(NSDictionary *)params
                      paged:(BOOL)paged
                     domain:(id)domain
                    batched:(BOOL)batched
              dispatchGroup:(dispatch_group_t)dispatchGroup
              responseBlock:(void (^)(id))responseBlock
               failureBlock:(void (^)(NSError *))failureBlock {
    if (kRCServerUsesLocalData) {
        responseBlock([self localJSONResponseForURN:URN]);
        return;
    }
    NSString* url = [kRCBaseUrl stringByAppendingPathExtension:URN];
    AFHTTPRequestOperationManager *manager =
        [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer =
        [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:[RCSession accessToken] forHTTPHeaderField:@"auth_token"];
    manager.requestSerializer = requestSerializer;
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO(amadou): make the error RC specific so it makes more sense.
        failureBlock(error);
    }];
}

+ (id)localJSONResponseForURN:(NSString *)urn {
    if ([urn isEqualToString:@"groups"]) {
        return @[
                 @{
                     @"id": @(0),
                     @"name": @"ROLLCALL",
                     @"datetime_created": @"2014-07-04",
                     @"datetime_last_activity": @"2014-07-04"
                  },
                 @{
                     @"id": @(1),
                     @"name": @"TUFTS",
                     @"datetime_created": @"2014-07-04",
                     @"datetime_last_activity": @"2014-07-04"
                  },
                 @{
                     @"id": @(2),
                     @"name": @"YALE",
                     @"datetime_created": @"2014-07-04",
                     @"datetime_last_activity": @"2014-07-04"
                  }
                 ];
    }
    else if ([urn isEqualToString:@"rollcalls"]) {
        return @[
                 @{
                     @"id": @(0),
                     @"time_started": @"2014-07-04",
                     @"time_ended": @"2014-07-05",
                     @"duration": @(30 * 60),
                     @"description": @"WORK SUCKS",
                  },
                 @{
                     @"id": @(1),
                     @"time_started": @"2014-07-04",
                     @"time_ended": @"2014-07-06",
                     @"duration": @(10 * 60),
                     @"description": @"WORK ROCKS",
                  },
                 @{
                     @"id": @(2),
                     @"time_started": @"2014-07-04",
                     @"time_ended": @"2014-07-07",
                     @"duration": @(60 * 60),
                     @"description": @"YOLO POLO",
                  }
                 ];
    }
    else if ([urn isEqualToString:@"responses"]) {
        return nil;
    }
    else if ([urn isEqualToString:@"image"]) {
        return nil;
    }
    NSAssert(NO, @"Create sample data to handle URN: %@", urn);
    return nil;
}

@end
