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
		self.navigationBar.barTintColor = RC_BLUE;
		self.navigationBar.translucent = NO;
		
		self.navigationBar.topItem.title = @"sdf";
		self.navigationItem.title = @"sdfs";
		// not working?
	
	}
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.view.backgroundColor = [UIColor yellowColor];

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
