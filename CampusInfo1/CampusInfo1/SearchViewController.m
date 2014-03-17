/*
 SearchViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SearchViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of SearchView.xib, which shows the search view for the time table </li>
 *      <li> Triggering and handling search for acronym of students, lecturers, courses, rooms, classes </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> This class is called from TimeTableOverviewController, which does not send any data to SearchViewController. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data (when the back button is hit):
 *   <ul>
 *      <li> the searched acronym and acronym type are stored in NSNotificationCenter </li>
 *      <li> the delegate is passed back to TimeTableOverviewController, which then can access the NSNotificationCenter to get the data. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "SearchViewController.h"
#import "TimeTableAsyncRequest.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@implementation SearchViewController

@synthesize _chooseSearchType;
@synthesize _searchTextField;
@synthesize _searchTypeArray;
@synthesize _searchType;

@synthesize _acronymAutocompleteTableView;
@synthesize _suggestions;
@synthesize _autocomplete;

@synthesize _searchSegmentedControl;
@synthesize _segmentedControlNavigationBar;

@synthesize _students;
@synthesize _lecturers;
@synthesize _classes;
@synthesize _courses;
@synthesize _rooms;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;

@synthesize _waitForChangeActivityIndicator;

@synthesize _zhawColor;


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
    
    self._searchTypeArray = [[NSArray alloc] initWithObjects:
                         TimeTableTypeKurs, TimeTableTypeDozent, TimeTableTypeStudent,
                         TimeTableTypeRaum, TimeTableTypeKlasse, nil];
    _searchType = TimeTableTypeDozent;
    
    _students   = [[StudentsDto alloc]init];
    _lecturers  = [[LecturersDto alloc]init];
    _courses    = [[CoursesDto alloc]init];
    _classes    = [[ClassesDto alloc]init];
    _rooms      = [[RoomsDto alloc]init];
    
    
    // set title
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToTimeTable:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:SearchVCTitle];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    // segmented controls
    [self.view bringSubviewToFront:_searchSegmentedControl];
    [_searchSegmentedControl setBackgroundImage:[UIImage imageNamed:SegmentedControlBackground] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [_searchSegmentedControl setTitleTextAttributes:@{
                                                          NSForegroundColorAttributeName : _zhawColor._zhawWhite,
                                                          UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                          UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize],
                                                          }
                                               forState:UIControlStateNormal];
    
    // set picker view
    [_chooseSearchType selectRow:1 inComponent:0 animated:NO];
    
    // set text field
    self._searchTextField.delegate = self;
    _searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_searchTextField setTextColor:_zhawColor._zhawFontGrey];
    
    _autocomplete = [[Autocomplete alloc] initWithArray:_lecturers._lecturerArray];
	

    // set activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
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
 * @function loadDataWithSearchType
 * Gets the data of the according class for the given type.
 */
-(void)loadDataWithSearchType
{
    if ([_searchType isEqualToString:TimeTableTypeKurs])
    {
        [_courses getData];
    }
    if ([_searchType isEqualToString:TimeTableTypeDozent])
    {
        [_lecturers getData];
    }
    if ([_searchType isEqualToString:TimeTableTypeStudent])
    {
        [_students getData];
    }
    if ([_searchType isEqualToString:TimeTableTypeRaum])
    {
        [_rooms getData];
    }
    if ([_searchType isEqualToString:TimeTableTypeKlasse])
    {
        [_classes getData];
    }
}

/*!
 * @function setTableWithSearchType
 * Sets the autocomplete candate list with the data of the given type.
 */
-(void) setTableWithSearchType
{
    if ([_searchType isEqualToString:TimeTableTypeKurs])
    {
        _autocomplete._candidates = _courses._courseArray;
    }
    if ([_searchType isEqualToString:TimeTableTypeDozent])
    {
        _autocomplete._candidates = _lecturers._lecturerArray;
    }
    if ([_searchType isEqualToString:TimeTableTypeStudent])
    {
        _autocomplete._candidates = _students._studentArray;
    }
    if ([_searchType isEqualToString:TimeTableTypeRaum])
    {
        _autocomplete._candidates = _rooms._roomArray;
    }
    if ([_searchType isEqualToString:TimeTableTypeKlasse])
    {
        _autocomplete._candidates = _classes._classArray;
    }
}

/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController. 
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadDataWithSearchType];
    [self setTableWithSearchType];
    
    [self.view addSubview:_acronymAutocompleteTableView];
    [_acronymAutocompleteTableView reloadData];
}

/*!
 * @function threadWaitForChangeActivityIndicator
 * Thread is called to start the activity indicator while waiting for data to be downloaded.
 */
- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}

/*!
 * @function textFieldShouldReturn
 * The function is included, since the class delegates its textFields on its own. (UITextFieldDelegate)
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

/*!
 * @function shouldAutorotateToInterfaceOrientation
 * Supports autorotation.
 */
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
- (void)viewDidUnload
{
    _searchTextField = nil;
    _chooseSearchType = nil;
    _acronymAutocompleteTableView = nil;
    _searchSegmentedControl = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _segmentedControlNavigationBar = nil;
    _waitForChangeActivityIndicator = nil;
    [super viewDidUnload];
}


/*!
 * @function numberOfComponentsInPickerView
 * The function is included, since the class delegates its pickerViews on its own. (UIPickerViewDelegate,UIPickerViewDataSource)
 */
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  // course, room, class, lecturer, student
    return 1;
}

/*!
 * @function pickerView:numberOfRowsInComponent
 * The function is included, since the class delegates its pickerViews on its own. (UIPickerViewDelegate,UIPickerViewDataSource)
 */
- (NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // course, room, class, lecturer, student
    return [_searchTypeArray count];
}

/*!
 * @function pickerView:titleForRow
 * The function is included, since the class delegates its pickerViews on its own. (UIPickerViewDelegate,UIPickerViewDataSource)
 */
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self._searchTypeArray objectAtIndex:row];
}

/*!
 * @function pickerView:didSelectRow
 * The function is included, since the class delegates its pickerViews on its own. (UIPickerViewDelegate,UIPickerViewDataSource)
 * Updates the suggestions and the autocomplete table, if the value of the picker changed.
 */
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    _acronymAutocompleteTableView.hidden = YES;
    _searchType = [_searchTypeArray objectAtIndex:row];
    [self loadDataWithSearchType];
    [self setTableWithSearchType];
    
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:_searchTextField.text]];
    [self.view addSubview:_acronymAutocompleteTableView];
    _acronymAutocompleteTableView.hidden = NO;
	[_acronymAutocompleteTableView reloadData];
}

/*!
 * @function moveBackToTimeTable
 * If delegate is given back to TimeTableOverviewController the new type and acronym are set, while activity indicator is running until this is done.
 */
- (void)moveBackToTimeTable:(id)sender
{
    if (_searchTextField.text == nil || [_searchTextField.text length] == 0)
    {
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
        
        // trim space in front of and after the string
        NSString *_stringWithoutSpaces = [_searchTextField.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchType object:_searchType];
        [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchText object:_stringWithoutSpaces];
        
        [_waitForChangeActivityIndicator stopAnimating];
        _waitForChangeActivityIndicator.hidden = YES;
        
        [self dismissModalViewControllerAnimated:YES];
    }
}

/*!
 @function searchTextFieldChanged
 Triggered, when the text in _searchTextField is changed by the user. Then the table for suggestions needs to be updated accordingly.
 */
- (IBAction)searchTextFieldChanged:(id)sender
{
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:((UITextField*)sender).text]];
    
    //NSLog(@"_suggestions count: %i", [_suggestions count]);
	
    [self.view addSubview:_acronymAutocompleteTableView];
    _acronymAutocompleteTableView.hidden = NO;
	[_acronymAutocompleteTableView reloadData];
    
}

/*!
 @function moveToSearchSegmentedControl
 Controls the segmented control buttons to cancel or confirm the searched acronym.
 */
- (IBAction)moveToSearchSegmentedControl:(id)sender
{
    // cancel
    if(_searchSegmentedControl.selectedSegmentIndex == 0)
    {
        [_searchSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];
        [self dismissModalViewControllerAnimated:YES];
    }
    
    // done
    if(_searchSegmentedControl.selectedSegmentIndex == 1)
    {

        if (_searchTextField.text == nil || [_searchTextField.text length] == 0)
        {
            UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                              initWithTitle:SearchVCTitle
                                              message:SearchVCHint
                                              delegate:self
                                              cancelButtonTitle:NSLocalizedString(@"AlertViewOk", nil)
                                              otherButtonTitles:nil];
            
            [_acronymAlertView show];
        }
        else
        {
            [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
            
            // trim space in front of and after the string
            NSString *_stringWithoutSpaces = [_searchTextField.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchType object:_searchType];
            [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchText object:_stringWithoutSpaces];
            
            [_waitForChangeActivityIndicator stopAnimating];
            _waitForChangeActivityIndicator.hidden = YES;
            
            [self dismissModalViewControllerAnimated:YES];
        }
        [_searchSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];

    }
    
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

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in _acronymAutocompleteTableView.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (_suggestions)
	{
        if ([_suggestions count] > 5)
        {
            return 5;
        }
        else
        {
            return [_suggestions count];
        }
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
    
    [cell.textLabel setTextColor:_zhawColor._zhawFontGrey];
    [cell.textLabel setFont:[ UIFont boldSystemFontOfSize: 18.0 ]];
    
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
    return 25;
}

/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection of _acronymAutocompleteTableView.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_searchTextField.text = [_suggestions objectAtIndex:indexPath.row];
    _acronymAutocompleteTableView.hidden = YES;
}


@end
