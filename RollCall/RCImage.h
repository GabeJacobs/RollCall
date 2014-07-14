//
//  RCImage.h
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRecord.h"

@interface RCImage : RCRecord

@property (nonatomic) NSDate* created;
@property (nonatomic) NSString* url;
@property (nonatomic) NSNumber* imageID;

@end
