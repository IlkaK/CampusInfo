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
@synthesize _menuTableView;
@synthesize _menuOverviewTableCell;

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
    // set table controller
    if (_menuTableView == nil) {
		_menuTableView = [[UITableView alloc] init];
	}
    
    _zhawColor = [[ColorSelection alloc]init];
    _backgroundColor = _zhawColor._zhawOriginalBlue;
    
    [_menuTableView setSeparatorColor:[UIColor clearColor]];
    _menuTableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    _menuTableView.scrollEnabled = NO;
    
    [self.view setBackgroundColor:_backgroundColor];
    [_menuTableView setBackgroundColor:_backgroundColor];
    
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
- (void)viewDidUnload {
    _menuTableView = nil;    
    _contactsVC = nil;
    _settingsVC = nil;
    _newsVC = nil;
    _eventsVC = nil;
    _publicTransportVC = nil;    
    _mapsVC = nil;
    _socialMediaVC = nil;
    
    _menuOverviewTableCell = nil;
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




// ------- MANAGE TABLE CELLS ----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in _acronymAutocompleteTableView.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in _acronymAutocompleteTableView.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

/*!
 * @function heightForRowAtIndexPath
 * The function is for customizing the table view cells.
 * It sets the height for each cell individually.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}


/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 * According to the number of time slots and rooms (scheduleEvents) the cell methods are called.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSString         *_cellIdentifier;
    UITableViewCell  *_cell = nil;

    _cellIdentifier  = @"MenuOverviewTableCell";
    _cell            = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MenuOverviewTableCell" owner:self options:nil];
        _cell = _menuOverviewTableCell;
        self._menuOverviewTableCell = nil;
    }
    
    // put a line above each cell
    UIImageView *line = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 320, 1)];
    line.backgroundColor = _zhawColor._zhawWhite;
    [_cell addSubview:line];    
    
    if (_cellSelection == 0)
    {
        // time table
        UIButton *_timeTableIconButton  = (UIButton *) [_cell viewWithTag:1];
        _timeTableIconButton.enabled = true;
        [_timeTableIconButton addTarget:self action:@selector(moveToTimeTable:event:) forControlEvents:UIControlEventTouchUpInside];
        [_timeTableIconButton setImage:[UIImage imageNamed:AppIconTimeTable] forState:UIControlStateNormal];
        [_timeTableIconButton setImage:[UIImage imageNamed:AppIconTimeTableFeedback] forState:UIControlStateSelected];
        [_timeTableIconButton setImage:[UIImage imageNamed:AppIconTimeTableFeedback] forState:UIControlStateHighlighted];
        
        // mensa
        UIButton *_mensaIconButton  = (UIButton *) [_cell viewWithTag:2];
        _mensaIconButton.enabled = true;
        [_mensaIconButton addTarget:self action:@selector(moveToMensa:event:) forControlEvents:UIControlEventTouchUpInside];
        [_mensaIconButton setImage:[UIImage imageNamed:AppIconMensa] forState:UIControlStateNormal];
        [_mensaIconButton setImage:[UIImage imageNamed:AppIconMensaFeedback] forState:UIControlStateSelected];
        [_mensaIconButton setImage:[UIImage imageNamed:AppIconMensaFeedback] forState:UIControlStateHighlighted];
        
        //OeV
        UIButton *_oevIconButton  = (UIButton *) [_cell viewWithTag:3];
        _oevIconButton.enabled = true;
        [_oevIconButton addTarget:self action:@selector(moveToOev:event:) forControlEvents:UIControlEventTouchUpInside];
        [_oevIconButton setImage:[UIImage imageNamed:AppIconPublicTransport] forState:UIControlStateNormal];
        [_oevIconButton setImage:[UIImage imageNamed:AppIconPublicTransportFeedback] forState:UIControlStateSelected];
        [_oevIconButton setImage:[UIImage imageNamed:AppIconPublicTransportFeedback] forState:UIControlStateHighlighted];
        
        _cell.contentView.backgroundColor = _backgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellSelection == 1)
    {

        // contact
        UIButton *_contactsIconButton  = (UIButton *) [_cell viewWithTag:1];
        _contactsIconButton.enabled = true;
        [_contactsIconButton addTarget:self action:@selector(moveToContacts:event:) forControlEvents:UIControlEventTouchUpInside];
        [_contactsIconButton setImage:[UIImage imageNamed:AppIconContacts] forState:UIControlStateNormal];
        [_contactsIconButton setImage:[UIImage imageNamed:AppIconContactsFeedback] forState:UIControlStateSelected];
        [_contactsIconButton setImage:[UIImage imageNamed:AppIconContactsFeedback] forState:UIControlStateHighlighted];

        // card
        UIButton *_cardIconButton  = (UIButton *) [_cell viewWithTag:2];
        _cardIconButton.enabled = true;
        [_cardIconButton addTarget:self action:@selector(moveToMaps:event:) forControlEvents:UIControlEventTouchUpInside];
        [_cardIconButton setImage:[UIImage imageNamed:AppIconMaps] forState:UIControlStateNormal];
        [_cardIconButton setImage:[UIImage imageNamed:AppIconMapsFeedback] forState:UIControlStateSelected];
        [_cardIconButton setImage:[UIImage imageNamed:AppIconMapsFeedback] forState:UIControlStateHighlighted];

        // social Media
        UIButton *_socialMediaIconButton  = (UIButton *) [_cell viewWithTag:3];
        _socialMediaIconButton.enabled = true;
        [_socialMediaIconButton addTarget:self action:@selector(moveToSocialMedia:event:) forControlEvents:UIControlEventTouchUpInside];
        [_socialMediaIconButton setImage:[UIImage imageNamed:AppIconSocialMedia] forState:UIControlStateNormal];
        [_socialMediaIconButton setImage:[UIImage imageNamed:AppIconSocialMediaFeedback] forState:UIControlStateSelected];
        [_socialMediaIconButton setImage:[UIImage imageNamed:AppIconSocialMediaFeedback] forState:UIControlStateHighlighted];
        
        _cell.contentView.backgroundColor = _backgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    if (_cellSelection == 2)
    {
        // settings
        UIButton *_settingsIconButton  = (UIButton *) [_cell viewWithTag:1];
        _settingsIconButton.enabled = true;
        [_settingsIconButton addTarget:self action:@selector(moveToSettings:event:) forControlEvents:UIControlEventTouchUpInside];
        [_settingsIconButton setImage:[UIImage imageNamed:AppIconSettings] forState:UIControlStateNormal];
        [_settingsIconButton setImage:[UIImage imageNamed:AppIconSettingsFeedback] forState:UIControlStateSelected];
        [_settingsIconButton setImage:[UIImage imageNamed:AppIconSettingsFeedback] forState:UIControlStateHighlighted];
        
        // news
        UIButton *_newsIconButton  = (UIButton *) [_cell viewWithTag:2];
        _newsIconButton.enabled = true;
        [_newsIconButton addTarget:self action:@selector(moveToNews:event:) forControlEvents:UIControlEventTouchUpInside];
        [_newsIconButton setImage:[UIImage imageNamed:AppIconNews] forState:UIControlStateNormal];
        [_newsIconButton setImage:[UIImage imageNamed:AppIconNewsFeedback] forState:UIControlStateSelected];
        [_newsIconButton setImage:[UIImage imageNamed:AppIconNewsFeedback] forState:UIControlStateHighlighted];
        
        // events
        UIButton *_eventsIconButton  = (UIButton *) [_cell viewWithTag:3];
        _eventsIconButton.enabled = true;
        [_eventsIconButton addTarget:self action:@selector(moveToEvents:event:) forControlEvents:UIControlEventTouchUpInside];
        [_eventsIconButton setImage:[UIImage imageNamed:AppIconEvents] forState:UIControlStateNormal];
        [_eventsIconButton setImage:[UIImage imageNamed:AppIconEventsFeedback] forState:UIControlStateSelected];
        [_eventsIconButton setImage:[UIImage imageNamed:AppIconEventsFeedback] forState:UIControlStateHighlighted];
        
        _cell.contentView.backgroundColor = _backgroundColor;
        _cell.backgroundColor = _cell.contentView.backgroundColor;
        _cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    //NSLog(@"_cellSelection: %i", _cellSelection);
    return _cell;
}


@end
