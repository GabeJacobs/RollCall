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

@implementation RCServer

static BOOL kRCServerUsesLocalData = NO;

+ (void)startRequestWithURN:(NSString *)URN
                       data:(NSDictionary *)params
                      paged:(BOOL)paged
                     domain:(id)domain
                    batched:(BOOL)batched
              dispatchGroup:(dispatch_group_t)dispatchGroup
              responseBlock:(void (^)(id))responseBlock
               failureBlock:(void (^)(NSError *))failureBlock {
    if (kRCServerUsesLocalData) {
        id responseObject = [self localJSONResponseForURN:URN];
        if (responseObject) {
            responseBlock(responseObject);
        } else {
            NSError* error =
                [NSError errorWithDomain:[NSString stringWithFormat:
                                            @"No local data for urn: %@", URN]
                                    code:-1
                                userInfo:nil];
            failureBlock(error);
        }
        return;
    }
    NSString* url = [kRCBaseUrl stringByAppendingPathComponent:URN];
    AFHTTPRequestOperationManager *manager =
        [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer =
        [AFJSONRequestSerializer serializer];
    //[requestSerializer setValue:[RCSession accessToken] forHTTPHeaderField:@"auth_key"];
    manager.requestSerializer = requestSerializer;
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    NSMutableDictionary *params_auth = [NSMutableDictionary dictionaryWithDictionary:params];
    params_auth[@"auth_key"] = [RCSession accessToken];
    [manager GET:url parameters:params_auth success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO(amadou): make the error RC specific so it makes more sense.
        failureBlock(error);
    }];
}

// Local 'JSON' responses for URNs.
// If you want these to be used instead of the server change kRCServerUsesLocalData to YES.
+ (id)localJSONResponseForURN:(NSString *)urn {
    if ([urn isEqualToString:@"/groups"]) {
        return @[
                 @{
                     @"id": @(0),
                     @"name": @"Roll Call",
                     @"datetime_created": @"2014-07-04",
                     @"datetime_last_activity": @"2014-07-04"
                  },
                 @{
                     @"id": @(1),
                     @"name": @"Tufts",
                     @"datetime_created": @"2014-07-04",
                     @"datetime_last_activity": @"2014-07-04"
                  },
                 @{
                     @"id": @(2),
                     @"name": @"Yale",
                     @"datetime_created": @"2014-07-04",
                     @"datetime_last_activity": @"2014-07-04"
                  }
                 ];
    } else if ([urn isEqualToString:@"/rollcalls"]) {
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
    } else if ([urn isEqualToString:@"responses"]) {
        return nil;
    } else if ([urn isEqualToString:@"image"]) {
        return nil;
    }
    NSAssert(NO, @"Create sample data to handle URN: %@", urn);
    return nil;
}

@end
