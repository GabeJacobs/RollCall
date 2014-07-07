//
//  RCSettingsViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCSettingsViewController.h"

@interface RCSettingsViewController ()

@end

@implementation RCSettingsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor orangeColor];
	self.navigationController.navigationBar.barTintColor = RC_BLUE;
	self.navigationController.navigationBar.translucent = NO;

	[self.navigationController.navigationBar setTitleTextAttributes:
	 [NSDictionary dictionaryWithObjectsAndKeys:
	  [UIColor whiteColor],
	  NSForegroundColorAttributeName,
	  [UIFont fontWithName:@"Avenir" size:18.0],
	  NSFontAttributeName,
	  nil]];
	
	self.tabBarController.tabBar.translucent = NO;
	self.tabBarController.tabBar.barTintColor = [UIColor whiteColor];

	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
