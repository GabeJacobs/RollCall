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
#import "RCLoginViewController.h"

@interface RCSplashViewController ()

@property (nonatomic) UIImageView*	backgroundView;
@property (nonatomic) UIImageView*	logoView;
@property (nonatomic) UIButton*		loginButton;
@property (nonatomic) UIButton*		signupButton;
@property (nonatomic) UIButton*		backButton;
@property (nonatomic) BOOL			signingUp;
@property (nonatomic) BOOL			loggingIn;

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
	[self.signupButton addTarget:self action:@selector(signupPressed) forControlEvents:UIControlEventTouchUpInside];
	UIImage *signupImage = [UIImage imageNamed:@"Signup"];
	[self.signupButton setImage:signupImage forState:UIControlStateNormal];
	self.signupButton.frame = CGRectMake(0, self.loginButton.frame.origin.y + self.loginButton.frame.size.height, signupImage.size.width, signupImage.size.height);
	[self.view addSubview:self.signupButton];

	
	self.backButton = [UIButton buttonWithType:UIButtonTypeCustom];
	[self.backButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
	UIImage *backImage = [UIImage imageNamed:@"Back"];
	[self.backButton setImage:backImage forState:UIControlStateNormal];
	self.backButton.frame = CGRectMake(25, 100, backImage.size.width+20, backImage.size.height+20);
	self.backButton.alpha = 0.0;
	[self.view addSubview:self.backButton];
	

	
	// Do any additional setup after loading the view.
}

-(void)viewWillAppear:(BOOL)animated{
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];

}

-(void)loginPressed{
	
	if(!self.loggingIn){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.25];
		self.logoView.alpha = 0.0;
		self.signupButton.alpha = 0.0;
		self.loginButton.frame =  CGRectMake(self.loginButton.frame.origin.x, self.loginButton.frame.origin.y - 100, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
		self.backButton.alpha = 1.0;
		[UIView commitAnimations];
		
		self.loggingIn = YES;
	}
	else if(self.loggingIn) {
		RCGroupsViewController *groupsViewController = [[RCGroupsViewController alloc] init];
		[self.navigationController pushViewController:groupsViewController animated:YES];
		[self reset];
	}
				
}

-(void)signupPressed{
	
	if(!self.signingUp){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.25];
		self.logoView.alpha = 0.0;
		self.loginButton.alpha = 0.0;
		self.signupButton.frame =  CGRectMake(self.signupButton.frame.origin.x, self.signupButton.frame.origin.y - 100, self.signupButton.frame.size.width, self.signupButton.frame.size.height);
		self.backButton.alpha = 1.0;
		[UIView commitAnimations];
		
		self.signingUp = YES;
	}
}

-(void)goBack{
	
	if(self.loggingIn) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.25];
		self.logoView.alpha = 1.0;
		self.signupButton.alpha = 1.0;
		self.loginButton.frame =  CGRectMake(self.loginButton.frame.origin.x, self.loginButton.frame.origin.y + 100, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
		self.backButton.alpha = 0.0;
		[UIView commitAnimations];
	}
	else if(self.signingUp){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.25];
		self.logoView.alpha = 1.0;
		self.loginButton.alpha = 1.0;
		self.signupButton.frame =  CGRectMake(self.signupButton.frame.origin.x, self.signupButton.frame.origin.y + 100, self.signupButton.frame.size.width, self.signupButton.frame.size.height);
		self.backButton.alpha = 0.0;
		[UIView commitAnimations];
	}
	
	
	self.loggingIn = NO;
	self.signingUp = NO;
	
}

- (void)reset {
	
	self.loginButton.alpha = 1.0;
	self.signupButton.alpha = 1.0;
	
	self.loginButton.frame = CGRectMake(0, 454, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
	self.signupButton.frame = CGRectMake(0, self.loginButton.frame.origin.y + self.loginButton.frame.size.height, self.signupButton.frame.size.width, self.signupButton.frame.size.height);
	
	self.backButton.alpha = 0.0;
	
	self.logoView.alpha = 1.0;
	
	self.signingUp = NO;
	self.loggingIn = NO;

}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
