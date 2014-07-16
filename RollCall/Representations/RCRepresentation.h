//
//  RCRepresentation.h
//  RollCall
//
//  Created by Amadou Crookes on 7/16/14.
//
//

#import "MMRecordRepresentation.h"

@interface RCRepresentation : MMRecordRepresentation

- (NSArray*)attributeNames;
- (NSDictionary*)attributeTypes;
- (NSDictionary*)alternateNames;

@end
