//
//  RCImage.h
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRecord.h"

@class RCUser;
@class RCRollCall;
@class RCLocation;
@class RCLike;

@interface RCImage : RCRecord

// Attributes.
@property (nonatomic) NSDate* created;
@property (nonatomic) NSString* url;
@property (nonatomic) NSNumber* imageID;

//Relationships.
@property (nonatomic) NSMutableSet* likes;
@property (nonatomic) RCUser* user;
@property (nonatomic) RCRollCall* rollCall;
@property (nonatomic) RCLocation* location;

@end
