//
//  RCGroup.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCGroup.h"
#import "AppDelegate.h"

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

@end
