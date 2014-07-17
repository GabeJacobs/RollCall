//
//  RCThumbnailCollectionCell.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/16/14.
//
//

#import <UIKit/UIKit.h>

@interface RCThumbnailCollectionCell : UICollectionViewCell

@property UIImageView *previewImageView;
@property UIView	  *blackLayer;

-(void)addDataToCell;
-(void)hideBlackLayer;
-(void)unhideBlackLayer;

@end
