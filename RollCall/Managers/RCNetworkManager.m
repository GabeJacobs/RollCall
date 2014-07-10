//
//  RCNetworkManager.m
//  RollCall
//
//  Created by Amadou Crookes on 7/8/14.
//
//

#import "RCNetworkManager.h"

@interface RCNetworkManager ()
@property (nonatomic) NSCache *imageCache;
@end

@implementation RCNetworkManager

+ (RCNetworkManager*)sharedManager {
    static RCNetworkManager* manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RCNetworkManager alloc] init];
    });
    return manager;
}

// TODO(amadou): Implement this.
+ (void)getImageAtURL:(NSString*)url
              success:(rcImageSuccessBlock)success
              failure:(rcImageFailureBlock)failure {
    success([UIImage imageNamed:@"Phone.png"]);
}

#pragma mark - Setters and Getters

- (NSCache*)imageCache {
    if (_imageCache) {
        _imageCache = [[NSCache alloc] init];
    }
    return _imageCache;
}

@end
