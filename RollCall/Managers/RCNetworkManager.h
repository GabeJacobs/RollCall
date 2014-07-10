//
//  RCNetworkManager.h
//  RollCall
//
//  Created by Amadou Crookes on 7/8/14.
//
//

#import <Foundation/Foundation.h>

typedef void (^rcImageSuccessBlock) (UIImage* image);
typedef void (^rcImageFailureBlock) (NSError* error);

@interface RCNetworkManager : NSObject

+ (void)getImageAtURL:(NSString*)url
              success:(rcImageSuccessBlock)completion
              failure:(rcImageFailureBlock)failure;

@end
