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
    NSManagedObjectContext* context = [AppDelegate mainManagedObjectContext];
    // TODO(amadou): Use the group id in the url or data params.
    [RCRollCall startRequestWithURN:@"rollcalls"
                               data:nil
                            context:context
                             domain:nil
                        resultBlock:successBlock
                       failureBlock:failureBlock];
}

@end
