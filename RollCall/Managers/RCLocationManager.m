//
//  RCLocationManager.m
//  RollCall
//
//  Created by Amadou Crookes on 7/8/14.
//
//

#import "RCLocationManager.h"

#import <CoreLocation/CoreLocation.h>

@interface RCLocationManager ()
@property (nonatomic, strong) CLLocationManager* locationManager;
@end

@implementation RCLocationManager

+ (void)startUpdatingLocation {
    
}

+ (void)stopUpdatingLocation {
    
}

+ (CLLocation *)currentLocation {
    return nil;
}

@end
