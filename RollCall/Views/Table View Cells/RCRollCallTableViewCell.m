//
//  RCRollCallTableViewCell.m
//  RollCall
//
//  Created by Gabe Jacobs on 7/11/14.
//
//

#define X_PADDIING 10.0f
#define Y_PADDIING 10.0f

#import "RCRollCallTableViewCell.h"
#import "RCPreviewCollectionCell.h"

#import "RCRollCall.h"
#import "RCImage.h"

@interface RCRollCallTableViewCell ()
@property(nonatomic) RCRollCall* rollCall;
@property(nonatomic) NSArray* selfies;
@end

static NSDateFormatter* RCRollCallDateFormatter;

@implementation RCRollCallTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.dateOfCreationLabel = [[UILabel alloc] init];
		self.dateOfCreationLabel.font = [UIFont fontWithName:@"Avenir" size:14];
		self.dateOfCreationLabel.textColor = RC_DARKER_GRAY;
		self.dateOfCreationLabel.text = @"June 28th, 2014 - 3:45 PM";
		[self addSubview:self.dateOfCreationLabel];
		
		self.timeLeftLabel = [[UILabel alloc] init];
		self.timeLeftLabel.font = [UIFont fontWithName:@"Avenir" size:13];
		self.timeLeftLabel.textColor = RC_DARKER_GRAY;
		self.timeLeftLabel.text = @"24 Mins";
		[self addSubview:self.timeLeftLabel];
		
		self.clockIcon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"Clock"]];
		[self addSubview:self.clockIcon];
		
		UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
		[flowLayout setItemSize:CGSizeMake(200, 200)];
		[flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
		
		self.responsesCollectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:flowLayout];
		[self.responsesCollectionView registerClass:[RCPreviewCollectionCell class] forCellWithReuseIdentifier:@"previewCell"];
		
		self.responsesCollectionView.delegate = self;
		self.responsesCollectionView.dataSource = self;
		[self addSubview:self.responsesCollectionView];
		self.responsesCollectionView.backgroundColor = RC_BACKGROUND_GRAY;
		
		UITapGestureRecognizer *tappedPreviewsGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tappedPreviews)];
		[self.responsesCollectionView addGestureRecognizer:tappedPreviewsGesture];
		
		self.blackBar = [[UIView alloc] init];
		self.blackBar.backgroundColor = [UIColor colorWithWhite:0.0 alpha:.6];
		[self addSubview:self.blackBar];
		
		self.rollCallNameLabel = [[UILabel alloc] init];
		self.rollCallNameLabel.font = [UIFont fontWithName:@"Avenir-Medium" size:14];
		self.rollCallNameLabel.textColor = [UIColor whiteColor];
		self.rollCallNameLabel.text = @"Work Sucks";
		self.rollCallNameLabel.textAlignment = NSTextAlignmentCenter;
		[self addSubview:self.rollCallNameLabel];
		
		self.buttonsBar = [[UIImageView alloc] init];
		UIImage *buttonsBarImage = [UIImage imageNamed:@"ButtonsBar"];
		[self.buttonsBar setImage:buttonsBarImage];
		self.buttonsBar.frame = CGRectMake(0, 0, buttonsBarImage.size.width, buttonsBarImage.size.height);
		[self addSubview:self.buttonsBar];
		
		self.collageButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.collageButton addTarget:self action:@selector(showCollage) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.collageButton];
		
		self.mapButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.mapButton addTarget:self action:@selector(showCollage) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.mapButton];
		
		self.shareButton = [UIButton buttonWithType:UIButtonTypeCustom];
		[self.shareButton addTarget:self action:@selector(showCollage) forControlEvents:UIControlEventTouchUpInside];
		[self addSubview:self.shareButton];
		
		self.seperator = [[UIView alloc] init];
		self.seperator.backgroundColor = RC_DARKER_GRAY;
		[self addSubview:self.seperator];
		
    }
    return self;
}

- (void)setupWithRollCall:(RCRollCall *)rollCall {
    self.rollCall = rollCall;
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"created"
                                                                   ascending:YES];
    self.selfies = [[self.rollCall.selfies allObjects] sortedArrayUsingDescriptors:@[sortDescriptor]];
    self.rollCallNameLabel.text = rollCall.title;
    self.dateOfCreationLabel.text = [RCRollCallTableViewCell stringFromDate:rollCall.started];
}

+ (NSString*)stringFromDate:(NSDate*)date {
    if (!RCRollCallDateFormatter) {
        RCRollCallDateFormatter = [[NSDateFormatter alloc] init];
        RCRollCallDateFormatter.dateStyle = NSDateFormatterLongStyle;
        RCRollCallDateFormatter.timeStyle = NSDateFormatterShortStyle;
    }
    return [RCRollCallDateFormatter stringFromDate:date];
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews{
	
	self.dateOfCreationLabel.frame = CGRectMake(X_PADDIING, Y_PADDIING, self.bounds.size.width - 120, 25);
	self.clockIcon.frame = CGRectMake(CGRectGetMaxX(self.dateOfCreationLabel.frame) + 32, Y_PADDIING, self.clockIcon.frame.size.width, self.clockIcon.frame.size.height);
	self.clockIcon.center = CGPointMake(self.clockIcon.center.x, self.dateOfCreationLabel.center.y-1);
	self.timeLeftLabel.frame = CGRectMake(CGRectGetMaxX(self.clockIcon.frame) + 6, Y_PADDIING, 50, 20);
	self.timeLeftLabel.center = CGPointMake(self.timeLeftLabel.center.x, self.dateOfCreationLabel.center.y);
	self.responsesCollectionView.frame = CGRectMake(X_PADDIING, Y_PADDIING + CGRectGetMaxY(self.dateOfCreationLabel.frame), self.frame.size.width - (X_PADDIING * 2), 150);
	self.blackBar.frame = CGRectMake(self.responsesCollectionView.frame.origin.x, CGRectGetMaxY(self.responsesCollectionView.frame) - 30, self.responsesCollectionView.frame.size.width, 30);
	self.rollCallNameLabel.frame = self.blackBar.frame;
	self.buttonsBar.frame = CGRectMake(X_PADDIING, CGRectGetMaxY(self.responsesCollectionView.frame) + Y_PADDIING, self.responsesCollectionView.frame.size.width, self.buttonsBar.frame.size.height);
	self.collageButton.frame = CGRectMake(X_PADDIING+3, self.buttonsBar.frame.origin.y, self.buttonsBar.frame.size.width/3, self.buttonsBar.frame.size.height);
	self.mapButton.frame = CGRectMake(CGRectGetMaxX(self.collageButton.frame) + 5, self.buttonsBar.frame.origin.y, self.buttonsBar.frame.size.width/3 - 15, self.buttonsBar.frame.size.height);
	self.shareButton.frame = CGRectMake(CGRectGetMaxX(self.mapButton.frame) + 5, self.buttonsBar.frame.origin.y, self.buttonsBar.frame.size.width/3, self.buttonsBar.frame.size.height);
	self.seperator.frame = CGRectMake(X_PADDIING*2 , self.frame.size.height - 1 , self.frame.size.width - (X_PADDIING * 4), 1);


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
	return [self.selfies count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
	
    static NSString *cellIdentifier = @"previewCell";
	
    RCPreviewCollectionCell *cell = (RCPreviewCollectionCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
	RCImage* selfie = self.selfies[indexPath.row];
	[cell setImageAtURL:selfie.url];
    return cell;
	
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake(110, 150);
}

-(CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
	
	return 2;
}

//****************************************
//****************************************
#pragma mark - Actions
//****************************************
//****************************************

-(void)showCollage{
	
}

-(void)showMap{
	
}

-(void)shareRollCall{
	
}

//****************************************
//****************************************
#pragma mark - Notifications
//****************************************
//****************************************

-(void)tappedPreviews{
	
	[[NSNotificationCenter defaultCenter]
	 postNotificationName:@"TappedPreviews"
	 object:self];
	
}

@end
