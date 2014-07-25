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
#import "RCNewGroupViewController.h"
#import "RCGroup.h"

@interface RCGroupsViewController ()

@property (nonatomic) NSArray* groups;
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

- (void)viewDidLoad {
    [super viewDidLoad];
	
	self.view.backgroundColor = RC_BACKGROUND_GRAY;

	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationItem.hidesBackButton = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

	self.title = @"Groups";
    
    _groups = [NSArray array];
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								  initWithTitle: @""
								  style: UIBarButtonItemStyleBordered
								  target: self action: @selector(logout)];
	
	UIBarButtonItem *newGroupButton = [[UIBarButtonItem alloc]
								   initWithTitle: @""
								   style: UIBarButtonItemStyleBordered
								   target: self action: @selector(newGroup)];
	
	backButton.image = [UIImage imageNamed:@"Back"];
	newGroupButton.image = [UIImage imageNamed:@"Plus"];

	// TAKE THIS AWAY ONCE WE HAVE A LOGOUT METHOD
	
	self.navigationItem.leftBarButtonItem = backButton;
	self.navigationItem.rightBarButtonItem = newGroupButton;

	self.groupsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, 10, self.view.bounds.size.width - 20, self.view.bounds.size.height - 73)];
	self.groupsTableView.separatorColor = [UIColor clearColor];
    self.groupsTableView.backgroundColor = RC_BACKGROUND_GRAY;
    self.groupsTableView.delegate = self;
    self.groupsTableView.dataSource = self;
	[self.view addSubview:self.groupsTableView];
    
    [self loadData];
}

-(void)logout {
	
	CATransition *transition = [CATransition animation];
	transition.duration = 0.25;
	transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	transition.type = kCATransitionPush;
	transition.subtype = kCATransitionFromLeft;
	[self.navigationController.view.layer addAnimation:transition forKey:nil];
	[self.navigationController popViewControllerAnimated:NO];
}

- (void)loadData {
    [RCGroup getGroupsWithSuccessBlock:^(NSArray *groups) {
        self.groups = groups;
        [self reloadTableData];
    } failureBlock:^(NSError *error) {
        NSLog(@"Error: %@", error);
    }];
}

- (void)reloadTableData {
    [self.groupsTableView performSelectorOnMainThread:@selector(reloadData)
                                           withObject:nil
                                        waitUntilDone:NO];
}

-(void)newGroup{
	
	RCNewGroupViewController *newGroupController = [[RCNewGroupViewController alloc] init];
	
	[self.navigationController pushViewController:newGroupController animated:YES];

	
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
    RCGroupTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:MyIdentifier];
    if (cell == nil) {
        cell = [[RCGroupTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;

    RCGroup* group = self.groups[indexPath.row];
    [cell setupCellWithGroup:group];
	
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.groups.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 80;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	RCGroup* group = self.groups[indexPath.row];
	[self pushGroup:group];
	
}

- (void)pushGroup:(RCGroup*)group{
	
	RCRollCallsViewController *rollCallsViewController = [[RCRollCallsViewController alloc] init];
	[rollCallsViewController setGroup:group];
	[self.navigationController pushViewController:rollCallsViewController animated:YES];
	
}




@end
