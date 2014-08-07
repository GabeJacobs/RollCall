//
//  RCCollectionViewCell.m
//  RollCall
//
//  Created by Amadou Crookes on 8/6/14.
//
//

#import "RCCollectionViewCell.h"
#import "RCNetworkManager.h"

@interface RCCollectionViewCell ()
@property(nonatomic, copy) NSString *url;
@property(nonatomic) UIImage *image;
@end

@implementation RCCollectionViewCell

- (void)setImageAtURL:(NSString *)url {
    if (!url) {
        RCLog("must pass url for this to function");
        return;
    }
    self.url = url;
    __weak RCCollectionViewCell *weakSelf = self;
    [RCNetworkManager getImageAtURL:url success:^(UIImage *image) {
        if ([weakSelf.url isEqualToString:url]) {
            [self gotImageForCurrentURL:image];
        }
    } failure:^(NSError *error) {
        RCLog(@"error getting image - %@", error);
    }];
}

- (void)gotImageForCurrentURL:(UIImage*)image {
    RCLog(@"gotImageForCurrentURL");
}

@end
