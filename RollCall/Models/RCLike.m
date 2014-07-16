//
//  RCLike.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCLike.h"

#import "RCLikeRepresentation.h"

@implementation RCLike

@dynamic likeID;
@dynamic created;
@dynamic selfie;
@dynamic user;

+ (Class)representationClass {
    return [RCLikeRepresentation class];
}

@end
