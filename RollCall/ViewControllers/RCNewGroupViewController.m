//
//  RCNewGroupViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/14/14.
//
//

#import "RCNewGroupViewController.h"
#import <AddressBook/AddressBook.h>
#import "RCContactTableViewCell.h"

@interface RCNewGroupViewController ()

@property (nonatomic) UIView*			nameBackground;
@property (nonatomic) UIView*			nameWrapper;
@property (nonatomic) UITextField*		groupNameField;
@property (nonatomic) UITableView*		contactsTableView;
@property (nonatomic) NSInteger			contactsCount;
@property (nonatomic) CFArrayRef		allPeople;
@property (nonatomic) UILabel			*groupNameLabel;
@property (nonatomic) NSMutableArray	*numbersForGroup;
@property (nonatomic) UIButton			*createGroupButton;
@property (nonatomic) BOOL				canCreateGroup;

@end

@implementation RCNewGroupViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		[self getContactsWithRollCall];
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(recieveContactTapNotification:)
													 name:@"TappedContact"
												   object:nil];

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.numbersForGroup = [[NSMutableArray alloc] init];
	
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
	
	self.nameBackground = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 85)];
	self.nameBackground.backgroundColor = RC_DARKER_GRAY;
	[self.view addSubview:self.nameBackground];
	
	self.groupNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(10, 5, 100, 30)];
	self.groupNameLabel.backgroundColor = [UIColor clearColor];
	self.groupNameLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:14.0f];
	self.groupNameLabel.textColor = [UIColor whiteColor];
	self.groupNameLabel.text = @"Group Name:";
	[self.groupNameLabel sizeToFit];
	[self.nameBackground addSubview:self.groupNameLabel];

	self.groupNameField = [[UITextField alloc] initWithFrame:CGRectMake(17, self.nameBackground.frame.size.height/2 - self.nameBackground.frame.size.height/4 + 10, self.nameBackground.bounds.size.width - 32, self.nameBackground.frame.size.height/2)];
	self.groupNameField.backgroundColor = [UIColor whiteColor];
	self.groupNameField.font = [UIFont fontWithName:@"Avenir" size:16.0];
	self.groupNameField.delegate = self;
	
	self.nameWrapper = [[UIView alloc] initWithFrame:self.groupNameField.frame];
	self.nameWrapper.layer.cornerRadius = 4.0;
	self.nameWrapper.frame = CGRectMake(10, self.nameWrapper.frame.origin.y, self.nameWrapper.frame.size.width + 10, self.nameWrapper.frame.size.height);
	self.nameWrapper.backgroundColor = [UIColor whiteColor];
	[self.nameBackground addSubview:self.nameWrapper];
	[self.nameBackground addSubview:self.groupNameField];
	

	self.contactsTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 85, self.view.bounds.size.width, self.view.bounds.size.height)];
    self.contactsTableView.delegate = self;
    self.contactsTableView.dataSource = self;
	[self.view addSubview:self.contactsTableView];
	
	
	self.createGroupButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.createGroupButton.frame = CGRectMake(0, CGRectGetMaxY(self.view.frame) - 120, self.view.bounds.size.width, 60);
	[self.createGroupButton addTarget:self action:@selector(createGroup) forControlEvents:UIControlEventTouchUpInside];
	//self.createGroupButton.userInteractionEnabled = NO;
	self.createGroupButton.backgroundColor = RC_BACKGROUND_GRAY;
	[self.view addSubview:self.createGroupButton];

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

-(void)checkIfCanCreateGroup{
	if(self.numbersForGroup.count > 0){
		self.canCreateGroup = YES;
	}
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

-(BOOL) textFieldShouldBeginEditing:(UITextField *)textField{
	
	if (textField.text.length > 0) {
		[self checkIfCanCreateGroup];
	}
	else{
		self.canCreateGroup = NO;
	}
	return YES;
}

//****************************************
//****************************************
#pragma mark - UITableViewDelegate/DataSource
//****************************************
//****************************************

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *MyIdentifier = @"ContactReuseIdentifier";
    RCContactTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[RCContactTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:MyIdentifier];
    }
	//cell.selectionStyle = UITableViewCellSelectionStyleDefault;
	ABRecordRef person = CFArrayGetValueAtIndex(self.allPeople, indexPath.row );

	[cell populateWithContact:person];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RCContactTableViewCell *cell = (RCContactTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	[cell contactTouched];
	ABRecordRef person = cell.contact;
	NSString *phoneNumber = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonPhoneProperty));

	if(cell.contactSelected) {
		[self.numbersForGroup addObject:phoneNumber];
	}
	else{
		if([self.numbersForGroup containsObject:phoneNumber]){
			[self.numbersForGroup removeObject:phoneNumber];
		}
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

- (void)recieveContactTapNotification:(NSNotification *) notification {
	
	RCContactTableViewCell *cell = (RCContactTableViewCell *)[notification object];
	[cell contactTouched];
	
	ABRecordRef person = cell.contact;
	NSString *phoneNumber = (__bridge NSString *)(ABRecordCopyValue(person, kABPersonPhoneProperty));
	
	if(cell.contactSelected) {
		[self.numbersForGroup addObject:phoneNumber];
	}
	else{
		if([self.numbersForGroup containsObject:phoneNumber]){
			[self.numbersForGroup removeObject:phoneNumber];
		}
	}
	// This is will be used to push the right group
	
	
}
-(void)createGroup{
	
	self.numbersForGroup;
}

@end
