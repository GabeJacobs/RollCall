//
//  RCRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/16/14.
//
//

#import "RCRepresentation.h"

#import "RCRepresentationHelper.h"

@implementation RCRepresentation

- (NSArray*)attributeDescriptions {
    return [RCRepresentationHelper attributeDescriptionsWithNames:[self attributeNames]
                                                            types:[self attributeTypes]
                                                   alternateNames:[self alternateNames]];
}

// TODO(amadou): Consider removing this and just enumerating the type dictionary.
- (NSArray*)attributeNames {
    NSAssert(NO, @"Subclass must implement -attributeNames");
    return nil;
}

- (NSDictionary*)attributeTypes {
    NSAssert(NO, @"Subclass must implement -attributeTypes");
    return nil;
}
- (NSDictionary*)alternateNames {
    NSLog(@"Subclass should implement -alternateNames");
    return @{};
}

@end
