//
//  RCRollCallRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/15/14.
//
//

#import "RCRollCallRepresentation.h"

#import "RCImage.h"
#import "RCGroup.h"
#import "RCUser.h"
#import "RCRollCall.h"

#import <MMRecord.h>

@implementation RCRollCallRepresentation

- (NSEntityDescription*)entity {
    return [NSEntityDescription entityForName:NSStringFromClass([RCRollCall class]) inManagedObjectContext:nil];
}

- (NSArray*)attributeNames {
    return @[@"duration", @"ended", @"rollCallID", @"started", @"text"];
}

- (NSDictionary*)attributeTypes {
    NSNumber* intAtt = @(NSInteger64AttributeType);
    NSNumber* date = @(NSDateAttributeType);
    NSNumber* string = @(NSStringAttributeType);
    return @{@"duration": intAtt,
             @"ended": date,
             @"rollCallID": intAtt,
             @"started": date,
             @"text": string
            };
}

- (NSDictionary*)alternateNames {
    return @{@"rollCallID": @"id",
             @"text": @"description"
            };
}

- (NSString*)primaryKeyPropertyName {
    return @"rollCallID";
}

- (NSArray*)relationshipDescriptions {
    NSRelationshipDescription* selfies = [[NSRelationshipDescription alloc] init];
    [selfies setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCImage class]) inManagedObjectContext:nil]];
    
    NSRelationshipDescription* group = [[NSRelationshipDescription alloc] init];
    [selfies setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCGroup class]) inManagedObjectContext:nil]];
    
    NSRelationshipDescription* creator = [[NSRelationshipDescription alloc] init];
    [selfies setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCUser class]) inManagedObjectContext:nil]];
    
    return @[selfies, group, creator];
}


@end
