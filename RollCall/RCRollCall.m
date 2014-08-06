//
//  RCRollCall.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCGroup.h"
#import "RCRollCall.h"
#import "RCSession.h"
#import "RCNetworkManager.h"
#import "RCConstants.h"

#import "AppDelegate.h"
#import <AFNetworking.h>

@implementation RCRollCall

@dynamic ended;
@dynamic started;
@dynamic title;
@dynamic duration;
@dynamic rollCallID;
@dynamic creator;
@dynamic selfies;
@dynamic group;

+ (void)getRollCallsForGroup:(RCGroup *)group
            withSuccessBlock:(void (^)(NSArray *))successBlock
                failureBlock:(void (^)(NSError *))failureBlock {
    NSAssert(group, @"Must provide a group +getRollCallsForGroup:::");
    NSManagedObjectContext* context = [AppDelegate mainManagedObjectContext];
    // TODO(amadou): When david codes getting roll calls for a specific group change this.
    [RCRollCall startRequestWithURN:[NSString stringWithFormat:@"/roll_calls.json", group.groupID]
                               data:@{@"roll_call_id":group.groupID}
                            context:context
                             domain:nil
                        resultBlock:successBlock
                       failureBlock:^(NSError *error) {
                           failureBlock(error);
                       }];
}

+ (void)createRollCallWithDescription:(NSString*)description
                             duration:(NSNumber*)duration
                             forGroup:(RCGroup*)group
                     withSuccessBlock:(void (^)(RCRollCall*))successBlock
                         failureBlock:(void (^)(NSError*))failureBlock {
    NSAssert(description && duration && group, @"Must provide all params - create roll call");
    NSDictionary *params = @{@"auth_key": [RCSession accessToken],
                             @"duration": duration,
                             @"description": description,
                             @"group_id": group.groupID
                            };
    AFHTTPRequestOperationManager *manager = [RCNetworkManager httpOperationManager];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *url = [kRCBaseUrl stringByAppendingString:@"/roll_calls"];
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, NSDictionary* responseDict) {
        RCRollCall *rollCall = [NSEntityDescription insertNewObjectForEntityForName:NSStringFromClass([RCRollCall class])
                                                             inManagedObjectContext:[AppDelegate mainManagedObjectContext]];
        rollCall.rollCallID = responseDict[@"id"];
        rollCall.title = responseDict[@"description"];
        rollCall.started = [[RCRollCall dateFormatter] dateFromString:responseDict[@"started"]];
        // Ended is not set.
        //rollCall.ended = responseDict[@"ended"];
        rollCall.duration = responseDict[@"duration"];
        successBlock(rollCall);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failureBlock(error);
    }];
    
}

@end
