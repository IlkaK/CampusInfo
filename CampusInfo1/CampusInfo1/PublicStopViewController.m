/*
 PublicStopViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PublicStopViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of PublicStopViewController.xib, where stations can be searched using autocomplete functionality. </li>
 *      <li> While typing stations, tables shows suggestions for autocomplete. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from PublicTransportViewController and passes it back, if back button is clicked. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the found station back to PublicTransportViewController. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "PublicStopViewController.h"
#import "ColorSelection.h"
#import "StationDto.h"
#import "UIConstantStrings.h"

@interface PublicStopViewController ()

@end

@implementation PublicStopViewController

@synthesize _stationArray;
@synthesize _actualStationType;
@synthesize _actualStationName;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleLabel;
@synthesize _descriptionLabel;

@synthesize _publicStopTableView;

@synthesize _publicStopTextField;
@synthesize _publicStopTextFieldString;

@synthesize _dbCachingForAutocomplete;
@synthesize _autocomplete;
@synthesize _suggestions;

@synthesize _zhawColor;

@synthesize _lastStationButton1;
@synthesize _lastStationButton2;
@synthesize _lastStation1;
@synthesize _lastStation2;

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
 * @function prefersStatusBarHidden
 * Used to hide the iOS status bar with time and battery symbol.
 */
-(BOOL) prefersStatusBarHidden
{
    return YES;
}


/*!
 @function moveBackToPublicTransport
 When back button is triggered, delegate is returned to PublicTransportViewController.
 @param sender
 */
- (void)moveBackToPublicTransport:(id)sender
{    
    _actualStationName = _publicStopTextField.text;
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 @function publicStopTextFieldChanged
 Triggered, when the text in _publicStopTextField is changed by the user. Then the table for suggestions needs to be updated accordingly.
 @param sender
 */
- (IBAction)publicStopTextFieldChanged:(id)sender
{
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:((UITextField*)sender).text]];
    _publicStopTextFieldString = ((UITextField*)sender).text;
    _publicStopTableView.hidden = NO;
    [_publicStopTableView reloadData];
}

- (IBAction)changeToLastStation1:(id)sender
{
    _actualStationName = _lastStationButton1.titleLabel.text;
        [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)changeToLastStation2:(id)sender
{
    _actualStationName = _lastStationButton2.titleLabel.text;
        [self dismissModalViewControllerAnimated:YES];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
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
    
    // handling of autocompletion while using station db
    _dbCachingForAutocomplete = [[DBCachingForAutocomplete alloc]init];
    
    NSMutableArray *_stationDBArray = [_dbCachingForAutocomplete getDBStations];
    //NSLog(@"count db station array: %i", [_stationDBArray count]);
    _autocomplete = [[Autocomplete alloc] initWithArray:_stationDBArray];

    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToPublicTransport:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:@""];
    
    [_titleLabel setTextColor:_zhawColor._zhawWhite];
    [_titleLabel setTextAlignment:NSTextAlignmentCenter];
    [_titleLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize]];
    [_titleLabel setText:PublicTransportVCTitle];
    
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    [_descriptionLabel setTextColor:_zhawColor._zhawWhite];
    [_descriptionLabel setTextAlignment:NSTextAlignmentCenter];
    [_descriptionLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
    [_descriptionLabel setText: PublicTransportVCSearchStop];
    
    
    [_lastStationButton1 setBackgroundImage:[UIImage imageNamed:DateButtonBackground]  forState:UIControlStateNormal];
    [_lastStationButton2 setBackgroundImage:[UIImage imageNamed:DateButtonBackground]  forState:UIControlStateNormal];
    [_lastStationButton1 setTitleColor:_zhawColor._zhawWhite forState:UIControlStateNormal];
    [_lastStationButton2 setTitleColor:_zhawColor._zhawWhite forState:UIControlStateNormal];
    
    // initialize variables/ fields
    self._stationArray = [[StationArrayDto alloc] init:nil];
    _actualStationName = @"";
    
    self._publicStopTextField.delegate = self;
 	_publicStopTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_publicStopTextField setTextColor:_zhawColor._zhawFontGrey];
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
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _actualStationName = @"";
    _publicStopTableView.hidden = YES;
    
    if(_lastStation1.length > 0)
    {
        [_lastStationButton1 setTitle:_lastStation1 forState:UIControlStateNormal];
        [_lastStationButton1 setHidden:NO];
    }
    else
    {
        [_lastStationButton1 setHidden:YES];
    }
    
    if(_lastStation2.length > 0)
    {
        [_lastStationButton2 setTitle:_lastStation2 forState:UIControlStateNormal];
        [_lastStationButton2 setHidden:NO];
    }
    else
    {
        [_lastStationButton2 setHidden:YES];
    }
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload
{
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _publicStopTableView = nil;
    _publicStopTextField = nil;
    [super viewDidUnload];
}


// ------- MANAGE TABLE CELLS ----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_suggestions count];
}

/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _publicStopTextField.text = [_suggestions objectAtIndex:indexPath.row];
    _publicStopTableView.hidden = YES;
    _actualStationName = _publicStopTextField.text;
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_suggestions objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:_zhawColor._zhawFontGrey];
    return cell;
}


@end