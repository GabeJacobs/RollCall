//
//  RCNewRollCallViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/24/14.
//
//

#import "RCNewRollCallViewController.h"
#import "RCRollCall.h"
#import "SVProgressHUD.h"

@interface RCNewRollCallViewController ()

#define X_PADDIING 15.0f
#define ITEM_SEPERATION 7.0f
#define Y_PADDIING 15.0f

@property (nonatomic) UILabel			*groupLabel;
@property (nonatomic) UIView			*groupSeperator;
@property (nonatomic) UILabel			*groupNameLabel;
@property (nonatomic) UILabel			*titleLabel;
@property (nonatomic) UIView			*titleSeperator;
@property (nonatomic) UIView			*titleWrapper;
@property (nonatomic) UITextField		*titleTextField;
@property (nonatomic) UILabel			*durationLabel;
@property (nonatomic) UIView			*durationSeperator;
@property (nonatomic) UIPickerView		*timePicker;
@property (nonatomic) UIButton			*createCallButton;
@property (nonatomic) BOOL				canCreateCall;
@property (nonatomic) UILabel			*createCallLabel;
@property (nonatomic) int				duration;

@property (nonatomic) NSMutableArray *hoursArray;
@property (nonatomic) NSMutableArray *minsArray;
@property (nonatomic) NSMutableArray *secsArray;

@property (nonatomic) NSTimeInterval interval;

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
	self.groupLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
	self.groupLabel.textColor = RC_DARKER_GRAY;
	self.groupLabel.text = @"GROUP";
	[self.groupLabel sizeToFit];
	[self.view addSubview:self.groupLabel];
	
	self.groupSeperator = [[UIView alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.groupLabel.frame) + ITEM_SEPERATION, self.view.bounds.size.width - X_PADDIING*2, 1)];
	self.groupSeperator.backgroundColor = RC_DARKER_GRAY;
	[self.view addSubview:self.groupSeperator];
	
	self.groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.groupSeperator.frame) + ITEM_SEPERATION, 100, 30)];
	self.groupNameLabel.backgroundColor = [UIColor clearColor];
	self.groupNameLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:22.0f];
	self.groupNameLabel.textColor = RC_DARKER_GRAY;
	self.groupNameLabel.text = self.group.name;
 	[self.groupNameLabel sizeToFit];
	[self.view addSubview:self.groupNameLabel];
	
	self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.groupNameLabel.frame) + Y_PADDIING*2, 100, 30)];
	self.titleLabel.backgroundColor = [UIColor clearColor];
	self.titleLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
	self.titleLabel.textColor = RC_DARKER_GRAY;
	self.titleLabel.text = @"TITLE";
	[self.titleLabel sizeToFit];
	[self.view addSubview:self.titleLabel];
	
	self.titleSeperator = [[UIView alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.titleLabel.frame) + ITEM_SEPERATION, self.view.bounds.size.width - X_PADDIING*2, 1)];
	self.titleSeperator.backgroundColor = RC_DARKER_GRAY;
	[self.view addSubview:self.titleSeperator];
	
	self.titleWrapper = [[UIView alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.titleSeperator.frame) + Y_PADDIING, self.titleSeperator.frame.size.width, 40)];
	self.titleWrapper.backgroundColor = [UIColor whiteColor];
	self.titleWrapper.layer.borderColor = [UIColor colorWithRed:120.0f/255.0f green:120.0f/255.0f blue:120.0f/255.0f alpha:1.000].CGColor;
	self.titleWrapper.layer.borderWidth = .5f;
	self.titleWrapper.layer.cornerRadius = 6.0f;
	[self.view addSubview:self.titleWrapper];
	
	self.titleTextField = [[UITextField alloc] initWithFrame:CGRectMake(6, 0, self.titleWrapper.frame.size.width - 10, self.titleWrapper.frame.size.height)];
	self.titleTextField.placeholder = @"Friday Night";
	self.titleTextField.backgroundColor = [UIColor clearColor];
	self.titleTextField.font = [UIFont fontWithName:@"Avenir" size:16.0];
	[self.titleWrapper addSubview:self.titleTextField];
	self.titleTextField.delegate = self;
	
	self.durationLabel = [[UILabel alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.titleWrapper.frame) + Y_PADDIING*2, 100, 30)];
	self.durationLabel.backgroundColor = [UIColor clearColor];
	self.durationLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:15.0f];
	self.durationLabel.textColor = RC_DARKER_GRAY;
	self.durationLabel.text = @"DURATION";
	[self.durationLabel sizeToFit];
	[self.view addSubview:self.durationLabel];
	
	self.durationSeperator = [[UIView alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.durationLabel.frame) + ITEM_SEPERATION, self.view.bounds.size.width - X_PADDIING*2, 1)];
	self.durationSeperator.backgroundColor = RC_DARKER_GRAY;
	[self.view addSubview:self.durationSeperator];
	
	self.timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.durationSeperator.frame) + ITEM_SEPERATION, self.view.bounds.size.width - X_PADDIING*2, 160)];
	self.timePicker.delegate = self;
	
	[self.view addSubview:self.timePicker];

	
	self.createCallButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.createCallButton.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 120, self.view.bounds.size.width, 60);
	[self.createCallButton addTarget:self action:@selector(createRollCall) forControlEvents:UIControlEventTouchUpInside];
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

	[self setupTimePicker];
	
	
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
	
	if(![self.titleTextField.text isEqual:@""]){
		self.canCreateCall = YES;
		self.createCallButton.backgroundColor = [UIColor colorWithRed:63.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0];
		self.createCallButton.userInteractionEnabled = YES;
	}
	else{
		self.canCreateCall = NO;
		self.createCallButton.backgroundColor = RC_BACKGROUND_GRAY;
		self.createCallButton.userInteractionEnabled = NO;
	}
	
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
	return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent :(NSInteger)component{
    if (component==0){
        return [self.hoursArray count];
    }
    else{
        return [self.minsArray count];
    }
	
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 37)];
	if(component == 0){
		label.text = [NSString stringWithFormat:@"%@ Hours", [self.hoursArray objectAtIndex:row]];
	}
	else{
		label.text = [NSString stringWithFormat:@"%@ Mins", [self.minsArray objectAtIndex:row]];
		
	}
    label.textAlignment = NSTextAlignmentCenter; //Changed to NS as UI is deprecated.
    label.backgroundColor = [UIColor clearColor];
    return label;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	[self checkIfCanCreateRollCall];
	
	
	
}

- (void)textFieldDidEndEditing:(UITextField *)textField{
	
	[self checkIfCanCreateRollCall];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
	
	[self.titleTextField resignFirstResponder];
	return YES;
}

- (void)setupTimePicker{
	
	self.hoursArray = [[NSMutableArray alloc] init];
	self.minsArray = [[NSMutableArray alloc] init];
    NSString *strVal = [[NSString alloc] init];
	
    for(int i=0; i<60; i++)
    {
        strVal = [NSString stringWithFormat:@"%d", i];
		
        //NSLog(@"strVal: %@", strVal);
		
        //Create array with 0-12 hours
        if (i < 24)
        {
            [self.hoursArray addObject:strVal];
        }
		
        //create arrays with 0-60 secs/mins
        [self.minsArray addObject:strVal];
    }
}

- (int)getDurationFromPicker{
	
	int mins = 0;
	
	NSInteger hourRow = [self.timePicker selectedRowInComponent:0];
	NSInteger minsRow = [self.timePicker selectedRowInComponent:1];
	
	mins += hourRow * 60;
	mins += minsRow;
	
	if(!mins){
		mins = 0;
	}
	return mins;

}

- (void)createRollCall {
	// Show sucess before going back
	[SVProgressHUD showWithStatus:@"Creating RollCall"];
	// TODO: send self.duration and self.titleTextField.text
	self.duration = [self getDurationFromPicker];
	[RCRollCall createRollCallWithDescription:self.titleTextField.text
                                     duration:@(self.duration)
                                     forGroup:self.group
    withSuccessBlock:^(RCRollCall *rollCall) {
        [SVProgressHUD showSuccessWithStatus:@"Created"];
        [self goBack];
    } failureBlock:^(NSError *error) {
        NSLog(@"Create roll call error");
        NSLog(@"%@", error);
        [SVProgressHUD showErrorWithStatus:@"Failed :("];
    }];
}

@end
