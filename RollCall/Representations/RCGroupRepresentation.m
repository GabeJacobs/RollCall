//
//  RCGroupRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/15/14.
//
//

#import "RCGroupRepresentation.h"

#import "RCGroup.h"

@implementation RCGroupRepresentation

- (NSEntityDescription*)entity {
    return [NSEntityDescription entityForName:NSStringFromClass([RCGroup class]) inManagedObjectContext:nil];
}

- (NSArray*)attributeNames {
    return @[@"created", @"groupID", @"lastActive", @"name"];
}

- (NSDictionary*)attributeTypes {
    NSNumber* int64 = @(NSInteger64AttributeType);
    NSNumber* date = @(NSDateAttributeType);
    NSNumber* string = @(NSStringAttributeType);
    return @{@"created": date,
             @"groupID": int64,
             @"lastActive": date,
             @"name": string};
}

- (NSDictionary*)alternateNames {
    return @{@"created": @"date_made",
             @"groupID": @"id",
             @"lastActive": @"last_active"};
}

- (NSString*)primaryKeyPropertyName {
    return @"groupID";
}

@end
