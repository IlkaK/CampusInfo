/*
 MenuOverviewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MenuOverviewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MenuOverviewController.xib, which shows all menu items. </li>
 *      <li> Menu items are shown in a table. </li>
 *      <li> Delegate is passed to clicked item in menu. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class does not receive any data, but the delegate, when the back button is clicked in one of the menu items. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> This class does not pass any data, but the delegate. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "MenuOverviewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface MenuOverviewController ()

@end

@implementation MenuOverviewController
@synthesize _menuCollectionView;

@synthesize _backgroundColor;
@synthesize _zhawColor;

@synthesize _contactsVC;
@synthesize _settingsVC;
@synthesize _newsVC;
@synthesize _eventsVC;
@synthesize _publicTransportVC;
@synthesize _mapsVC;
@synthesize _socialMediaVC;


/*!
 * @function initWithNibName
 * Initializiation of class.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}



/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    _zhawColor = [[ColorSelection alloc]init];
    _backgroundColor = _zhawColor._zhawOriginalBlue;
    
    [self.view setBackgroundColor:_backgroundColor];
    
    UINib *cellNib = [UINib nibWithNibName:@"MenuOverviewCollectionCell" bundle:nil];
    [self._menuCollectionView registerNib:cellNib forCellWithReuseIdentifier:@"MenuOverviewCollectionCell"];
    
    UINib *reusableViewNib = [UINib nibWithNibName:@"MenuOverviewCollectionReusableView" bundle:nil];
    [self._menuCollectionView registerNib:reusableViewNib forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MenuOverviewCollectionReusableView"];
    
    [_menuCollectionView setBackgroundColor:_backgroundColor];
    
    
    if (_contactsVC == nil)
    {
		_contactsVC = [[ContactsViewController alloc] init];
	}
    _contactsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_settingsVC == nil)
    {
		_settingsVC = [[SettingsViewController alloc] init];
	}
    _settingsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
  
    if (_newsVC == nil)
    {
		_newsVC = [[NewsViewController alloc] init];
	}
    _newsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_eventsVC == nil)
    {
		_eventsVC = [[EventsViewController alloc] init];
	}
    _eventsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_publicTransportVC == nil)
    {
		_publicTransportVC = [[PublicTransportViewController alloc] init];
	}
    _publicTransportVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    if (_mapsVC == nil)
    {
		_mapsVC = [[MapsViewController alloc] init];
	}
    _mapsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_socialMediaVC == nil)
    {
		_socialMediaVC = [[SocialMediaViewController alloc] init];
	}
    _socialMediaVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

}

/*!
 * @function didReceiveMemoryWarning
 * The function is included per default.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload
{
    _contactsVC = nil;
    _settingsVC = nil;
    _newsVC = nil;
    _eventsVC = nil;
    _publicTransportVC = nil;    
    _mapsVC = nil;
    _socialMediaVC = nil;
    [super viewDidUnload];
}

/*!
 * @function moveToTimeTable
 * The function passes the delgate to TimeTableOverviewController.
 */
-(void) moveToTimeTable:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 1;
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 * @function moveToMensa
 * The function passes the delgate to MensaViewController.
 */
-(void) moveToMensa:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 2;
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 * @function moveToOev
 * The function passes the delgate to PublicTransportViewController.
 */
-(void) moveToOev:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 3;
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 * @function moveToContacts
 * The function passes the delgate to ContactsOverViewController.
 */
-(void) moveToContacts:(id)sender event:(id)event
{
    self.tabBarController.selectedIndex = 4;
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 * @function moveToNews
 * The function passes the delgate to NewsViewController.
 */
-(void) moveToNews:(id)sender event:(id)event
{
   [self presentModalViewController:_newsVC animated:YES];
}

/*!
 * @function moveToEvents
 * The function passes the delgate to EventsViewController.
 */
-(void) moveToEvents:(id)sender event:(id)event
{
    [self presentModalViewController:_eventsVC animated:YES];
}

/*!
 * @function moveToSocialMedia
 * The function passes the delgate to SocialMediaViewController.
 */
-(void) moveToSocialMedia:(id)sender event:(id)event
{
    [self presentModalViewController:_socialMediaVC animated:YES];
}

/*!
 * @function moveToSettings
 * The function passes the delgate to SettingsViewController.
 */
-(void) moveToSettings:(id)sender event:(id)event
{
    [self presentModalViewController:_settingsVC animated:YES];
}

/*!
 * @function moveToMaps
 * The function passes the delgate to MapsViewController.
 */
-(void) moveToMaps:(id)sender event:(id)event
{
    [self presentModalViewController:_mapsVC animated:YES];
}




// ------- MANAGE COLLECTION CELLS ----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in collectionView.
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

/*!
 * @function numberOfItemsInSection
 * The function defines the number of items in each section in collectionView.
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 3;
}

/*!
 * @function viewForSupplementaryElementOfKind
 * The function sets header line in each section of the colleciton view.
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *reusableview = nil;
    
    if (kind == UICollectionElementKindSectionHeader)
    {
        UICollectionReusableView *headerView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"MenuOverviewCollectionReusableView" forIndexPath:indexPath];
        
        UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
        line.backgroundColor = _zhawColor._zhawWhite;
        [headerView addSubview:line];
        
        reusableview = headerView;
    }
    return reusableview;
}

/*!
 * @function cellForItemAtIndexPath
 * The function is for customizing the collection view cells.
 * According to the position of the cell the given view is called.
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellRow = indexPath.section;
    NSUInteger        _cellTab = indexPath.item;
    
    NSString         *_cellIdentifier   = @"MenuOverviewCollectionCell";
    UICollectionViewCell *_cell         = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    
    [_cell setBackgroundColor:_backgroundColor];
    _cell.contentView.backgroundColor = _backgroundColor;
    UIButton *_iconButton = (UIButton *) [_cell viewWithTag:1];
    _iconButton.enabled = true;
    
    // customizing each cell according to its position
    if (_cellRow == 0)
    {
        if (_cellTab == 0)
        {
            // time table
            [_iconButton addTarget:self action:@selector(moveToTimeTable:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconTimeTable] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconTimeTableFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconTimeTableFeedback] forState:UIControlStateHighlighted];
        }
        if (_cellTab == 1)
        {
            // mensa
            [_iconButton addTarget:self action:@selector(moveToMensa:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconMensa] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconMensaFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconMensaFeedback] forState:UIControlStateHighlighted];
        }
        if (_cellTab == 2)
        {
            //OeV
            [_iconButton addTarget:self action:@selector(moveToOev:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconPublicTransport] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconPublicTransportFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconPublicTransportFeedback] forState:UIControlStateHighlighted];
        }
    }
    
    if (_cellRow == 1)
    {
        if (_cellTab == 0)
        {
            // contact
            [_iconButton addTarget:self action:@selector(moveToContacts:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconContacts] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconContactsFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconContactsFeedback] forState:UIControlStateHighlighted];
        }
        if (_cellTab == 1)
        {
            // card
            [_iconButton addTarget:self action:@selector(moveToMaps:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconMaps] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconMapsFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconMapsFeedback] forState:UIControlStateHighlighted];
        }
        if (_cellTab == 2)
        {
            // social Media
            [_iconButton addTarget:self action:@selector(moveToSocialMedia:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconSocialMedia] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconSocialMediaFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconSocialMediaFeedback] forState:UIControlStateHighlighted];
        }
    }
    
    if (_cellRow == 2)
    {
        if (_cellTab == 0)
        {
            // settings
            [_iconButton addTarget:self action:@selector(moveToSettings:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconSettings] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconSettingsFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconSettingsFeedback] forState:UIControlStateHighlighted];
        }
        if (_cellTab == 1)
        {
            // news
            [_iconButton addTarget:self action:@selector(moveToNews:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconNews] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconNewsFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconNewsFeedback] forState:UIControlStateHighlighted];
        }
        if (_cellTab == 2)
        {
            // events
            [_iconButton addTarget:self action:@selector(moveToEvents:event:) forControlEvents:UIControlEventTouchUpInside];
            [_iconButton setImage:[UIImage imageNamed:AppIconEvents] forState:UIControlStateNormal];
            [_iconButton setImage:[UIImage imageNamed:AppIconEventsFeedback] forState:UIControlStateSelected];
            [_iconButton setImage:[UIImage imageNamed:AppIconEventsFeedback] forState:UIControlStateHighlighted];
        }
    }
    return _cell;
}


@end
