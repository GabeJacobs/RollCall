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

#import <MMRecord.h>

@implementation RCRollCallRepresentation

- (NSArray*)attributeDescriptions {
    NSAttributeDescription* ended = [[NSAttributeDescription alloc] init];
    [ended setName:@"ended"];
    [ended setAttributeType:NSDateAttributeType];
    [ended setAttributeValueClassName:NSStringFromClass([NSDate class])];
    NSAttributeDescription* started = [ended copy];
    [started setName:@"started"];
    
    NSAttributeDescription* text = [[NSAttributeDescription alloc] init];
    [text setName:@"text"];
    [text setAttributeType:NSStringAttributeType];
    [text setAttributeValueClassName:NSStringFromClass([NSString class])];
    [text.userInfo setValue:@"description"
                     forKey:MMRecordAttributeAlternateNameKey];
    
    NSAttributeDescription* duration = [[NSAttributeDescription alloc] init];
    [duration setName:@"duration"];
    [duration setAttributeType:NSInteger64AttributeType];
    [duration setAttributeValueClassName:NSStringFromClass([NSNumber class])];
    NSAttributeDescription* rollCallID = [duration copy];
    [rollCallID setName:@"rollCallID"];
    
    return @[ended, started, duration, text, rollCallID];
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
