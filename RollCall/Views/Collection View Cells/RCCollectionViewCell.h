//
//  RCCollectionViewCell.h
//  RollCall
//
//  Created by Amadou Crookes on 8/6/14.
//
//

#import <UIKit/UIKit.h>

@interface RCCollectionViewCell : UICollectionViewCell

// When the cell gets the image for the most recent url it will call -gotImageForCurrentURL:
- (void)setImageAtURL:(NSString*)url;
// Override if you want images to be loaded.
- (void)gotImageForCurrentURL:(UIImage*)image;

@end
