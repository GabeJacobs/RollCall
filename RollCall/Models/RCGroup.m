//
//  RCGroup.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCGroup.h"
#import "AppDelegate.h"
#import "RCNetworkManager.h"
#import <AFNetworking.h>

@implementation RCGroup

@dynamic created;
@dynamic name;
@dynamic lastActive;
@dynamic groupID;
@dynamic users;
@dynamic rollCalls;

+ (void)getGroupsWithSuccessBlock:(void (^)(NSArray *tweets))successBlock
                     failureBlock:(void (^)(NSError *error))errorBlock {
    NSManagedObjectContext *context = [AppDelegate mainManagedObjectContext];
    [RCGroup startRequestWithURN:@"/groups"
                            data:nil
                         context:context
                          domain:nil
                     resultBlock:successBlock
                    failureBlock:errorBlock];
}

+ (void)createGroupWithName:(NSString *)name
                    numbers:(NSArray *)numbers
               successBlock:(void(^)(RCGroup *group))successBlock
               failureBlock:(void(^)(NSError *error))failureBlock {
    NSAssert(name, @"name cannot be nil - create group");
    NSAssert(numbers, @"numbers cannot be nil - create group");
    // TODO(amadou): Make sure there are enough contacts.
    // Also check that the name is good.
    NSDictionary *params = @{@"name":name, @"members":numbers};
    AFHTTPRequestOperationManager *manager = [RCNetworkManager httpOperationManager];
    NSString *url = [kRCBaseUrl stringByAppendingPathComponent:@"/groups"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        // Turn response object into RCGroup.
        // Save to core data.
        successBlock(responseObject);  // TODO(amadou): change to RCGroup.
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Create Group Failure Reason: %@", operation.responseString);
        failureBlock(error);
    }];
}

@end
