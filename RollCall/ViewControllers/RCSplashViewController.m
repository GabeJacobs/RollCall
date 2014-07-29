//
//  RCLoginViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCGroupsViewController.h"
#import "RCNetworkManager.h"
#import "RCSession.h"
#import "RCSplashViewController.h"
#import "RCRollCall.h"
#import "SVProgressHUD.h"

@interface RCSplashViewController ()

@property (nonatomic) UIImageView*	backgroundView;
@property (nonatomic) UIImageView*	logoView;
@property (nonatomic) UIButton*     loginButton;
@property (nonatomic) UIButton*		signupButton;
@property (nonatomic) UIButton*		backButton;
@property (nonatomic) BOOL			signingUp;
@property (nonatomic) BOOL			loggingIn;

@property (nonatomic) UIView*		loginWrapper;
@property (nonatomic) UITextField*	phoneFieldLogin;
@property (nonatomic) UITextField*	passwordFieldLogin;

@property (nonatomic) UIView*       signupWrapper;
@property (nonatomic) UITextField*	phoneFieldSignup;
@property (nonatomic) UITextField*	firstNameFieldSignup;
@property (nonatomic) UITextField*	lastNameFieldSignup;
@property (nonatomic) UITextField*	passwordFieldSignup;

@end

@implementation RCSplashViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];


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
	self.backgroundView.frame = CGRectMake(0, 0, self.view.bounds.size.width, self.view.bounds.size.height);
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
	self.backButton.frame = CGRectMake(7, 125, backImage.size.width+20, backImage.size.height+20);
	self.backButton.alpha = 0.0;
	[self.view addSubview:self.backButton];
	
	[self setupLoginFields];
	[self setupSignupFields];
}

#pragma mark - UI

- (void)setupLoginFields {
	self.loginWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 195, self.view.bounds.size.width, 100)];
	self.loginWrapper.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.loginWrapper];
	self.loginWrapper.alpha = 0.0;
	
	UIImageView* numberIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Phone"]];
	numberIcon.frame = CGRectMake(15, 15, numberIcon.frame.size.width, numberIcon.frame.size.height);
	[self.loginWrapper addSubview:numberIcon];
	
	UIView *horizontalSeperator = [[UIView alloc] initWithFrame:CGRectMake(0, self.loginWrapper.frame.size.height/2 - .5, self.view.bounds.size.width, 1)];
	horizontalSeperator.backgroundColor = [UIColor colorWithWhite:.85 alpha:1.0];
	[self.loginWrapper addSubview:horizontalSeperator];
	
	UIImageView* passwordIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lock"]];
	passwordIcon.frame = CGRectMake(15, horizontalSeperator.frame.origin.y + .5 + 15, passwordIcon.frame.size.width, passwordIcon.frame.size.height);
	[self.loginWrapper addSubview:passwordIcon];
	
	
	UIView *verticalSeperator = [[UIView alloc] initWithFrame:CGRectMake(passwordIcon.frame.origin.x + passwordIcon.frame.size.width + 15, 0, 1, self.loginWrapper.frame.size.height)];
	verticalSeperator.backgroundColor = [UIColor colorWithWhite:.85 alpha:1.0];
	[self.loginWrapper addSubview:verticalSeperator];
	
	self.phoneFieldLogin = [[UITextField alloc] initWithFrame:CGRectMake(verticalSeperator.frame.origin.x + 10, 0, self.view.bounds.size.width - (verticalSeperator.frame.origin.x + .5), horizontalSeperator.frame.origin.y)];
	self.phoneFieldLogin.keyboardType = UIKeyboardTypePhonePad;
	self.phoneFieldLogin.backgroundColor = [UIColor clearColor];
	self.phoneFieldLogin.placeholder = @"1(222) 222-2222";
	self.phoneFieldLogin.font = [UIFont fontWithName:@"Avenir" size:18.0];
	self.phoneFieldLogin.delegate = self;
	self.phoneFieldLogin.tag = 1;
	[self.loginWrapper addSubview:self.phoneFieldLogin];
	
	self.passwordFieldLogin = [[UITextField alloc] initWithFrame:CGRectMake(verticalSeperator.frame.origin.x + 10, horizontalSeperator.frame.origin.y + .5, self.view.bounds.size.width - (verticalSeperator.frame.origin.x + .5), horizontalSeperator.frame.origin.y + .5)];
	self.passwordFieldLogin.backgroundColor = [UIColor clearColor];
	self.passwordFieldLogin.placeholder = @"Password";
	self.passwordFieldLogin.font = [UIFont fontWithName:@"Avenir" size:18.0];
	self.passwordFieldLogin.delegate = self;
	self.passwordFieldLogin.secureTextEntry = YES;
	self.passwordFieldLogin.tag = 2;
	[self.loginWrapper addSubview:self.passwordFieldLogin];
}

-(void)setupSignupFields{
	
	self.signupWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 200, self.view.bounds.size.width, 150)];
	self.signupWrapper.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.signupWrapper];
	self.signupWrapper.alpha = 0.0;
		
	UIImageView* numberIconSignup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Phone"]];
	numberIconSignup.frame = CGRectMake(15, 15, numberIconSignup.frame.size.width, numberIconSignup.frame.size.height);
	[self.signupWrapper addSubview:numberIconSignup];
	
	UIView *verticalSeperatorSignup = [[UIView alloc] initWithFrame:CGRectMake(numberIconSignup.frame.origin.x + numberIconSignup.frame.size.width + 15, 0, 1, self.signupWrapper.frame.size.height)];
	verticalSeperatorSignup.backgroundColor = [UIColor colorWithWhite:.85 alpha:1.0];
	[self.signupWrapper addSubview:verticalSeperatorSignup];

	
	UIView *horizontalSeperatorSignup = [[UIView alloc] initWithFrame:CGRectMake(0, self.signupWrapper.frame.size.height/3 - .5, self.view.bounds.size.width, 1)];
	horizontalSeperatorSignup.backgroundColor = [UIColor colorWithWhite:.85 alpha:1.0];
	[self.signupWrapper addSubview:horizontalSeperatorSignup]; // horizontalSeperator already in right spot
	
	self.phoneFieldSignup = [[UITextField alloc] initWithFrame:CGRectMake(verticalSeperatorSignup.frame.origin.x + 10, 0, self.view.bounds.size.width - (verticalSeperatorSignup.frame.origin.x + .5), horizontalSeperatorSignup.frame.origin.y)];
	self.phoneFieldSignup.keyboardType = UIKeyboardTypePhonePad;
	self.phoneFieldSignup.backgroundColor = [UIColor clearColor];
	self.phoneFieldSignup.placeholder = @"1(222) 222-2222";
	self.phoneFieldSignup.font = [UIFont fontWithName:@"Avenir" size:18.0];
	self.phoneFieldSignup.delegate = self;
	self.phoneFieldSignup.tag = 1;
	[self.signupWrapper addSubview:self.phoneFieldSignup];
	
	UIImageView* userIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"User"]];
	userIcon.frame = CGRectMake(13, horizontalSeperatorSignup.frame.origin.y + .5 + 15, userIcon.frame.size.width, userIcon.frame.size.height);
	[self.signupWrapper addSubview:userIcon];
	
	self.firstNameFieldSignup = [[UITextField alloc] initWithFrame:CGRectMake(verticalSeperatorSignup.frame.origin.x + 10, horizontalSeperatorSignup.frame.origin.y + .5, (self.view.bounds.size.width - (verticalSeperatorSignup.frame.origin.x + .5)-5)/2, horizontalSeperatorSignup.frame.origin.y)];
	self.firstNameFieldSignup.backgroundColor = [UIColor clearColor];
	self.firstNameFieldSignup.placeholder = @"First Name";
	self.firstNameFieldSignup.font = [UIFont fontWithName:@"Avenir" size:18.0];
	self.firstNameFieldSignup.delegate = self;
	self.firstNameFieldSignup.returnKeyType = UIReturnKeyNext;
	self.firstNameFieldSignup.tag = 3;
	[self.signupWrapper addSubview:self.firstNameFieldSignup];
	
	UIView *verticalSeperatorSignup2 = [[UIView alloc] initWithFrame:CGRectMake(verticalSeperatorSignup.frame.origin.x + (self.signupWrapper.frame.size.width - verticalSeperatorSignup.frame.origin.x)/2, horizontalSeperatorSignup.frame.origin.y, 1, self.firstNameFieldSignup.frame.size.height)];
	verticalSeperatorSignup2.backgroundColor = [UIColor colorWithWhite:.85 alpha:1.0];
	[self.signupWrapper addSubview:verticalSeperatorSignup2];
	
	self.lastNameFieldSignup = [[UITextField alloc] initWithFrame:CGRectMake(verticalSeperatorSignup2.frame.origin.x + 10, horizontalSeperatorSignup.frame.origin.y + .5, self.firstNameFieldSignup.frame.size.width, horizontalSeperatorSignup.frame.origin.y)];
	self.lastNameFieldSignup.backgroundColor = [UIColor clearColor];
	self.lastNameFieldSignup.placeholder = @"Last Name";
	self.lastNameFieldSignup.returnKeyType = UIReturnKeyNext;
	self.lastNameFieldSignup.font = [UIFont fontWithName:@"Avenir" size:18.0];
	self.lastNameFieldSignup.delegate = self;
	self.lastNameFieldSignup.tag = 4;
	[self.signupWrapper addSubview:self.lastNameFieldSignup];
	
	
	UIView *horizontalSeperatorSignup2 = [[UIView alloc] initWithFrame:CGRectMake(0, ((self.signupWrapper.frame.size.height/3)*2) - 1, self.view.bounds.size.width, 1)];
	horizontalSeperatorSignup2.backgroundColor = [UIColor colorWithWhite:.85 alpha:1.0];
	[self.signupWrapper addSubview:horizontalSeperatorSignup2]; // horizontalSeperator already in right spot
	
	UIImageView* passwordIconSignup = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Lock"]];
	passwordIconSignup.frame = CGRectMake(15, horizontalSeperatorSignup2.frame.origin.y + .5 + 15, passwordIconSignup.frame.size.width, passwordIconSignup.frame.size.height);
	[self.signupWrapper addSubview:passwordIconSignup];
	
	self.passwordFieldSignup = [[UITextField alloc] initWithFrame:CGRectMake(verticalSeperatorSignup.frame.origin.x + 10, horizontalSeperatorSignup2.frame.origin.y + .5, self.firstNameFieldSignup.frame.size.width, horizontalSeperatorSignup.frame.origin.y)];
	self.passwordFieldSignup.backgroundColor = [UIColor clearColor];
	self.passwordFieldSignup.placeholder = @"Password";
	self.passwordFieldSignup.returnKeyType = UIReturnKeyDone;
	self.passwordFieldSignup.font = [UIFont fontWithName:@"Avenir" size:18.0];
	self.passwordFieldSignup.delegate = self;
	self.passwordFieldSignup.secureTextEntry = YES;
	self.passwordFieldSignup.tag = 5;
	[self.signupWrapper addSubview:self.passwordFieldSignup];
	
}

-(void)viewWillAppear:(BOOL)animated{
	
	[self.navigationController setNavigationBarHidden:YES animated:YES];

}

-(void)loginPressed{
	
	if(!self.loggingIn){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.35];
		self.logoView.alpha = 0.0;
		self.signupButton.alpha = 0.0;
		self.loginButton.frame =  CGRectMake(self.loginButton.frame.origin.x, self.loginWrapper.frame.origin.y + self.loginWrapper.frame.size.height, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
		self.backButton.alpha = 1.0;
		self.loginWrapper.alpha = 1.0;
		[UIView commitAnimations];
		
		self.loggingIn = YES;
	}
	else if(self.loggingIn) {
		[self verifyLoginInfo];
	}
				
}

-(void)signupPressed{
	
	if(!self.signingUp){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.35];
		self.logoView.alpha = 0.0;
		self.loginButton.alpha = 0.0;
		self.signupButton.frame =  CGRectMake(self.signupButton.frame.origin.x, self.signupWrapper.frame.origin.y + self.signupWrapper.frame.size.height, self.signupButton.frame.size.width, self.signupButton.frame.size.height);
		self.backButton.alpha = 1.0;
		self.signupWrapper.alpha = 1.0;
		[UIView commitAnimations];
		
		self.signingUp = YES;
	}
	else if(self.signingUp) {
		[self verifySignupInfo];
	}
}

-(void)goBack{
	
	[self.view endEditing:YES];

	if(self.loggingIn) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.25];
		self.logoView.alpha = 1.0;
		self.signupButton.alpha = 1.0;
		self.loginButton.frame =  CGRectMake(self.loginButton.frame.origin.x, 454, self.loginButton.frame.size.width, self.loginButton.frame.size.height);
		self.backButton.alpha = 0.0;
		self.loginWrapper.alpha = 0.0;
		[UIView commitAnimations];
	}
	else if(self.signingUp){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
		[UIView setAnimationDuration:0.25];
		self.logoView.alpha = 1.0;
		self.loginButton.alpha = 1.0;
		self.signupButton.frame = CGRectMake(0, self.loginButton.frame.origin.y + self.loginButton.frame.size.height, self.signupButton.frame.size.width, self.signupButton.frame.size.height);
		self.backButton.alpha = 0.0;
		self.signupWrapper.alpha = 0.0;
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
	
	self.loginWrapper.alpha = 0.0;
	self.signupWrapper.alpha = 0.0;
	
	self.phoneFieldLogin.text = @"";
	self.phoneFieldSignup.text = @"";
	self.firstNameFieldSignup.text = @"";
	self.lastNameFieldSignup.text = @"";
	self.passwordFieldSignup.text = @"";
	self.passwordFieldLogin.text = @"";

	[self.view endEditing:YES];

}

#pragma mark - verify Info

- (void)verifyLoginInfo {

    NSString* phone = self.phoneFieldLogin.text;
    NSString* password = self.passwordFieldLogin.text;
	
	[SVProgressHUD showWithStatus:@"Loggin In"];
	
    [RCNetworkManager loginWithNumber:phone
                             password:password
    success:^(RCUser *user) {
		[SVProgressHUD showSuccessWithStatus:@"Success"];
        [self pushGroupController];
    } failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:@"Error"];
        NSLog(@"verifyLoginInfo Error: %@", error);
    }];
	 
}

- (void)verifySignupInfo {
    // TODO: validate all the fields.
    NSString* phone = self.phoneFieldSignup.text;
    NSString* firstName = self.firstNameFieldSignup.text;
    NSString* lastName = self.lastNameFieldSignup.text;
    NSString* password = self.passwordFieldSignup.text;

	[SVProgressHUD showWithStatus:@"Creating Group"];

	
	[RCNetworkManager signUpWithNumber:phone
                             firstName:firstName
                              lastName:lastName
                              password:password
                               success:^(RCUser *user) {
		[SVProgressHUD showWithStatus:@"Signing Up"];
        [self openCameraWithForceQuad];
    } failure:^(NSError *error) {
		[SVProgressHUD showErrorWithStatus:@"Error"];
        [[[UIAlertView alloc] initWithTitle:@"Sign Up Error"
                                    message:[error localizedDescription]
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }];
}

#pragma mark UINavigationView methods


- (void)pushGroupController{
	
	RCGroupsViewController *groupsViewController = [[RCGroupsViewController alloc] init];
	
	//Standard pushViewController is acting really werid. Tried on both phone and simualtor. Super choppy. This works
	
	CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromRight;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	[self.navigationController pushViewController:groupsViewController animated:NO];
	
	[self reset];
	
}

#pragma mark - UITextField Delegate

-(BOOL) textFieldShouldReturn:(UITextField *)textField{

	if(textField.tag == 3){
		[self.lastNameFieldSignup becomeFirstResponder];
	}
	if(textField.tag == 4){
		[self.passwordFieldSignup becomeFirstResponder];
	}
	if(textField.tag == 2 || textField.tag == 5){
		[textField resignFirstResponder];
	}
	return YES;
}

#pragma mark Keyboard notification

- (void)keyboardWillShow:(NSNotification *)note{
	double animationDuration;
	animationDuration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	UIViewAnimationCurve animationCurve = [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];
	if(self.signingUp){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:animationCurve];
		[UIView setAnimationDuration:animationDuration];
		self.signupWrapper.frame = CGRectMake(self.signupWrapper.frame.origin.x, self.signupWrapper.frame.origin.y - 55, self.signupWrapper.frame.size.width, self.signupWrapper.frame.size.height);
		self.backButton.frame = CGRectMake(self.backButton.frame.origin.x, self.backButton.frame.origin.y - 55, self.backButton.frame.size.width, self.backButton.frame.size.height);
		
		self.signupButton.frame = CGRectMake(self.signupButton.frame.origin.x, self.signupButton.frame.origin.y - 55, self.signupButton.frame.size.width, self.signupButton.frame.size.height);

		[UIView commitAnimations];
	}
}

- (void)keyboardWillHide:(NSNotification *)note{
	double animationDuration;
	animationDuration = [[[note userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];
	UIViewAnimationCurve animationCurve = [[[note userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] integerValue];

	if(self.signingUp){
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:animationCurve];
		[UIView setAnimationDuration:animationDuration];
		self.signupWrapper.frame = CGRectMake(self.signupWrapper.frame.origin.x, self.signupWrapper.frame.origin.y + 55, self.signupWrapper.frame.size.width, self.signupWrapper.frame.size.height);
		self.backButton.frame = CGRectMake(self.backButton.frame.origin.x, self.backButton.frame.origin.y + 55, self.backButton.frame.size.width, self.backButton.frame.size.height);
		
		self.signupButton.frame = CGRectMake(self.signupButton.frame.origin.x, self.signupButton.frame.origin.y + 55, self.signupButton.frame.size.width, self.signupButton.frame.size.height);
		
		[UIView commitAnimations];
	}
}

//****************************************
//****************************************
#pragma mark - Camera
//****************************************
//****************************************

- (void) openCameraWithForceQuad {
    DBCameraViewController *cameraController = [DBCameraViewController initWithDelegate:self];
    [cameraController setForceQuadCrop:YES];
	
    DBCameraContainerViewController *container = [[DBCameraContainerViewController alloc] initWithDelegate:self];
    [container setCameraViewController:cameraController];
    [container setFullScreenMode];
	
    [self.navigationController pushViewController:container animated:YES];
	[[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
}


- (void) camera:(id)cameraViewController didFinishWithImage:(UIImage *)image withMetadata:(NSDictionary *)metadata {
	[self pushGroupController];
	NSMutableArray *vcs = [self.navigationController.viewControllers mutableCopy];
	[vcs removeObjectAtIndex:[vcs count] - 2];
	[vcs removeObjectAtIndex:[vcs count] - 2];
	self.navigationController.viewControllers = vcs;
	[[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
	/*
    DetailViewController *detail = [[DetailViewController alloc] init];
    [detail setDetailImage:image];
    [self.navigationController pushViewController:detail animated:NO];
    [cameraViewController restoreFullScreenMode];
    [self.presentedViewController dismissViewControllerAnimated:YES completion:nil];
	 */
}

- (void) dismissCamera:(id)cameraViewController{
    [self dismissViewControllerAnimated:YES completion:nil];
    [cameraViewController restoreFullScreenMode];
}

@end
