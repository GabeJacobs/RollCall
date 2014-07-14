//
//  RCRollCall.h
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRecord.h"

@interface RCRollCall : RCRecord
@property (nonatomic) NSDate* ended;
@property (nonatomic) NSDate* started;
@property (nonatomic) NSString* text;  // Desciption - but that name can't be used with core data.
@property (nonatomic) NSNumber* duration; // Number of seconds? - ask David.
@property (nonatomic) NSNumber* rollCallID;
@end
