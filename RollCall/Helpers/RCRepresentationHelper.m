//
//  RCRepresentationHelper.m
//  RollCall
//
//  Created by Amadou Crookes on 7/16/14.
//
//

#import "RCRepresentationHelper.h"

#import <MMRecord.h>

@implementation RCRepresentationHelper

+ (NSAttributeDescription*)attributeWithType:(NSAttributeType)type
                                        name:(NSString*)name {
    NSAssert(name, @"Must contain name to create attribute.");
    NSAttributeDescription* attribute = [[NSAttributeDescription alloc] init];
    [attribute setName:name];
    [attribute setAttributeType:type];
    [attribute setAttributeValueClassName:NSStringFromClass([self classForType:type])];
    return attribute;
}

+ (NSAttributeDescription*)attributeWithType:(NSAttributeType)type
                                        name:(NSString*)name
                                     altName:(NSString*)altName {
    NSAttributeDescription* attribute = [self attributeWithType:type name:name];
    if (altName) {
        [attribute.userInfo setValue:altName forKey:MMRecordAttributeAlternateNameKey];
    }
    return attribute;
}

+ (Class)classForType:(NSAttributeType)type {
    switch (type) {
        case NSDateAttributeType:
            return [NSDate class];
        case NSStringAttributeType:
            return [NSString class];
        case NSInteger16AttributeType:
        case NSInteger32AttributeType:
        case NSInteger64AttributeType:
        case NSFloatAttributeType:
            return [NSNumber class];
        default:
            NSAssert(NO, @"Need to add class for new attribute!");
    }
    return nil;
}

// @param names every attribute name (NSString) in the entity.
// @param types mapping from every name to its attribute type boxed (NSNumber).
// @param altNames if an attribute has an alternative name this mapping should
//        occur in this dictionary from the original name to the alternative name.
+ (NSArray*)attributeDescriptionsWithNames:(NSArray*)names
                                     types:(NSDictionary*)types
                            alternateNames:(NSDictionary*)altNames {
    NSMutableArray* descriptions = [NSMutableArray arrayWithCapacity:names.count];
    for (NSString* name in names) {
        NSAttributeDescription* attribute =
            [self attributeWithType:[[types valueForKey:name] integerValue]
                               name:name
                            altName:[altNames valueForKey:name]];
        [descriptions addObject:attribute];
    }
    return descriptions;
}

@end
