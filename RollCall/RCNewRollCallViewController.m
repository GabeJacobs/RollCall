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
	//self.titleTextField.delegate = self;
	
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
	
	self.timePicker = [[UIPickerView alloc] initWithFrame:CGRectMake(X_PADDIING, CGRectGetMaxY(self.durationSeperator.frame) + ITEM_SEPERATION, self.view.bounds.size.width - X_PADDIING*2, 150)];
	self.timePicker.delegate = self;
	
	[self.view addSubview:self.timePicker];

	
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

-(UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
	// Get the text of the row.
	NSString *rowItem = [self.minsArray objectAtIndex: row];
	
	// Create and init a new UILabel.
	// We must set our label's width equal to our picker's width.
	// We'll give the default height in each row.
	UILabel *lblRow = [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView bounds].size.width, 44.0f)];
	
	// Center the text.
	[lblRow setTextAlignment:NSTextAlignmentCenter];
	
	// Make the text color red.
	[lblRow setTextColor: [UIColor redColor]];
	
	// Add the text.
	[lblRow setText:rowItem];
	
	// Clear the background color to avoid problems with the display.
	[lblRow setBackgroundColor:[UIColor clearColor]];
	
	// Return the label.
	return lblRow;
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
	
	
}


-(void)setupTimePicker{
	
	self.hoursArray = [[NSMutableArray alloc] init];
	self.minsArray = [[NSMutableArray alloc] init];
    NSString *strVal = [[NSString alloc] init];
	
    for(int i=0; i<61; i++)
    {
        strVal = [NSString stringWithFormat:@"%d", i];
		
        //NSLog(@"strVal: %@", strVal);
		
        //Create array with 0-12 hours
        if (i < 13)
        {
            [self.hoursArray addObject:strVal];
        }
		
        //create arrays with 0-60 secs/mins
        [self.minsArray addObject:strVal];
    }
}

-(void)createGroup{
	
	// Show sucess before going back
	
	// TODO: send self.numbersForGoup and self.groupNameLabel.text
	[self goBack];
}

@end
