//
//  RCNotificationsViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCNotificationsViewController.h"

@interface RCNotificationsViewController ()

@end

@implementation RCNotificationsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		self.navigationBar.barTintColor = RC_BLUE;
		self.navigationBar.translucent = NO;
		[self setTitle:@"Home"];
		[self.navigationBar setTitleTextAttributes:
		 [NSDictionary dictionaryWithObjectsAndKeys:
		  [UIColor whiteColor],
		  NSForegroundColorAttributeName,
		  [UIFont fontWithName:@"Avenir" size:18.0],
		  NSFontAttributeName,
		  nil]];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor redColor];
    // Do any additional setup after loading the view.
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
