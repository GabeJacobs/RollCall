//
//  RCLoginViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCSplashViewController.h"
#import "RCSession.h"
#import "RCGroupsViewController.h"

@interface RCSplashViewController ()

@property (nonatomic) UIImageView*	backgroundView;
@property (nonatomic) UIImageView*	logoView;
@property (nonatomic) UIButton*		loginButton;
@property (nonatomic) UIButton*		signupButton;

@end

@implementation RCSplashViewController

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
	
	self.navigationController.navigationBar.barTintColor = RC_BLUE;
	self.navigationController.navigationBar.translucent = NO;
	
	[self.navigationController.navigationBar setTitleTextAttributes:
	 [NSDictionary dictionaryWithObjectsAndKeys:
	  [UIColor whiteColor],
	  NSForegroundColorAttributeName,
	  [UIFont fontWithName:@"Avenir" size:18.0],
	  NSFontAttributeName,
	  nil]];

	self.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Background"]];
	[self.view addSubview:self.backgroundView];
	
	self.logoView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Logo"]];
	self.logoView.center = CGPointMake(self.view.center.x, 110);
	[self.view addSubview:self.logoView];
	
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
	
	//self presentViewController:<#(UIViewController *)#> animated:<#(BOOL)#> completion:<#^(void)completion#>
	///RCLoginViewController *loginViewController = [[RCLoginViewController alloc] init];
	//[self.navigationController pushViewController:loginViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
