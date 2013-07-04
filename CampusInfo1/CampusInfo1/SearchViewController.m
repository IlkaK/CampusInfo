//
//  SearchViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "TimeTableAsyncRequest.h"
#import "DBCachingForAutocomplete.h"

@implementation SearchViewController

@synthesize _chooseSearchType;
@synthesize _searchTextField;
@synthesize _searchTypeArray;
@synthesize _searchType;
@synthesize _searchButton;
@synthesize _acronymAutocompleteTableView;
@synthesize _suggestions;
@synthesize _autocomplete;
@synthesize _classArray;
@synthesize _courseArray;
@synthesize _lecturerArray;
@synthesize _lecturerArrayFromDB;
@synthesize _roomArray;
@synthesize _roomArrayFromDB;
@synthesize _studentArray;


@synthesize _generalDictionary;

@synthesize _asyncTimeTableRequest;
@synthesize _dataFromUrl;

@synthesize _errorMessage;

@synthesize _connectionTrials;

@synthesize _dbCachingForAutocomplete;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];    
    self._searchTypeArray = [[NSArray alloc] initWithObjects:
                         @"Kurs", @"Dozent", @"Student",
                         @"Raum", @"Klasse", nil];
    _searchType = @"Dozent";
    
    // set picker view
    //self._chooseSearchType.frame = CGRectMake(20.0, 134.0, 140.0, 162.0);
    [_chooseSearchType selectRow:1 inComponent:0 animated:NO];
    
    self._searchTextField.delegate = self;
    [_searchButton useAlertStyle];
    
    //_courseArray = [NSMutableArray arrayWithObjects:@"t.PHSAV2-G", @"e",nil];
    //_studentArray = [NSMutableArray arrayWithObjects:@"huhp", @"rege",nil];
    //_classArray    = [NSMutableArray arrayWithObjects:@"T_AV12b.BA",nil];
    
    _lecturerArray       = [[NSMutableArray alloc] init];
    _lecturerArrayFromDB = [[NSMutableArray alloc] init];
    _roomArray           = [[NSMutableArray alloc] init];
    _roomArrayFromDB     = [[NSMutableArray alloc] init];
    
    _autocomplete = [[Autocomplete alloc] initWithArray:_lecturerArray];
	_searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _connectionTrials = 1;
    _generalDictionary = nil;
    
    _dbCachingForAutocomplete = [[DBCachingForAutocomplete alloc]init];
}


-(void) setAutocompleteCandidatesWithDBUpdate:(BOOL)doDBUpdate
{
    if ([_searchType isEqualToString:@"Kurs"])
    {
        _autocomplete._candidates = _courseArray;
    }
    if ([_searchType isEqualToString:@"Dozent"])
    {
        _autocomplete._candidates = _lecturerArray;
        
        if(doDBUpdate && [_lecturerArrayFromDB count] != [_lecturerArray count])
        {
            [_dbCachingForAutocomplete storeLecturers:_lecturerArray];
        }
    }
    if ([_searchType isEqualToString:@"Student"])
    {
        _autocomplete._candidates = _studentArray;
    }
    if ([_searchType isEqualToString:@"Raum"])
    {
        _autocomplete._candidates = _roomArray;
        
        if(doDBUpdate && [_roomArrayFromDB count] != [_roomArray count])
        {
            [_dbCachingForAutocomplete storeRooms:_roomArray];
        }
    }
    if ([_searchType isEqualToString:@"Klasse"])
    {
        _autocomplete._candidates = _classArray;
    }
}


//-------------------------------
// asynchronous request
//-------------------------------

-(void) dataDownloadDidFinish:(NSData*) data
{
    
    self._dataFromUrl = data;
    
    // NSLog(@"dataDownloadDidFinish 1 %@",[NSThread callStackSymbols]);
    
    if (self._dataFromUrl != nil)
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:100];
        //NSLog(@"dataDownloadDidFinish FOR SEARCHVIEWCONTROLLER %@", _receivedString);
        
        NSError *_error;
        
        //if (_generalDictionary == nil)
        //{
            _generalDictionary = [NSJSONSerialization
                               JSONObjectWithData:_dataFromUrl
                               options:kNilOptions
                               error:&_error];
        
            for (id generalKey in _generalDictionary)
            {
                NSLog(@"generalKey:%@",generalKey);
                
                if ([generalKey isEqualToString:@"lecturers"])
                {
                
                    NSArray      *_lecturerArrayFromServer = [_generalDictionary objectForKey:generalKey];
                    NSDictionary *_lecturerDictionary;
                    NSString *_lecturerName;
                    NSString *_lecturerShortName;
                    [_lecturerArray removeAllObjects];
                
                    int lecturerArrayI;
                    for (lecturerArrayI = 0; lecturerArrayI < [_lecturerArrayFromServer count]; lecturerArrayI++)
                    {
                        _lecturerDictionary = [_lecturerArrayFromServer objectAtIndex:lecturerArrayI];
                    
                        for (id lecturerKey in _lecturerDictionary)
                        {
                            if ([lecturerKey isEqualToString:@"name"])
                            {
                                _lecturerName = [_lecturerDictionary objectForKey:lecturerKey];
                                //NSLog(@"lecturer name: %@", _lecturerName);
                            }
                        
                            if ([lecturerKey isEqualToString:@"shortName"])
                            {
                                _lecturerShortName = [_lecturerDictionary objectForKey:lecturerKey];
                                //NSLog(@"lecturer shortName: %@", _lecturerShortName);
                                [_lecturerArray addObject:_lecturerShortName];
                            }
                        }
                    }
                    
                }
                if ([generalKey isEqualToString:@"rooms"])
                {
                    NSArray      *_roomArrayFromServer = [_generalDictionary objectForKey:generalKey];
                    NSString     *_roomName;
                    [_roomArray removeAllObjects];
                    int roomArrayI;
                    for (roomArrayI = 0; roomArrayI < [_roomArrayFromServer count]; roomArrayI++)
                    {
                        _roomName = [_roomArrayFromServer objectAtIndex:roomArrayI];
                        [_roomArray addObject:_roomName];
                    }
                    
                }
                [self setAutocompleteCandidatesWithDBUpdate:(NO)];
            }
        //}
    }
}


-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}


-(void) downloadData
{
    NSString *_localTranslation;
    
    if ([_searchType isEqualToString:@"Klasse"])
    {
        _localTranslation = @"classes";
    }
    if ([_searchType isEqualToString:@"Student"])
    {
        _localTranslation = @"students";
    }
    if ([_searchType isEqualToString:@"Raum"])
    {
        _localTranslation = @"rooms";
    }
    if ([_searchType isEqualToString:@"Dozent"])
    {
        _localTranslation = @"lecturers";
    }
    if ([_searchType isEqualToString:@"Kurs"])
    {
        _localTranslation = @"courses";
    }
    
    NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/schedules/%@/"
                            , _localTranslation];
    
    NSLog(@"urlString: %@", _urlString);
    
    NSURL *_url = [NSURL URLWithString:_urlString];
    [_asyncTimeTableRequest downloadData:_url];
}


- (NSDictionary *) getDictionaryFromUrl
{
    
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    
    NSError      *_error = nil;
    NSDictionary *_scheduleDictionary;
    
    if (_dataFromUrl == nil)
    {        
        return nil;
    }
    else
    {
        //NSLog(@"getDictionaryFromUrl got some data putting it now into dictionary");
        _scheduleDictionary = [NSJSONSerialization
                               JSONObjectWithData:_dataFromUrl
                               options:kNilOptions
                               error:&_error];
        
    }
    return _scheduleDictionary;
}


-(void) getData
{
    if (self._courseArray == nil)
    {
        self._generalDictionary = nil;
        
        self._generalDictionary = [self getDictionaryFromUrl];
            
        if (self._generalDictionary == nil)
        {
            NSLog(@"no connection");
        }
        else
        {
            NSLog(@"IF connection established");
        }
    }
}





// IMPORTANT, OTHERWISE DATA WILL NOT BE UPDATED, WHEN APP IS STARTED FIRST TIME
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getData];
    
    if (self._generalDictionary == nil)
    {
        [_lecturerArray removeAllObjects];
        [_roomArray removeAllObjects];

        NSLog(@"no connection so get data from database");
        _lecturerArray = [_dbCachingForAutocomplete getLecturers];
        _lecturerArrayFromDB = _lecturerArray;
        _roomArray     = [_dbCachingForAutocomplete getRooms];
        _roomArrayFromDB = _roomArray;
        
        [self setAutocompleteCandidatesWithDBUpdate:(NO)];
        [self.view addSubview:_acronymAutocompleteTableView];
        [_acronymAutocompleteTableView reloadData];
    }
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
    _searchButton = nil;
    _acronymAutocompleteTableView = nil;
    [super viewDidUnload];
}



// methods for Picker for types
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  // course, room, class, teacher, student
    return 1;
}

- (NSInteger)pickerView: (UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    // course, room, class, teacher, student
    return [_searchTypeArray count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self._searchTypeArray objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row
      inComponent:(NSInteger)component
{
    _searchType = [_searchTypeArray objectAtIndex:row];
    [self getData];
    
    [self setAutocompleteCandidatesWithDBUpdate:(YES)];
}


// handling the search button
- (IBAction)_startSearch:(id)sender
{
    if (_searchTextField.text == nil || [_searchTextField.text length] == 0)
    {
        UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                          initWithTitle:@"Suche"
                                          message:@"Bitte ein Kürzel eingeben."
                                          delegate:self
                                          cancelButtonTitle:@"OK"
                                          otherButtonTitles:nil];
        
        [_acronymAlertView show];
    }
    else
    {
        // trim space in front of and after the string
        NSString *_stringWithoutSpaces = [_searchTextField.text stringByTrimmingCharactersInSet:
                                          [NSCharacterSet whitespaceAndNewlineCharacterSet]];
    
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchType" object:_searchType];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchText" object:_stringWithoutSpaces];
    
        self.tabBarController.selectedIndex = 0;
        [self dismissModalViewControllerAnimated:YES];
    }
}

- (IBAction)searchTextFieldChanged:(id)sender
{
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:((UITextField*)sender).text]];
	
	[self.view addSubview:_acronymAutocompleteTableView];
	[_acronymAutocompleteTableView reloadData];
    
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
		return [_suggestions count];
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
	
    UIFont *_cellFont = [ UIFont boldSystemFontOfSize: 12.0 ];
    cell.textLabel.font  = _cellFont;
    
	// Configure the cell.
	cell.textLabel.text = [_suggestions objectAtIndex:indexPath.row];
    
    return cell;
}

// set cell hight
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 20;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_searchTextField.text = [_suggestions objectAtIndex:indexPath.row];
	[_acronymAutocompleteTableView removeFromSuperview];
}


@end
