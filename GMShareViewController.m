//
//  ShareViewController.m
//  GMShareExtension
//
//  Created by Gabe Jacobs on 7/3/14.
//  Copyright (c) 2014 Mindless Dribble, Inc. All rights reserved.
//

#import "GMShareViewController.h"
#import <MobileCoreServices/MobileCoreServices.h>


@interface GMShareViewController ()

@property NSData *imageData;
@property(nonatomic, copy) SLComposeSheetConfigurationItemTapHandler tapHandler;
@property(nonatomic, copy) SLComposeSheetConfigurationItem *groupConfigurationItem;

@end

@implementation GMShareViewController

- (BOOL)isContentValid {
	return YES;
}

- (void)didSelectPost {
	/*
	 [self performUpload:self.imageData];
	 UIImage *image = [UIImage imageWithData:self.imageData];
	 
	 assert([image isKindOfClass:[UIImage class]] || [image isKindOfClass:[ALAsset class]]);
	 NSString *imageGuid = [NSString UUIDString];
	 
	 GMUploadImageOperation *imageOp = [GMUploadImageOperation uploadOperationWithBlock:^(GMUploadImageOperationBuilder *builder){
		builder.uuid = imageGuid;
		builder.imageObject = image;
	 }];
	 
	 
	 [[GMPostQueueManager sharedManager] addUploadImageOperation:imageOp forChat: [GMChat chatWithId:@"8839258"]];
	 */
}


-(void)presentationAnimationDidFinish{
	
	NSExtensionItem *extensionItem = self.extensionContext.inputItems[0];
	for(NSItemProvider *itemProvider in extensionItem.attachments){
		if([itemProvider hasItemConformingToTypeIdentifier:(__bridge NSString *) kUTTypeImage]) {
			dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
				
				[itemProvider loadItemForTypeIdentifier:(__bridge NSString *) kUTTypeImage options:0 completionHandler:^(NSData* loadedData, NSError *error) {
					dispatch_async(dispatch_get_main_queue(), ^{
						self.imageData = loadedData;
					});
				}];
			});
			
			break;
		}
	}
}


- (NSArray *)configurationItems {
	// To add configuration options via table cells at the bottom of the sheet, return an array of SLComposeSheetConfigurationItem here.
	SLComposeSheetConfigurationItem *group = [[SLComposeSheetConfigurationItem alloc] init];
	group.title = @"Group";
	group.value = @"Value";
	
	return @[group];
}

-(void) performUpload:(NSData *)data{
	
	
}


@end
