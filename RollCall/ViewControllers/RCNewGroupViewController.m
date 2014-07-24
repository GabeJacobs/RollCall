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
@property (nonatomic) UILabel			*createGroupLabel;
@property (nonatomic) UIImageView		*peopleSymbolView;
@property (nonatomic) UILabel			*personCountLabel;


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
	self.createGroupButton.userInteractionEnabled = NO;
	self.createGroupButton.backgroundColor = RC_BACKGROUND_GRAY;
	[self.view addSubview:self.createGroupButton];
	
	self.createGroupLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 40)];
	
	self.createGroupLabel.backgroundColor = [UIColor clearColor];
	self.createGroupLabel.font = [UIFont fontWithName:@"Avenir-Heavy" size:22.0f];
	self.createGroupLabel.textColor = [UIColor whiteColor];
	self.createGroupLabel.text = @"CREATE GROUP";
	[self.createGroupLabel sizeToFit];
	self.createGroupLabel.center = CGPointMake(self.createGroupButton.center.x + 3, self.createGroupButton.center.y);
	[self.view addSubview:self.createGroupLabel];

	self.peopleSymbolView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"LittleGuy"]];
	self.peopleSymbolView.backgroundColor = [UIColor clearColor];
	self.peopleSymbolView.center = CGPointMake(self.createGroupLabel.center.x - 145, self.createGroupLabel.center.y + 3);
	[self.view addSubview:self.peopleSymbolView];
	
	self.personCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
	self.personCountLabel.backgroundColor = [UIColor clearColor];
	self.personCountLabel.font = [UIFont fontWithName:@"Avenir" size:12.0f];
	self.personCountLabel.textColor = [UIColor whiteColor];
	self.personCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.numbersForGroup.count];
	[self.personCountLabel sizeToFit];
	self.personCountLabel.center = CGPointMake(self.peopleSymbolView.center.x + 10, self.peopleSymbolView.center.y - 9);
	[self.view addSubview:self.personCountLabel];
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
	if(self.allPeople){
		self.contactsCount = CFArrayGetCount(self.allPeople);
	}
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
	if(self.numbersForGroup.count > 0 && ![self.groupNameField.text isEqual:@""]){
		self.canCreateGroup = YES;
		self.createGroupButton.backgroundColor = [UIColor colorWithRed:63.0f/255.0f green:152.0f/255.0f blue:0.0f/255.0f alpha:1.0];
		self.createGroupButton.userInteractionEnabled = YES;
	}
	else{
		self.canCreateGroup = NO;
		self.createGroupButton.backgroundColor = RC_BACKGROUND_GRAY;
		self.createGroupButton.userInteractionEnabled = NO;
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

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField{
	
	[self checkIfCanCreateGroup];
	
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
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	ABRecordRef person = CFArrayGetValueAtIndex(self.allPeople, indexPath.row );

	[cell populateWithContact:person];
	
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	RCContactTableViewCell *cell = (RCContactTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
	[self contactCellTapped:cell];

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
	[self contactCellTapped:cell];

	
}


-(void)contactCellTapped:(RCContactTableViewCell*)cell{
	
	[cell changeContactButton];

	ABRecordRef person = cell.contact;
	
	NSString *phone = @"";
	NSString *phoneNumber = @"";
	
	ABMultiValueRef phones = ABRecordCopyValue(person, kABPersonPhoneProperty);
    for(CFIndex j = 0; j < ABMultiValueGetCount(phones); j++)
    {
		phone = @""; // ???
        CFStringRef phoneNumberRef = ABMultiValueCopyValueAtIndex(phones, j);
        phoneNumber = (__bridge NSString *)phoneNumberRef;
    }
	
	NSCharacterSet *charactersToRemove = [[NSCharacterSet alphanumericCharacterSet] invertedSet];
	phoneNumber = [[phoneNumber componentsSeparatedByCharactersInSet:charactersToRemove] componentsJoinedByString:@""];
	
	if(cell.contactSelected) {
		[self.numbersForGroup addObject:phoneNumber];
	}
	else{
		if([self.numbersForGroup containsObject:phoneNumber]){
			[self.numbersForGroup removeObject:phoneNumber];
		}
	}
	
	[self checkIfCanCreateGroup];
	
	self.personCountLabel.text = [NSString stringWithFormat:@"%lu", (unsigned long)self.numbersForGroup.count];

	
}

-(void)createGroup{

	NSAssert(self.numbersForGroup.count > 0, @"why no numbas");
	// TODO: senf self.numbersForGoup and self.groupNameLabel.text
}

@end
