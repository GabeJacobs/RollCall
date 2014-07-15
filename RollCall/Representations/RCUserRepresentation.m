//
//  RCUserRepresentation.m
//  RollCall
//
//  Created by Amadou Crookes on 7/13/14.
//
//

#import "RCUserRepresentation.h"

#import "RCImage.h"
#import "RCRollCall.h"
#import "RCLike.h"
#import "RCGroup.h"

@implementation RCUserRepresentation

- (NSArray*)attributeDescriptions {
    NSAttributeDescription* joined = [[NSAttributeDescription alloc] init];
    [joined setName:@"joined"];
    [joined setAttributeType:NSDateAttributeType];
    [joined setAttributeValueClassName:NSStringFromClass([NSDate class])];
    
    NSAttributeDescription* lastActive = [joined copy];
    [lastActive setName:@"lastActive"];
    [lastActive.userInfo setValue:@"date_last_active" forKey:MMRecordAttributeAlternateNameKey];
    
    NSAttributeDescription* avatar = [[NSAttributeDescription alloc] init];
    [avatar setName:@"avatar"];
    [avatar setAttributeType:NSStringAttributeType];
    [avatar setAttributeValueClassName:NSStringFromClass([NSString class])];
    
    NSAttributeDescription* email = [avatar copy];
    [email setName:@"email"];
    
    NSAttributeDescription* firstName = [avatar copy];
    [firstName setName:@"firstName"];
    [firstName.userInfo setValue:@"first_name" forKey:MMRecordAttributeAlternateNameKey];
    
    NSAttributeDescription* lastName = [avatar copy];
    [lastName setName:@"lastName"];
    [lastName.userInfo setValue:@"last_name" forKey:MMRecordAttributeAlternateNameKey];
    
    NSAttributeDescription* phoneNumber = [avatar copy];
    [phoneNumber setName:@"phoneNumber"];
    [phoneNumber.userInfo setValue:@"phone_number" forKey:MMRecordAttributeAlternateNameKey];
    
    NSAttributeDescription* userID = [avatar copy];
    [userID setName:@"userID"];
    [userID.userInfo setValue:@"id" forKey:MMRecordAttributeAlternateNameKey];
    
    return @[joined, lastName, avatar, email, firstName, lastName, phoneNumber, userID];
}

- (NSArray*)relationshipDescriptions {
    NSRelationshipDescription* selfies = [[NSRelationshipDescription alloc] init];
    [selfies setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCImage class]) inManagedObjectContext:nil /* change this to use the context */]];
    NSRelationshipDescription* rollCalls = [[NSRelationshipDescription alloc] init];
    [rollCalls setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCRollCall class]) inManagedObjectContext:nil]];

    NSRelationshipDescription* likes = [[NSRelationshipDescription alloc] init];
    [likes setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCLike class]) inManagedObjectContext:nil]];
    
    NSRelationshipDescription* groups = [[NSRelationshipDescription alloc] init];
    [groups setDestinationEntity:[NSEntityDescription entityForName:NSStringFromClass([RCGroup class]) inManagedObjectContext:nil]];
    
    return @[selfies, rollCalls, likes, groups];
}

- (NSString*)primaryKeyPropertyName {
    return @"userID";
}



@end
