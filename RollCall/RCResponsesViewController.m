//
//  RCResponsesViewController.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/16/14.
//
//

#import "RCResponsesViewController.h"
#import "RCThumbnailCollectionCell.h"

@interface RCResponsesViewController ()

@property (nonatomic) UIImageView		*imageView;
@property (nonatomic) UICollectionView	*responsesCollectionView;
@property (nonatomic) UIView			*blackBar;
@property (nonatomic) UILabel			*dateLabel;
@property (nonatomic) UIButton			*heartButton;
@property (nonatomic) NSIndexPath       *selectedCell;

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
	[self.responsesCollectionView registerClass:[RCThumbnailCollectionCell class] forCellWithReuseIdentifier:@"thumbnailCell"];
	
	self.responsesCollectionView.delegate = self;
	self.responsesCollectionView.dataSource = self;
	self.responsesCollectionView.frame = CGRectMake(0, CGRectGetMaxY(self.imageView.frame) + 10, 200, 50);
	self.responsesCollectionView.frame = CGRectMake(self.view.bounds.size.width/2 - self.responsesCollectionView.frame.size.width/2, self.responsesCollectionView.frame.origin.y, 200, 50);

	[self.view addSubview:self.responsesCollectionView];
	self.responsesCollectionView.backgroundColor = [UIColor blackColor];
	
	self.selectedCell = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.responsesCollectionView selectItemAtIndexPath:self.selectedCell animated:NO scrollPosition:UICollectionViewScrollPositionNone];
	
	UITapGestureRecognizer *tappedPreviewsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPreviews)];
	//[self.responsesCollectionView addGestureRecognizer:tappedPreviewsGesture];
    
	self.blackBar= [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.imageView.frame) - 30, self.view.bounds.size.width, 30)];
	self.blackBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.6];
	[self.view addSubview:self.blackBar];
	
	self.dateLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.blackBar.frame.origin.y, 200, self.blackBar.frame.size.height)];
	self.dateLabel.font = [UIFont fontWithName:@"Avenir" size:14.0];
	self.dateLabel.textColor = [UIColor whiteColor];
	self.dateLabel.text = @"June 28th, 2014 at 3:45 PM";
	[self.view addSubview:self.dateLabel];
	
	self.heartButton = [UIButton buttonWithType:UIButtonTypeCustom];
	self.heartButton.frame = CGRectMake(self.view.bounds.size.width - 25, self.blackBar.frame.origin.y, 20, self.blackBar.frame.size.height);
	[self.heartButton setImage:[UIImage imageNamed:@"Heart"] forState:UIControlStateNormal];
	self.heartButton.tag = 0;
	[self.heartButton addTarget:self action:@selector(tappedHeart) forControlEvents:UIControlEventTouchUpInside];
	[self.view addSubview:self.heartButton];
	


	
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)tappedHeart{
	if(self.heartButton.tag == 0){
		[self.heartButton setImage:[UIImage imageNamed:@"RedHeart"] forState:UIControlStateNormal];
		self.heartButton.tag = 1;
	}
	else{
		[self.heartButton setImage:[UIImage imageNamed:@"Heart"] forState:UIControlStateNormal];
		self.heartButton.tag = 0;

	}
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
	
    static NSString *cellIdentifier = @"thumbnailCell";
	
    RCThumbnailCollectionCell *cell = (RCThumbnailCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	
	[cell addDataToCell];
	
	if(self.selectedCell == indexPath){
		[cell hideBlackLayer];
	}
	else{
		[cell unhideBlackLayer];
	}
	
    return cell;
	
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *cellIdentifier = @"thumbnailCell";
	
    RCThumbnailCollectionCell *cell = (RCThumbnailCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
	self.selectedCell = indexPath;
	
	[self.imageView setImage:cell.previewImageView.image];
	[cell hideBlackLayer];
	
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
	
	static NSString *cellIdentifier = @"thumbnailCell";
	
	RCThumbnailCollectionCell *cell = (RCThumbnailCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
	
	[cell unhideBlackLayer];

		
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(40, 50);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	
	return 5;
}


@end
