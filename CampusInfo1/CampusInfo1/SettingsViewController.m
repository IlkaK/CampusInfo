/*
 SettingsViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SettingsViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of SettingsViewController.xib, which shows the setting view, where an acronym for the time table can be stored. </li>
 *      <li> Handling storage of a consistent acronym for the time table functionality. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called either form MenuOverviewController or TimeTableOverviewController. But none passes any data. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It stores the chosen acronym in NSNotificationCenter. </li>
 *      <li> The delegate is passed back to TimeTableOverviewController or MenuOverviewController depending on the caller. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "SettingsViewController.h"
#import "UIConstantStrings.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController

@synthesize _acronymTextField;

@synthesize _timetableSettingsTitle;
@synthesize _timetableSettingsDescriptionLabel;

@synthesize _acronymAutocompleteTableView;
@synthesize _autocomplete;
@synthesize _suggestions;

@synthesize _lecturers;
@synthesize _students;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;

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
 * @function prefersStatusBarHidden
 * Used to hide the iOS status bar with time and battery symbol.
 */
-(BOOL) prefersStatusBarHidden
{
    return YES;
}

/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * It is called first time, the view is started for initialization.
 * It is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initializations
    _zhawColor = [[ColorSelection alloc]init];

    _students = [[StudentsDto alloc]init];
    _lecturers = [[LecturersDto alloc]init];

    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMenuOverview:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:NSLocalizedString(@"SettingsVCTitle", nil)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    // set timetable title and description label
    [_timetableSettingsTitle setTextColor:_zhawColor._zhawFontGrey];
    [_timetableSettingsTitle setText:NSLocalizedString(@"SettingsVCTimeTableSettings", nil)];
    [_timetableSettingsDescriptionLabel setTextColor:_zhawColor._zhawFontGrey];
    [_timetableSettingsDescriptionLabel setText:NSLocalizedString(@"SettingsVCTimeTableDescription", nil)];
    
    // set text field
    self._acronymTextField.delegate = self;    
    _autocomplete = [[Autocomplete alloc] initWithArray:_students._studentArray];
	_acronymTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_acronymTextField setTextColor:_zhawColor._zhawFontGrey];
    
    // user defaults and acronym text field
    NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
    _acronymTextField.text                = [_acronymUserDefaults stringForKey:TimeTableAcronym];
    [self._acronymAutocompleteTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

/*!
 * @function addValuesToAutocompleteCandidates
 * Adds lecturers or students to autocomplete candidates which are shown in table.
 */
-(void)addValuesToAutocompleteCandidates
{
    // all values must be summarized in suggestions array
    int countAllValues = [_lecturers._lecturerArray count] + [_students._studentArray count];
    
    //NSLog(@"acronymTextFieldChanged countAllValues: %i lecturers count: %i students count: %i", countAllValues, [_lecturers._lecturerArray count], [_students._studentArray count]);
    
    if (countAllValues > [_autocomplete._candidates count])
    {
        int lecturerArrayI;
        for (lecturerArrayI=0; lecturerArrayI<[_lecturers._lecturerArray count]; lecturerArrayI++)
        {
            //NSLog(@"loop %i lecturer count: %i", lecturerArrayI, [_lecturers._lecturerArray count]);
            [_autocomplete._candidates addObject:[_lecturers._lecturerArray objectAtIndex:lecturerArrayI]];
        }
        
        int studentArrayI;
        for (studentArrayI=0; studentArrayI<[_students._studentArray count]; studentArrayI++)
        {
            [_autocomplete._candidates addObject:[_students._studentArray objectAtIndex:studentArrayI]];
        }
    }
    //NSLog(@"acronymTextFieldChanged autocomplete candidates: %i ", [_autocomplete._candidates count]);
    //NSLog(@"6 lecturers array after: %i", [_lecturers._lecturerArray count]);
}



/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [_students getData];
    [_lecturers getData];
    
    [self addValuesToAutocompleteCandidates];
    
    //NSLog(@"viewWillAppear: 2 _autocomplete._candidates count: %i", [_autocomplete._candidates count]);
    
    [self.view addSubview:_acronymAutocompleteTableView];
    [_acronymAutocompleteTableView reloadData];
}


/*!
 * @function didReceiveMemoryWarning
 * The function is included per default.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload {
    [self set_acronymTextField:nil];
    _acronymTextField = nil;
    _acronymAutocompleteTableView = nil;
    _timetableSettingsTitle = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _timetableSettingsDescriptionLabel = nil;
    [super viewDidUnload];
}

/*!
 @function moveBackToMenuOverview
 Returns the delegate back to TimeTableOverviewController or MenuOverviewController depending on the caller.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
    NSString *_localAcronym = _acronymTextField.text;
    NSString *_localType    = [self getAcronymType:_localAcronym];
    
    if ([_localType compare: @"empty" ] != NSOrderedSame)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchType object:_localType];
        [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchText object:_localAcronym];
        
        NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
        [_acronymUserDefaults setObject:_localAcronym forKey:TimeTableAcronym];
        [_acronymUserDefaults synchronize];
    }
    
    [self dismissModalViewControllerAnimated:YES];
}

/*!
 * @function textFieldShouldReturn
 * The function is included, since the class delegates its textFields on its own. (UITextFieldDelegate)
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}

/*!
 * @function getAcronymType
 * Checks if acronym is of a students or lecturer and sets the acronym type accordingly.
 */
- (NSString *)getAcronymType:(NSString *)_newAcronym
{
    // student : 8 digits, only letters and numbers
    // lecturer: 3-5 digits, only letters
    
    NSString       *_localType = @"empty";
    NSCharacterSet * alphabecticalSet          = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ"] invertedSet];
    NSCharacterSet * alphabecticalAndNumberSet = [[NSCharacterSet characterSetWithCharactersInString:@"abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890"] invertedSet];
    
    if ([_newAcronym length] == 8)
    {
        if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalAndNumberSet] isEqualToString: _newAcronym])
        {
            _localType = NSLocalizedString(@"SettingsVCStudent", nil);
        }
    }
    else
    {
        if ([_newAcronym length] >= 3 && [_newAcronym length] <= 5)
        {
            
            if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalSet] isEqualToString: _newAcronym])
            {
                _localType = NSLocalizedString(@"SettingsVCLecturer", nil);
            }
        }
    }
    return _localType;
}

/*!
 @function acronymTextFieldChanged
 Triggered, when the text in _acronymTextField is changed by the user. Then the table for suggestions needs to be updated accordingly.
 @param sender
 */
- (IBAction)acronymTextFieldChanged:(id)sender
{
    [self addValuesToAutocompleteCandidates];
    
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:((UITextField*)sender).text]];
    
    //NSLog(@"_suggestions count: %i", [_suggestions count]);
	
    [self.view addSubview:_acronymAutocompleteTableView];
    _acronymAutocompleteTableView.hidden = NO;
	[_acronymAutocompleteTableView reloadData];
}



//---------- Handling of table for suggestions -----
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in _acronymAutocompleteTableView.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in _acronymAutocompleteTableView.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_suggestions count] > 5)
    {
        return 5;
    }
    else
    {
        return [_suggestions count];
    }
	return 0;
}


/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells of _acronymAutocompleteTableView.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
    [cell.textLabel setFont:[ UIFont boldSystemFontOfSize: 18.0 ]];
    [cell.textLabel setTextColor:_zhawColor._zhawFontGrey];
    
	// Configure the cell.
	cell.textLabel.text = [_suggestions objectAtIndex:indexPath.row];
    
    return cell;
}

/*!
 * @function heightForRowAtIndexPath
 * The function defines the cells height of _acronymAutocompleteTableView.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection of _acronymAutocompleteTableView.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
    _acronymAutocompleteTableView.hidden = YES;
}


@end
