/*
 MapsViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MapsViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MapsViewController.xib, which shows the overview of maps which can be chosen. </li>
 *      <li> Gets the delegate from menu overview and passes it on to the seperate maps shown in TechnikumViewController. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called by MenuOverviewController or via back button from TechnikumViewController and only receives the delegate from there. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It only passes the delegate back to MenuOverviewController or to TechnikumViewController. </li>
*      <li> Depending on the chosen table cell, it sets the map file, file format and description for TechnikumViewController.  </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "MapsViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@interface MapsViewController ()

@end

@implementation MapsViewController

@synthesize _technikumVC;

@synthesize _menuTableView;

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
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = MapsVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    [_titleNavigationLabel setTextAlignment:NSTextAlignmentCenter];

    
    // view controller
    if (_technikumVC == nil)
    {
		_technikumVC = [[TechnikumViewController alloc] init];
	}
    _technikumVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
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
 @function moveBackToMenuOverview
 Function is called, when back button on navigation bar is hit, to move back to menu overview.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
   [self dismissModalViewControllerAnimated:YES];
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload
{
    _technikumVC = nil;
    _menuTableView = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    
    [super viewDidUnload];
}


//---------- Handling of table -----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}


/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection of table.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;    
    
    if (_cellSelection == 0)
    {
        _technikumVC._description   = TechnikumVCTitle;
        _technikumVC._fileName      = TechnikumVCFileName;
        _technikumVC._fileFormat    = TechnikumVCFileFormat;
        [self presentModalViewController:_technikumVC animated:YES];
    }
    
    if (_cellSelection == 1)
    {
        _technikumVC._description   = ZurichVCTitle;
        _technikumVC._fileName      = ZurichVCFileName;
        _technikumVC._fileFormat    = ZurichVCFileFormat;
        [self presentModalViewController:_technikumVC animated:YES];
    }
    
    if (_cellSelection == 2)
    {
        _technikumVC._description   = ToessfeldVCTitle;
        _technikumVC._fileName      = ToessfeldVCFileName;
        _technikumVC._fileFormat    = ToessfeldVCFileFormat;
        [self presentModalViewController:_technikumVC animated:YES];
    }
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells of table.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellSelection = indexPath.section; 
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    [cell.textLabel setTextColor:_zhawColor._zhawFontGrey];
    
    if (_cellSelection == 0)
    {
        cell.textLabel.text = MapsVCTechnikum;
    }
    if (_cellSelection == 1)
    {
        cell.textLabel.text = MapsVCZurich;
    }
    if (_cellSelection == 2)
    {
        cell.textLabel.text = MapsVCToessfeld;
    }

    return cell;
}


@end
