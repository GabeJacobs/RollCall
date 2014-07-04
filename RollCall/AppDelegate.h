//
//  AppDelegate.h
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RCLoginViewController.h"
#import "RCRootNavigationViewController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic) RCLoginViewController *loginViewController;
@property (nonatomic) RCRootNavigationViewController *rootNavigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
