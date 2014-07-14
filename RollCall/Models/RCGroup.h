//
//  RCGroup.h
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRecord.h"

@interface RCGroup : RCRecord

@property (nonatomic) NSDate* created;
@property (nonatomic) NSDate* lastActive;
@property (nonatomic) NSString* name;
@property (nonatomic) NSNumber* groupID;


@end
