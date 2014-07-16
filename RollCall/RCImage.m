//
//  RCImage.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCImage.h"

#import "RCImageRepresentation.h"

@implementation RCImage

@dynamic url;
@dynamic location;
@dynamic user;
@dynamic rollCall;
@dynamic created;
@dynamic likes;
@dynamic imageID;

+ (Class)representationClass {
    return [RCImageRepresentation class];
}

@end
