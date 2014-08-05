//
//  RCRollCall.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRollCall.h"

#import "AppDelegate.h"

@class RCGroup;

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
    [RCRollCall startRequestWithURN:[NSString stringWithFormat:@"/roll_calls.json", group.groupID]
                               data:@{@"roll_call_id":group.groupID}
                            context:context
                             domain:nil
                        resultBlock:successBlock
                       failureBlock:failureBlock];
}

@end
