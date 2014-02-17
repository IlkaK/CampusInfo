/*
 ContactsOverViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ContactsOverViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of ContactsOverViewController.xib, which displays a table with which entries the contacts views can be called.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes delegate to ContactsViewController, EmergencyViewController, InformationViewController and ServiceDeskViewController and receives it back from them. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "ContactsOverViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface ContactsOverViewController ()

@end

@implementation ContactsOverViewController

@synthesize _contactsVC;
@synthesize _emergencyVC;
@synthesize _serviceDeskVC;
@synthesize _informationVC;

@synthesize _menuTableView;
@synthesize _menuTableCell;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;

@synthesize _zhawColor;

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
    
    // general initialization
    _zhawColor = [[ColorSelection alloc]init];
    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];

    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = ContactsOverVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleNavigationBar setTintColor:_zhawColor._zhawOriginalBlue];
    
    _titleNavigationBar.barStyle = UIBarStyleBlackTranslucent;
    
    [[UINavigationBar appearance] setBarTintColor: _zhawColor._zhawOriginalBlue];
    
    // set view controllers
    if (_contactsVC == nil)
    {
		_contactsVC = [[ContactsViewController alloc] init];
	}
    _contactsVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_emergencyVC == nil)
    {
		_emergencyVC = [[EmergencyViewController alloc] init];
	}
    _emergencyVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_serviceDeskVC == nil)
    {
		_serviceDeskVC = [[ServiceDeskViewController alloc] init];
	}
    _serviceDeskVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_informationVC == nil)
    {
		_informationVC = [[InformationViewController alloc] init];
	}
    _informationVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
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
    _contactsVC = nil;
    _emergencyVC = nil;
    _menuTableView = nil;
    _menuTableCell = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _serviceDeskVC = nil;
    _informationVC = nil;
    [super viewDidUnload];
}

/*!
 @function moveBackToMenuOverview
 When back button is triggered, delegate is returned to MenuOverviewController.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}


//---------- Handling of table  -----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 4;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if(section == 0)
    {
        return 1;
	}
	else
    {
		return 1;
	}
}


/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    if (_cellSelection == 0)
    {
        [self presentModalViewController:_contactsVC animated:YES];
    }
    if (_cellSelection == 1)
    {
        [self presentModalViewController:_emergencyVC animated:YES];
    }
    if (_cellSelection == 2)
    {
        [self presentModalViewController:_serviceDeskVC animated:YES];
    }
    if (_cellSelection == 3)
    {
        [self presentModalViewController:_informationVC animated:YES];
    }
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellSelection = indexPath.section; //indexPath.section;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [cell.textLabel setTextColor:_zhawColor._zhawFontGrey];
    
    if (_cellSelection == 0)
    {
        cell.textLabel.text = ContactsVCTitle;
    }
    if (_cellSelection == 1)
    {
        cell.textLabel.text = EmergencyVCTitle;
    }
    if (_cellSelection == 2)
    {
        cell.textLabel.text = ServiceDeskVCTitle;
    }
    if (_cellSelection == 3)
    {
        cell.textLabel.text = InformationVCTitle;
    }
    
    return cell;
}


@end
