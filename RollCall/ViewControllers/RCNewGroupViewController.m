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
	
	self.contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 40, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.contactsTableView.delegate = self;
    self.contactsTableView.dataSource = self;
	[self.view addSubview:self.contactsTableView];
	
	[self getContactsWithRollCall];
	

    // Do any additional setup after loading the view.
}

-(void)getContactsWithRollCall{
	
	ABAddressBookRequestAccessWithCompletion(ABAddressBookCreateWithOptions(NULL, nil), ^(bool granted, CFErrorRef error) {
		if (!granted){
			//4
			NSLog(@"Just denied");
			return;
		}
		
		__block BOOL userDidGrantAddressBookAccess;
		CFErrorRef addressBookError = NULL;
		
		if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusNotDetermined ||
			ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusAuthorized )
		{
			CFArrayRef addressBook = ABAddressBookCreateWithOptions(NULL, &addressBookError);
			self.allPeople = addressBook;
			self.contactsCount = ABAddressBookGetGroupCount(addressBook);
			dispatch_semaphore_t sema = dispatch_semaphore_create(0);
			ABAddressBookRequestAccessWithCompletion(addressBook, ^(bool granted, CFErrorRef error){
				userDidGrantAddressBookAccess = granted;
				dispatch_semaphore_signal(sema);
			});
			dispatch_semaphore_wait(sema, DISPATCH_TIME_FOREVER);
		}
		else
		{
			if ( ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusDenied ||
				ABAddressBookGetAuthorizationStatus() == kABAuthorizationStatusRestricted )
			{
				// Display an error.
			}
		}
	});
	
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
		cell.accessoryType = UITableViewCellAccessoryCheckmark;

    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	ABRecordRef person = CFArrayGetValueAtIndex(self.allPeople, indexPath.row );
	NSString *firstName = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonFirstNameProperty));

	cell.textLabel.text = firstName;
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.contactsCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 260;
}

@end
