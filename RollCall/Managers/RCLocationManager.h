//
//  RCLocationManager.h
//  RollCall
//
//  Created by Amadou Crookes on 7/8/14.
//
//

@class CLLocation;

#import <Foundation/Foundation.h>

@interface RCLocationManager : NSObject

+ (void)startUpdatingLocation;
+ (void)stopUpdatingLocation;
+ (CLLocation *)currentLocation;

@end
