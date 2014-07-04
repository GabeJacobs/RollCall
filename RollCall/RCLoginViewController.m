//
//  RCLoginViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCLoginViewController.h"
#import <FacebookSDK/FacebookSDK.h>

@interface RCLoginViewController ()

@property (nonatomic) UIImageView*	backgroundView;
@property (nonatomic) FBLoginView*	loginView;

@end

@implementation RCLoginViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
	[self.view addSubview:self.backgroundView];
	
	self.loginView = [[FBLoginView alloc] init];
	self.loginView.frame = CGRectOffset(self.loginView.frame, (self.view.center.x - (self.loginView.frame.size.width / 2)), 400);
	[self.view addSubview:self.loginView];
	
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
