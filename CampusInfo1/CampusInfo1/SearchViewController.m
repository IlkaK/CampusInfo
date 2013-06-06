//
//  SearchViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/26/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SearchViewController.h"
#import "TimeTableAsyncRequest.h"

@implementation SearchViewController

@synthesize _chooseSearchType;
@synthesize _searchTextField;
@synthesize _searchTypeArray;
@synthesize _searchType;
@synthesize _searchButton;
@synthesize _acronymAutocompleteTableView;
@synthesize _suggestions;
@synthesize _autocomplete;
@synthesize _classArray, _courseArray, _lecturerArray, _roomArray, _studentArray;

@synthesize _asyncTimeTableRequest;
@synthesize _dataFromUrl;

@synthesize _errorMessage;

@synthesize _connectionTrials;

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
    //_lecturerArray = [NSMutableArray arrayWithObjects:@"huhp", @"rege",nil];
    //_studentArray = [NSMutableArray arrayWithObjects:@"huhp", @"rege",nil];
    //_roomArray     = [NSMutableArray arrayWithObjects:@"TH 567", @"TH 561", @"TP 406", @"TB 610", @"TH 331", nil];
    //_classArray    = [NSMutableArray arrayWithObjects:@"T_AV12b.BA",nil];
    
    _autocomplete = [[Autocomplete alloc] initWithArray:_lecturerArray];
	_searchTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    _connectionTrials = 1;
}

//-------------------------------
// asynchronous request
//-------------------------------

-(void) dataDownloadDidFinish:(NSData*) data {
    
    _dataFromUrl = data;
    
    // NSLog(@"dataDownloadDidFinish 1 %@",[NSThread callStackSymbols]);
    
    NSString *someString = [NSString stringWithFormat:@"%@", _dataFromUrl];
    someString = [someString substringToIndex:100];
    //NSLog(@"dataDownloadDidFinish 2 %@", someString);
}


-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}

-(void) downloadData
{
    NSURL *_url;
    
        _url = [NSURL URLWithString:
                @"https://srv-lab-t-874.zhaw.ch/v1/schedules/lecturers/"];
    
    /*
    {
        
        //NSLog(@"DOWNLOAD DATA ELSE ---type: %@-----acronym: %@ -----",_type, _acronym );
        
        NSString *_scheduleDateString = [[self dayFormatter] stringFromDate:_scheduleDate];
        NSString *_translatedAcronym  = _acronym;
        
        if ([self._type isEqualToString:@"rooms"])
        {
            _translatedAcronym = [_translatedAcronym lowercaseString];
            //NSLog(@"_translatedAcronym: %@", _translatedAcronym);
        }
        
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"(" withString:@"%28"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@")" withString:@"%29"];
        
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"*" withString:@"%2A"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"-" withString:@"%2D"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"." withString:@"%2E"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
        
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
        
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
        
        NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/schedules/%@/%@?startingAt=%@&days=7"
                                , _type
                                , _translatedAcronym
                                , _scheduleDateString];
        
        NSLog(@"_urlString %@",_urlString );
        
        //_translatedAcronym = @"TE%20319";
        // NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/schedules/rooms/%@?startingAt=%@&days=7"
        //                       ,_translatedAcronym
        //                       , _scheduleDateString];
        
        _url       = [NSURL URLWithString:_urlString];
        
    }*/
    
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
    //NSLog(@"2");
    
    //NSLog(@"getDictionaryFromUrl 1 %@",[NSThread callStackSymbols]);
    
    NSString *someString = [NSString stringWithFormat:@"%@", _dataFromUrl];
    NSLog(@"getDictionaryFromUrl data from url %@", someString);
    
    //NSString *someString = [[NSString alloc] initWithData:_dataFromUrl encoding:NSUTF8StringEncoding];
    //NSLog(@"getDictionaryFromUrl %@", someString);
    
    if (_dataFromUrl == nil)
    {
        
        
        NSLog(@"getDictionaryFromUrl NO DATA HERE");
        
        
        //NSMutableData *responseData = [[NSMutableData data] retain];
        //NSURLRequest  *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.102:49619/v1/schedules/musteeri"]];
        //NSURLResponse *response = nil;
        //NSError *error = nil;
        //getting the data
        //NSData *newData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //json parse
        //NSString *responseString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
        //responseString = [responseString substringToIndex:10];
        //NSLog(@"did something :  %@", responseString);
        
        
        
        return nil;
    }
    else
    {
        //NSLog(@"getDictionaryFromUrl got some data putting it now into dictionary");
        NSString *someString = [[NSString alloc] initWithData:_dataFromUrl encoding:NSUTF8StringEncoding];
        NSLog(@"getDictionaryFromUrl 2 %@", someString);
        _scheduleDictionary = [NSJSONSerialization
                               JSONObjectWithData:_dataFromUrl
                               options:kNilOptions
                               error:&_error];
        
    }
    return _scheduleDictionary;
}




// IMPORTANT, OTHERWISE DATA WILL NOT BE UPDATED, WHEN APP IS STARTED FIRST TIME
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self._courseArray == nil)
    {
        _courseArray = [NSMutableArray arrayWithObjects:@"t.PHSAV2-G", @"e",nil];
        _lecturerArray = [NSMutableArray arrayWithObjects:@"huhp", @"rege",nil];
        _studentArray = [NSMutableArray arrayWithObjects:@"huhp", @"rege",nil];
        _roomArray     = [NSMutableArray arrayWithObjects:@"TH 567", @"TH 561", @"TP 406", @"TB 610", @"TH 331", nil];
        _classArray    = [NSMutableArray arrayWithObjects:@"T_AV12b.BA",nil];
        //self._schedule = [[ScheduleDto alloc] initWithAcronym:_actualShownAcronymString:_actualShownAcronymType:_actualDate];
        
        NSDictionary *_scheduleDictionary = nil;
        
        if (_connectionTrials < 20)
        {
            //NSLog(@"viewWillAppear try connecting");
            _connectionTrials++;
        
            _scheduleDictionary = [self getDictionaryFromUrl];
        
            if (_scheduleDictionary == nil)
            {
                NSLog(@"no connection");
            }
            else
            {
                NSLog(@"IF connection established");
                
                for (id scheduleKey in _scheduleDictionary)
                {
                    NSLog(@"scheduleKey:%@",scheduleKey);
                }
            }
        }
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
    
    // set autocomplete text depending on the chosen picker value
    if ([_searchType isEqualToString:@"Kurs"])
    {
        _autocomplete._candidates = _courseArray;
    }
    if ([_searchType isEqualToString:@"Dozent"])
    {
        _autocomplete._candidates = _lecturerArray;
    }
    if ([_searchType isEqualToString:@"Student"])
    {
        _autocomplete._candidates = _studentArray;
    }
    if ([_searchType isEqualToString:@"Raum"])
    {
        _autocomplete._candidates = _roomArray;
    }
    if ([_searchType isEqualToString:@"Klasse"])
    {
        _autocomplete._candidates = _classArray;
    }    
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
