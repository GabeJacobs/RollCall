//
//  RCLocationRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/15/14.
//
//

#import "RCLocationRepresentation.h"

#import "RCLocation.h"

@implementation RCLocationRepresentation

- (NSEntityDescription*)entity {
    return [NSEntityDescription entityForName:NSStringFromClass([RCLocation class]) inManagedObjectContext:nil];
}

- (NSArray*)attributeNames {
    return @[@"latitude", @"longitude"];
}

- (NSDictionary*)attributeTypes {
    NSNumber* floatAtt = @(NSFloatAttributeType);
    return @{@"latitude": floatAtt,
             @"longitude": floatAtt
            };
}

- (NSDictionary*)alternateNames {
    return @{@"longitude": @"location.longitude",
             @"latitude": @"location.latitude"
            };
}

// TODO(amadou): should be both lat and long.
- (NSString*)primaryKeyPropertyName {
    return @"latitude";
}

@end
