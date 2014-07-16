//
//  RCRepresentationHelper.h
//  RollCall
//
//  Created by Amadou Crookes on 7/16/14.
//
//

#import <Foundation/Foundation.h>

@interface RCRepresentationHelper : NSObject

+ (NSAttributeDescription*)attributeWithType:(NSAttributeType)type
                                        name:(NSString*)name;

+ (NSAttributeDescription*)attributeWithType:(NSAttributeType)type
                                        name:(NSString*)name
                                     altName:(NSString*)altName;

+ (NSArray*)attributeDescriptionsWithNames:(NSArray*)names
                                     types:(NSDictionary*)types
                            alternateNames:(NSDictionary*)altNames;

@end
