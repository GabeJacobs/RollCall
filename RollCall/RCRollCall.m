//
//  RCRollCall.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCRollCall.h"

#import "RCRollCallRepresentation.h"

@implementation RCRollCall

@dynamic ended;
@dynamic started;
@dynamic text;
@dynamic duration;
@dynamic rollCallID;
@dynamic creator;
@dynamic selfies;
@dynamic group;

+ (Class)representationClass {
    return [RCRollCallRepresentation class];
}

@end
