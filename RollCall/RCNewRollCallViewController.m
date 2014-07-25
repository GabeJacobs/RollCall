//
//  RCNewRollCallViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/24/14.
//
//

#import "RCNewRollCallViewController.h"

@interface RCNewRollCallViewController ()

#define X_PADDIING 15.0f
#define Y_PADDIING 15.0f

@property (nonatomic) UILabel			*groupLabel;
@property (nonatomic) UIView			*groupSeperator;
@property (nonatomic) UILabel			*groupNameLabel;
@property (nonatomic) UILabel			*titleLabel;
@property (nonatomic) UIView			*titleSeperator;
@property (nonatomic) UIView			*titleWrapper;
@property (nonatomic) UITextView		*titleTextView;
@property (nonatomic) UILabel			*durationLabel;
@property (nonatomic) UIView			*durationSeperator;
@property (nonatomic) UIPickerView		*timePicker;
@property (nonatomic) UIButton			*createCallButton;
@property (nonatomic) BOOL				canCreateCall;
@property (nonatomic) UILabel			*createCallLabel;

@end

@implementation RCNewRollCallViewController

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
	
	self.view.backgroundColor = [UIColor whiteColor];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationItem.hidesBackButton = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	self.title = @"New Roll Call";
	
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle: @""
								   style: UIBarButtonItemStyleBordered
								   target: self action: @selector(goBack)];
	
	backButton.image = [UIImage imageNamed:@"Back"];
	
	self.navigationItem.leftBarButtonItem = backButton;
	
	self.groupLabel = [[UILabel alloc] initWithFrame:CGRectMake(X_PADDIING, Y_PADDIING*2, 100, 30)];
	self.groupLabel.backgroundColor = [UIColor clearColor];
	self.groupLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:16.0f];
	self.groupLabel.textColor = RC_DARKER_GRAY;
	self.groupLabel.text = @"GROUP";
	[self.groupLabel sizeToFit];
	[self.view addSubview:self.groupLabel];
	
	self.createCallButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.createCallButton.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 120, self.view.bounds.size.width, 60);
	[self.createCallButton addTarget:self action:@selector(createGroup) forControlEvents:UIControlEventTouchUpInside];
	self.createCallButton.userInteractionEnabled = NO;
	self.createCallButton.backgroundColor = RC_BACKGROUND_GRAY;
	[self.view addSubview:self.createCallButton];
	
	self.createCallLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
	self.createCallLabel.backgroundColor = [UIColor clearColor];
	self.createCallLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:22.0f];
	self.createCallLabel.textColor = [UIColor whiteColor];
	self.createCallLabel.text = @"CREATE ROLL CALL";
	[self.createCallLabel sizeToFit];
	self.createCallLabel.center = CGPointMake(self.createCallButton.center.x + 3, self.createCallButton.center.y);
	[self.view addSubview:self.createCallLabel];


	
	
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

-(void)checkIfCanCreateRollCall{
	
}


-(void)createGroup{
	
	// Show sucess before going back
	
	// TODO: send self.numbersForGoup and self.groupNameLabel.text
	[self goBack];
}

@end
