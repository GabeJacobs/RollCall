//
//  RCNewGroupViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/14/14.
//
//

#import "RCNewGroupViewController.h"
#import <AddressBook/AddressBook.h>

@interface RCNewGroupViewController ()

@property (nonatomic) UIView*		nameWrapper;
@property (nonatomic) UITextField*	groupNameField;
@property (nonatomic) UITableView*	contactsTableView;
@property (nonatomic) NSInteger		contactsCount;
@property (nonatomic) CFArrayRef	allPeople;

@end

@implementation RCNewGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self getContactsWithRollCall];

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
	
	self.contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 50, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.contactsTableView.delegate = self;
    self.contactsTableView.dataSource = self;
	[self.view addSubview:self.contactsTableView];
	
	

    // Do any additional setup after loading the view.
}

-(void)getContactsWithRollCall{
	
	
	// Request authorization to Address Book
	ABAddressBookRef addressBookRef = ABAddressBookCreateWithOptions(NULL, NULL);
	
	if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined) {
		ABAddressBookRequestAccessWithCompletion(addressBookRef, ^(bool granted, CFErrorRef error) {
			if (granted) {
				self.allPeople = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
				
			} else {
				// User denied access
				// Display an alert telling user the contact could not be added
			}
		});
	}
	else if (ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized) {
		self.allPeople = ABAddressBookCopyArrayOfAllPeople(addressBookRef);
		
	}
	else {
		// The user has previously denied access
		// Send an alert telling user to change privacy setting in settings app
	}
	
	self.contactsCount = CFArrayGetCount(self.allPeople);
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

//****************************************
//****************************************
#pragma mark - UITableViewDelegate/DataSource
//****************************************
//****************************************

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"MyReuseIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];

    }
	cell.selectionStyle = UITableViewCellSelectionStyleDefault;
	ABRecordRef person = CFArrayGetValueAtIndex(self.allPeople, indexPath.row );
	NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));

	cell.textLabel.text = firstName;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
	if (cell.accessoryType == UITableViewCellAccessoryCheckmark)
	{
		cell.accessoryType = UITableViewCellAccessoryNone;
	}
	else
	{
		cell.accessoryType = UITableViewCellAccessoryCheckmark;
	}
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactsCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 50;
}

@end
