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

+ (void)startRequestWithURN:(NSString *)URN
                       data:(NSDictionary *)params
                      paged:(BOOL)paged
                     domain:(id)domain
                    batched:(BOOL)batched
              dispatchGroup:(dispatch_group_t)dispatchGroup
              responseBlock:(void (^)(id))responseBlock
               failureBlock:(void (^)(NSError *))failureBlock {
    NSString* url = [kRCBaseUrl stringByAppendingPathExtension:URN];
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    AFHTTPRequestSerializer *requestSerializer = [AFHTTPRequestSerializer serializer];
    [requestSerializer setValue:[RCSession accessToken] forHTTPHeaderField:@"auth_token"];
    manager.requestSerializer = requestSerializer;
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        responseBlock(responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        // TODO(amadou): make the error RC specific so it makes more sense.
        failureBlock(error);
    }];
}

@end
