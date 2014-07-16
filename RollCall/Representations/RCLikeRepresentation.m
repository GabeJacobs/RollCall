//
//  RCLikeRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/15/14.
//
//

#import "RCLikeRepresentation.h"

#import "RCLike.h"

@implementation RCLikeRepresentation

- (NSEntityDescription*)entity {
    return [NSEntityDescription entityForName:NSStringFromClass([RCLike class]) inManagedObjectContext:nil];
}

- (NSArray*)attributeNames {
    return @[@"created", @"likeID"];
}

- (NSDictionary*)attributeTypes {
    return @{@"created": @(NSDateAttributeType),
             @"likeID": @(NSInteger64AttributeType)
            };
}

- (NSDictionary*)alternateNames {
    return @{@"likeID": @"id"};
}

- (NSString*)primaryKeyPropertyName {
    return @"likeID";
}

@end
