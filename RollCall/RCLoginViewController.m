//
//  RCLoginViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCLoginViewController.h"
#import "RCSession.h"
#import "RCGroupsViewController.h"

@interface RCLoginViewController ()

@property (nonatomic) UIImageView*	backgroundView;
@property (nonatomic) UIButton*		loginButton;
@property (nonatomic) UIButton*		signupButton;

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
	[self.navigationController setNavigationBarHidden:YES];

	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
	[self.view addSubview:self.backgroundView];
	
	self.loginButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.loginButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
	UIImage *loginImage = [UIImage imageNamed:@"Login"];
	[self.loginButton setImage:loginImage forState:UIControlStateNormal];
	self.loginButton.frame = CGRectMake(0, 454, loginImage.size.width, loginImage.size.height);
	
	[self.view addSubview:self.loginButton];

	self.signupButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.signupButton addTarget:self action:@selector(loginPressed) forControlEvents:UIControlEventTouchUpInside];
	UIImage *signupImage = [UIImage imageNamed:@"Signup"];
	[self.signupButton setImage:signupImage forState:UIControlStateNormal];
	self.signupButton.frame = CGRectMake(0, self.loginButton.frame.origin.y + self.loginButton.frame.size.height, signupImage.size.width, signupImage.size.height);

	[self.view addSubview:self.signupButton];
	
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];

}
-(void)loginPressed{
	RCGroupsViewController *groupsViewController = [[RCGroupsViewController alloc] init];
	[self.navigationController pushViewController:groupsViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
