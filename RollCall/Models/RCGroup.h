//
//  RCGroup.h
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRecord.h"

@interface RCGroup : RCRecord

// Attributes.
@property (nonatomic) NSDate* created;
@property (nonatomic) NSDate* lastActive;
@property (nonatomic) NSString* name;
@property (nonatomic) NSNumber* groupID;

// Relationships.
@property (nonatomic) NSMutableSet* rollCalls;
@property (nonatomic) NSMutableSet* users;

// Functions.
+ (void)getGroupsWithSuccessBlock:(void (^)(NSArray *groups))successBlock
                     failureBlock:(void (^)(NSError *error))errorBlock;

+ (void)createGroupWithName:(NSString *)name
                    numbers:(NSArray *)numbers
               successBlock:(void(^)(RCGroup *group))successBlock
               failureBlock:(void(^)(NSError *error))failureBlock;

@end
