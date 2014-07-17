//
//  RCRecord.m
//  RollCall
//
//  Created by Amadou Crookes on 7/10/14.
//
//

#import "RCRecord.h"

static NSDateFormatter* RCRecordDateFormatter;

@implementation RCRecord

+ (NSString*)keyPathForResponseObject {
    return nil;
}

+ (NSDateFormatter *)dateFormatter {
    if (!RCRecordDateFormatter) {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        // TODO(amadou): Change this to whatever format the server actually returns.
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        RCRecordDateFormatter = dateFormatter;
    }
    
    return RCRecordDateFormatter;
}

@end
