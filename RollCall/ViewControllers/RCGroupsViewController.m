//
//  RCGroupsViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCGroupsViewController.h"

@interface RCGroupsViewController ()

@end

@implementation RCGroupsViewController

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

	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationItem.hidesBackButton = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

	self.title = @"Groups";
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								  initWithTitle: @""
								  style: UIBarButtonItemStyleBordered
								  target: self action: @selector(logout)];
	
	backButton.image = [UIImage imageNamed:@"Back"];
	
	// TAKE THIS AWAY ONCE WE HAVE A LOGOUT METHOD
	
	self.navigationItem.leftBarButtonItem = backButton;
}

-(void)logout{
	

	
	CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromLeft;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	[self.navigationController popViewControllerAnimated:NO];
	
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
