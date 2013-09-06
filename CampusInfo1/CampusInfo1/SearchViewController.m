//
//  SearchViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

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
@synthesize _titleNavigationLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    self._searchTypeArray = [[NSArray alloc] initWithObjects:
                         TimeTableTypeKurs, TimeTableTypeDozent, TimeTableTypeStudent,
                         TimeTableTypeRaum, TimeTableTypeKlasse, nil];
    _searchType = TimeTableTypeDozent;
    
    // set picker view
    //self._chooseSearchType.frame = CGRectMake(20.0, 134.0, 140.0, 162.0);
    [_chooseSearchType selectRow:1 inComponent:0 animated:NO];
    
    self._searchTextField.delegate = self;
    
    _students   = [[StudentsDto alloc]init];
    _lecturers  = [[LecturersDto alloc]init];
    _courses    = [[CoursesDto alloc]init];
    _classes    = [[ClassesDto alloc]init];
    _rooms      = [[RoomsDto alloc]init];
    
    _autocomplete = [[Autocomplete alloc] initWithArray:_lecturers._lecturerArray];
	_searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    // set title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToTimeTable:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = SearchVCTitle;
    _titleNavigationItem.title = @"";
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    [_titleNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];

    
    // set segmented control
    [_searchSegmentedControl setTintColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_searchSegmentedControl];
    
    [_segmentedControlNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
}

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

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self loadDataWithSearchType];
    [self setTableWithSearchType];
    
    [self.view addSubview:_acronymAutocompleteTableView];
    [_acronymAutocompleteTableView reloadData];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (void)viewDidUnload
{
    _searchTextField = nil;
    _chooseSearchType = nil;
    _acronymAutocompleteTableView = nil;
    _searchSegmentedControl = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _segmentedControlNavigationBar = nil;
    [super viewDidUnload];
}



// methods for Picker for types
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  // course, room, class, lecturer, student
    return 1;
}

- (NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // course, room, class, lecturer, student
    return [_searchTypeArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self._searchTypeArray objectAtIndex:row];
}

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

- (void)moveBackToTimeTable:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)searchTextFieldChanged:(id)sender
{
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:((UITextField*)sender).text]];
    
    //NSLog(@"_suggestions count: %i", [_suggestions count]);
	
    [self.view addSubview:_acronymAutocompleteTableView];
    _acronymAutocompleteTableView.hidden = NO;
	[_acronymAutocompleteTableView reloadData];
    
}

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
                                              cancelButtonTitle:AlertViewOk
                                              otherButtonTitles:nil];
            
            [_acronymAlertView show];
        }
        else
        {
            // trim space in front of and after the string
            NSString *_stringWithoutSpaces = [_searchTextField.text stringByTrimmingCharactersInSet:
                                              [NSCharacterSet whitespaceAndNewlineCharacterSet]];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchType object:_searchType];
            [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchText object:_stringWithoutSpaces];
            
            //self.tabBarController.selectedIndex = 0;
            [self dismissModalViewControllerAnimated:YES];
        }
        [_searchSegmentedControl setSelectedSegmentIndex:UISegmentedControlNoSegment];

    }
    
}

// handling the search button
- (IBAction)startSearch:(id)sender
{
    if (_searchTextField.text == nil || [_searchTextField.text length] == 0)
    {
        UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                          initWithTitle:SearchVCTitle
                                          message:SearchVCHint
                                          delegate:self
                                          cancelButtonTitle:AlertViewOk
                                          otherButtonTitles:nil];
        
        [_acronymAlertView show];
    }
    else
    {
        // trim space in front of and after the string
        NSString *_stringWithoutSpaces = [_searchTextField.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchType object:_searchType];
        [[NSNotificationCenter defaultCenter] postNotificationName:SettingsVCSearchText object:_stringWithoutSpaces];
        
        //self.tabBarController.selectedIndex = 0;
        [self dismissModalViewControllerAnimated:YES];
    }
    
}

// handling the cancel button
- (IBAction)cancelSearch:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}


//---------- Handling of table for suggestions -----

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
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


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
	
    UIFont *_cellFont = [ UIFont boldSystemFontOfSize: 18.0 ];
    cell.textLabel.font  = _cellFont;
    
	// Configure the cell.
	cell.textLabel.text = [_suggestions objectAtIndex:indexPath.row];
    
    return cell;
}

// set cell hight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 25;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_searchTextField.text = [_suggestions objectAtIndex:indexPath.row];
    _acronymAutocompleteTableView.hidden = YES;
}


@end
