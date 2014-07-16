//
//  RCRollCallsViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#import "RCRollCallsViewController.h"
#import "RCRollCallTableViewCell.h"
#import "RCResponsesViewController.h"

@interface RCRollCallsViewController ()

@property (nonatomic) UITableView* rollCallsTableView;
@property (nonatomic) UIButton*	   startRollCallButton;


@end

@implementation RCRollCallsViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self
												 selector:@selector(receivePreviewTapNotification:)
													 name:@"TappedPreviews"
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
	
	self.title = @"Roll Call iOS Dev Team";
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle: @""
								   style: UIBarButtonItemStyleBordered
								   target: self action: @selector(goBack)];
	
	backButton.image = [UIImage imageNamed:@"Back"];
	
	self.navigationItem.leftBarButtonItem = backButton;
	
	self.startRollCallButton = [UIButton buttonWithType:UIButtonTypeCustom];
	UIImage *startCallImage = [UIImage imageNamed:@"StartCall"];
	[self.startRollCallButton setImage:startCallImage forState:UIControlStateNormal];
	self.startRollCallButton.frame = CGRectMake(self.view.bounds.size.width/2 - startCallImage.size.width/2, 10, startCallImage.size.width, startCallImage.size.height);
	[self.view addSubview:self.startRollCallButton];

	self.rollCallsTableView = [[UITableView alloc] initWithFrame:CGRectMake(10, CGRectGetMaxY(self.startRollCallButton.frame) + 10, self.view.bounds.size.width - 20, self.view.bounds.size.height - 10)];
	self.rollCallsTableView.separatorColor = [UIColor clearColor];
    self.rollCallsTableView.backgroundColor = RC_BACKGROUND_GRAY;
    self.rollCallsTableView.delegate = self;
    self.rollCallsTableView.dataSource = self;
	[self.view addSubview:self.rollCallsTableView];}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//****************************************
//****************************************
#pragma mark - Navigation
//****************************************
//****************************************

-(void)goBack{
	[self.navigationController popViewControllerAnimated:YES];
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
        cell = [[RCRollCallTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault  reuseIdentifier:MyIdentifier];
    }
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	
	//	[cell addDataToCell:data];
	
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	return 260;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
	
	[self pushResponsesView];
	
}

- (void)pushResponsesView{
	
	RCResponsesViewController *responsesViewController = [[RCResponsesViewController alloc] init];
	[self.navigationController pushViewController:responsesViewController animated:YES];
	
}


- (void)receivePreviewTapNotification:(NSNotification *) notification {
	RCRollCallsViewController *cell = (RCRollCallsViewController *)[notification object];
	NSIndexPath *indexPath = [self.rollCallsTableView indexPathForCell:cell];
	// This is will be used to push the right group
	
	[self pushResponsesView];
	
	
}



@end
