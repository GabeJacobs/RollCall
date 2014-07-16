//
//  RCUserRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCUserRepresentation.h"

#import "RCUser.h"
#import "RCImage.h"
#import "RCRollCall.h"
#import "RCLike.h"
#import "RCGroup.h"
#import "RCRepresentationHelper.h"

@implementation RCUserRepresentation

- (NSEntityDescription*)entity {
    return [NSEntityDescription entityForName:NSStringFromClass([RCUser class]) inManagedObjectContext:nil];
}

+ (NSArray*)attributeNames {
    return @[@"joined", @"lastActive", @"avatar",
             @"email", @"firstName", @"lastName",
             @"phoneNumber", @"userID"];
}

+ (NSDictionary*)attributeTypes {
    NSNumber* date = @(NSDateAttributeType);
    NSNumber* string = @(NSStringAttributeType);
    NSNumber* intAtt = @(NSInteger64AttributeType);
    return @{@"joined": date,
             @"lastActive": date,
             @"avatar": string,
             @"email": string,
             @"firstName": string,
             @"lastName": string,
             @"phoneNumber": string,
             @"userID": intAtt
            };
}

+ (NSDictionary*)alternateNames {
    return @{@"lastActive": @"date_last_active",
             @"firstName": @"first_name",
             @"lastName": @"last_name",
             @"phoneNumber": @"phone_number",
             @"userID": @"id"
             };
}

- (NSArray*)relationshipDescriptions {
    NSRelationshipDescription* selfies = [[NSRelationshipDescription alloc] init];
    [selfies setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCImage class])
                                              inManagedObjectContext:nil /* change this to use the context */]];
    
    NSRelationshipDescription* rollCalls = [[NSRelationshipDescription alloc] init];
    [rollCalls setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCRollCall class])
                                                inManagedObjectContext:nil]];

    NSRelationshipDescription* likes = [[NSRelationshipDescription alloc] init];
    [likes setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCLike class])
                                            inManagedObjectContext:nil]];
    
    NSRelationshipDescription* groups = [[NSRelationshipDescription alloc] init];
    [groups setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCGroup class])
                                             inManagedObjectContext:nil]];
    
    return @[selfies, rollCalls, likes, groups];
}

- (NSString*)primaryKeyPropertyName {
    return @"userID";
}



@end
