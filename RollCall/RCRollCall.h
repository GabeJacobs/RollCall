//
//  RCRollCall.h
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRecord.h"
#import "RCGroup.h"
#import "RCUser.h"

@interface RCRollCall : RCRecord

// Attributes.
@property (nonatomic) NSDate* ended;
@property (nonatomic) NSDate* started;
@property (nonatomic) NSString* title;  // Desciption - but that name can't be used with core data.
@property (nonatomic) NSNumber* duration; // Number of seconds? - ask David.
@property (nonatomic) NSNumber* rollCallID;

// Relationships.
@property (nonatomic) NSMutableSet* selfies;
@property (nonatomic) RCGroup* group;
@property (nonatomic) RCUser* creator;

// Functions.
+ (void)getRollCallsForGroup:(RCGroup*)group
            withSuccessBlock:(void (^)(NSArray *rollCalls))successBlock
                failureBlock:(void (^)(NSError *error))failureBlock;

+ (void)createRollCallWithDescription:(NSString*)description
                             duration:(NSNumber*)duration
                             forGroup:(RCGroup*)group
                     withSuccessBlock:(void (^)(RCRollCall*))successBlock
                         failureBlock:(void (^)(NSError*))failureBlock;

@end
