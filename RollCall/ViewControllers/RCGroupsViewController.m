//
//  RCGroupsViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/5/14.
//  Copyright (c) 2014 Gabe Jacobs. All rights reserved.
//

#import "RCGroupsViewController.h"
#import "RCGroupTableViewCell.h"
#import "RCRollCallsViewController.h"

@interface RCGroupsViewController ()

@property (nonatomic) UITableView* groupsTableView;

@end

@implementation RCGroupsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
		
		[[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receiveAvatarTapNotification:)
													 name:@"TappedAvatar"
												   object:nil];
		
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

	self.title = @"Groups";
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								  initWithTitle: @""
								  style: UIBarButtonItemStyleBordered
								  target: self action: @selector(logout)];
	
	backButton.image = [UIImage imageNamed:@"Back"];
	
	// TAKE THIS AWAY ONCE WE HAVE A LOGOUT METHOD
	
	self.navigationItem.leftBarButtonItem = backButton;
	
	self.groupsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, self.view.bounds.size.height - 10)];
	self.groupsTableView.separatorColor = [UIColor clearColor];
    self.groupsTableView.backgroundColor = RC_BACKGROUND_GRAY;
    self.groupsTableView.delegate = self;
    self.groupsTableView.dataSource = self;
	[self.view addSubview:self.groupsTableView];

}

-(void)logout{
	
	CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromLeft;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	[self.navigationController popViewControllerAnimated:NO];
	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
        cell = [[RCGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

	//	[cell addDataToCell:data];

    //Region *region = [regions objectAtIndex:indexPath.section];
    //TimeZoneWrapper *timeZoneWrapper = [region.timeZoneWrappers objectAtIndex:indexPath.row];
    //cell.textLabel.text = timeZoneWrapper.localeName;
    return cell;
}

// Every cell has a section header so this should be equal to the number of speks returned from the server
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 210;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	[self pushGroupView];
	
}

-(void)pushGroupView{
	
	RCRollCallsViewController *rollCallsViewController = [[RCRollCallsViewController alloc] init];
	[self.navigationController pushViewController:rollCallsViewController animated:YES];
	
}

-(void) receiveAvatarTapNotification:(NSNotification *) notification
{
	RCGroupTableViewCell *cell = (RCGroupTableViewCell *)[notification object];
	NSIndexPath *indexPath = [self.groupsTableView indexPathForCell:cell];
	// This is will be used to push the right group
	
	[self pushGroupView];


}



@end
