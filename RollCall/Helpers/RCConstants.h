//
//  RCConstants.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

// Function Defines.
#define RCLog(fmt, ...) NSLog((@"%s [Line %d] " fmt), __PRETTY_FUNCTION__, __LINE__, ##__VA_ARGS__)

// Colors.
#define RC_BLUE [UIColor colorWithRed:0.002 green:0.000 blue:0.585 alpha:1.000];
#define RC_BACKGROUND_GRAY [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.000];
#define RC_DARKER_GRAY [UIColor colorWithRed:120.0f/255.0f green:120.0f/255.0f blue:120.0f/255.0f alpha:1.000];

// Strings.
static NSString * const kRCBaseUrl = @"http://rollcallbe.herokuapp.com";

