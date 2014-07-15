//
//  RCLike.h
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRecord.h"

@class RCUser;
@class RCImage;

@interface RCLike : RCRecord

// Attributes.
@property (nonatomic) NSDate* created;
@property (nonatomic) NSNumber* likeID;

// Relationships.
@property (nonatomic) RCUser* user;
@property (nonatomic) RCImage* selfie;

@end
