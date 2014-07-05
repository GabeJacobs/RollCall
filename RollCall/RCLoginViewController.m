//
//  RCLoginViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/4/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCLoginViewController.h"
#import "RCSession.h"
#import <FacebookSDK/FacebookSDK.h>

@interface RCLoginViewController ()

@property (nonatomic) UIImageView*	backgroundView;
@property (nonatomic) FBLoginView*	loginView;
@property (strong, nonatomic) id<FBGraphUser> loggedInUser;

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
	
	self.loginView = [[FBLoginView alloc] initWithReadPermissions:@[@"public_profile", @"email", @"user_friends"]];
	self.loginView.frame = CGRectOffset(self.loginView.frame, (self.view.center.x - (self.loginView.frame.size.width / 2)), 400);
	self.loginView.delegate = self;
	[self.view addSubview:self.loginView];
	
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
	
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView
                            user:(id<FBGraphUser>)user {
	
	self.loggedInUser = user;
	[RCSession startSessionWithUserID:[user id]];


}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
	/*
	self.statusLabel.text = @"You're logged in as";
	 */
}

- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView {
	/*
	self.profilePictureView.profileID = nil;
	self.nameLabel.text = @"";
	self.statusLabel.text= @"You're not logged in!";
	*/
}

- (void)loginView:(FBLoginView *)loginView handleError:(NSError *)error {
	/*
	NSString *alertMessage, *alertTitle;
	
	// If the user should perform an action outside of you app to recover,
	// the SDK will provide a message for the user, you just need to surface it.
	// This conveniently handles cases like Facebook password change or unverified Facebook accounts.
	if ([FBErrorUtility shouldNotifyUserForError:error]) {
		alertTitle = @"Facebook error";
		alertMessage = [FBErrorUtility userMessageForError:error];
		
		// This code will handle session closures that happen outside of the app
		// You can take a look at our error handling guide to know more about it
		// https://developers.facebook.com/docs/ios/errors
	} else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession) {
		alertTitle = @"Session Error";
		alertMessage = @"Your current session is no longer valid. Please log in again.";
		
		// If the user has cancelled a login, we will do nothing.
		// You can also choose to show the user a message if cancelling login will result in
		// the user not being able to complete a task they had initiated in your app
		// (like accessing FB-stored information or posting to Facebook)
	} else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
		NSLog(@"user cancelled login");
		
		// For simplicity, this sample handles other errors with a generic message
		// You can checkout our error handling guide for more detailed information
		// https://developers.facebook.com/docs/ios/errors
	} else {
		alertTitle  = @"Something went wrong";
		alertMessage = @"Please try again later.";
		NSLog(@"Unexpected error:%@", error);
	}
	
	if (alertMessage) {
		[[[UIAlertView alloc] initWithTitle:alertTitle
									message:alertMessage
								   delegate:nil
						  cancelButtonTitle:@"OK"
						  otherButtonTitles:nil] show];
	}
	 */
}

@end
