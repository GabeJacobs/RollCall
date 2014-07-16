//
//  RCLocation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCLocation.h"

#import "RCLocationRepresentation.h"

@implementation RCLocation

@dynamic latitude;
@dynamic longitude;

+ (Class)representationClass {
    return [RCLocationRepresentation class];
}

@end
