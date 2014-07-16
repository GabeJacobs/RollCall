//
//  RCImageRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/15/14.
//
//

#import "RCImageRepresentation.h"

#import "RCImage.h"

@implementation RCImageRepresentation

- (NSEntityDescription*)entity {
    return [NSEntityDescription entityForName:NSStringFromClass([RCImage class]) inManagedObjectContext:nil];
}

- (NSArray*)attributeNames {
    return @[@"created", @"imageID", @"url"];
}

- (NSDictionary*)attributeTypes {
    NSNumber* date = @(NSDateAttributeType);
    NSNumber* int64 = @(NSInteger64AttributeType);
    NSNumber* string = @(NSStringAttributeType);
    return @{@"created": date,
             @"imageID": int64,
             @"url": string
            };
}

- (NSDictionary*)alternateNames {
    return @{@"imageID": @"id"};
}

- (NSString*)primaryKeyPropertyName {
    return @"imageID";
}

@end
