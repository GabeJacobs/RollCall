//
//  RCDebugHelper.m
//  RollCall
//
//  Created by Amadou Crookes on 7/29/14.
//
//

#import "RCDebugHelper.h"

#import "RCUser.h"
#import "RCGroup.h"
#import "RCRollCall.h"

@implementation RCDebugHelper

+ (NSArray*)allUsers {
    return [RCDebugHelper objectsWithEntityClass:[RCUser class] withPredicate:nil];
}

+ (NSArray*)allGroups {
    return [RCDebugHelper objectsWithEntityClass:[RCGroup class] withPredicate:nil];
}

+ (NSArray*)allRollCalls {
    return [RCDebugHelper objectsWithEntityClass:[RCRollCall class] withPredicate:nil];
}

+ (NSArray*)objectsWithEntityClass:(Class)entityClass withPredicate:(NSString*)predicateString {
    NSManagedObjectContext *context = [AppDelegate mainManagedObjectContext];
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:NSStringFromClass(entityClass) inManagedObjectContext:context];
    [fetchRequest setEntity:entity];
    if (predicateString) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:predicateString];
        [fetchRequest setPredicate:predicate];
    }
    NSError *error = nil;
    NSArray *fetchedObjects = [context executeFetchRequest:fetchRequest error:&error];
    return fetchedObjects;
}

@end
