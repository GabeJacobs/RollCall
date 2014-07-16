//
//  RCResponsesViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/16/14.
//
//

#import "RCResponsesViewController.h"
#import "RCPreviewCollectionCell.h"

@interface RCResponsesViewController ()

@property (nonatomic) UIImageView		*imageView;
@property (nonatomic) UICollectionView	*responsesCollectionView;

@end

@implementation RCResponsesViewController

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
	
	self.view.backgroundColor = [UIColor blackColor];
	
	[self.navigationController setNavigationBarHidden:NO animated:YES];
	self.navigationItem.hidesBackButton = YES;
	self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
	
	self.title = @"Work Sucks";
	
	UIBarButtonItem *backButton = [[UIBarButtonItem alloc]
								   initWithTitle: @""
								   style: UIBarButtonItemStyleBordered
								   target: self action: @selector(goBack)];
	
	backButton.image = [UIImage imageNamed:@"Back"];
	
	self.navigationItem.leftBarButtonItem = backButton;
	
	self.imageView = [[UIImageView alloc] init];
	self.imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 430);
	[self.imageView setImage:[UIImage imageNamed:@"bigPlaceholder"]];
	[self.view addSubview:self.imageView];
	
	UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
	[flowLayout setItemSize:CGSizeMake(20, 30)];
	[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
	
	self.responsesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
	[self.responsesCollectionView registerClass:[RCPreviewCollectionCell class] forCellWithReuseIdentifier:@"previewCell"];
	
	self.responsesCollectionView.delegate = self;
	self.responsesCollectionView.dataSource = self;
	self.responsesCollectionView.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 10, 200, 50);
	self.responsesCollectionView.frame = CGRectMake(self.view.bounds.size.width/2 - self.responsesCollectionView.frame.size.width/2, self.responsesCollectionView.frame.origin.y, 200, 50);

	[self.view addSubview:self.responsesCollectionView];
	self.responsesCollectionView.backgroundColor = [UIColor blackColor];
	
	UITapGestureRecognizer *tappedPreviewsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPreviews)];
	//[self.responsesCollectionView addGestureRecognizer:tappedPreviewsGesture];
    
}

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
#pragma mark - UICollectionView Datasource/Delegate
//****************************************
//****************************************

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
	return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *cellIdentifier = @"previewCell";
	
    RCPreviewCollectionCell *cell = (RCPreviewCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	
	[cell addDataToCell];
    return cell;
	
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(40, 50);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	
	return 5;
}


@end
