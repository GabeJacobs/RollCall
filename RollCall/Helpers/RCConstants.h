//
//  RCConstants.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <Foundation/Foundation.h>

#ifndef RollCall_Constants_h
#define RollCall_Constants_h

#define RC_BLUE [UIColor colorWithRed:0.002 green:0.000 blue:0.585 alpha:1.000];
#define RC_BACKGROUND_GRAY [UIColor colorWithRed:220.0f/255.0f green:220.0f/255.0f blue:220.0f/255.0f alpha:1.000];
#define RC_DARKER_GRAY [UIColor colorWithRed:120.0f/255.0f green:120.0f/255.0f blue:120.0f/255.0f alpha:1.000];

static NSString * const kRCBaseUrl = @"http://rollcallbe.herokuapp.com";

static BOOL kRCServerUsesLocalData = YES;

#endif