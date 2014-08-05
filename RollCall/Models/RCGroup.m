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
#import "RCSession.h"
#import "RCRecord.h"
#import <AFNetworking.h>

@implementation RCGroup

@dynamic created;
@dynamic name;
@dynamic lastActive;
@dynamic groupID;
@dynamic users;
@dynamic rollCalls;

#pragma mark - Network Calls

+ (void)getGroupsWithSuccessBlock:(void (^)(NSArray *tweets))successBlock
                     failureBlock:(void (^)(NSError *error))errorBlock {
    NSManagedObjectContext *context = [AppDelegate mainManagedObjectContext];
    [RCGroup startRequestWithURN:@"/groups.json"
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
    NSDictionary *params = @{@"name":name, @"users":numbers, @"auth_key":[RCSession accessToken]};
    AFHTTPRequestOperationManager *manager = [RCNetworkManager httpOperationManager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [kRCBaseUrl stringByAppendingPathComponent:@"/groups"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary *groupDict) {
        // Turn response object into RCGroup.
        // Save to core data.
        RCGroup *group = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([RCGroup class])
                                                       inManagedObjectContext:[AppDelegate mainManagedObjectContext]];
        group.name = groupDict[@"name"];
        group.groupID = groupDict[@"id"];
        group.created = [[RCRecord dateFormatter] dateFromString:groupDict[@"created_at"]];
        successBlock(group);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Create Group Failure Reason: %@", operation.responseString);
        failureBlock(error);
    }];
}

@end
