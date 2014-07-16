//
//  RCGroup.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCGroup.h"
#import "RCGroupRepresentation.h"

@implementation RCGroup

@dynamic created;
@dynamic name;
@dynamic lastActive;
@dynamic groupID;

+ (Class)representationClass {
    return [RCGroupRepresentation class];
}

@end
