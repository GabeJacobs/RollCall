//
//  RCNewGroupViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/14/14.
//
//

#import "RCNewGroupViewController.h"

@interface RCNewGroupViewController ()

@property (nonatomic) UIView*		nameWrapper;
@property (nonatomic) UITextField*	groupNameField;

@end

@implementation RCNewGroupViewController

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
	
	self.view.backgroundColor = RC_BACKGROUND_GRAY;
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationItem.hidesBackButton = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	self.title = @"New Group";

	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle: @""
								   style: UIBarButtonItemStyleBordered
								   target: self action: @selector(goBack)];
	
	backButton.image = [UIImage imageNamed:@"Back"];
	
	self.navigationItem.leftBarButtonItem = backButton;
	
	self.nameWrapper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
	self.nameWrapper.backgroundColor = [UIColor whiteColor];
	[self.view addSubview:self.nameWrapper];
	
	self.groupNameField = [[UITextField alloc] initWithFrame:CGRectMake(10, 0, self.nameWrapper.bounds.size.width - 10, self.nameWrapper.frame.size.height)];
	self.groupNameField.backgroundColor = [UIColor clearColor];
	self.groupNameField.placeholder = @"Group Name";
	self.groupNameField.font = [UIFont fontWithName:@"Avenir" size:16.0];
	self.groupNameField.delegate = self;
	[self.nameWrapper addSubview:self.groupNameField];

	

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)goBack{
	[self.navigationController popViewControllerAnimated:YES];
}

//****************************************
//****************************************
#pragma mark - UITextField Delegate
//****************************************
//****************************************


-(BOOL) textFieldShouldReturn:(UITextField *)textField{
	
	[textField resignFirstResponder];
	return YES;
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
