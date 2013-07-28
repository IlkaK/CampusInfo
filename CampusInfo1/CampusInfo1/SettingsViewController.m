//
//  SettingsViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 13.05.13.
//
//

#import "SettingsViewController.h"

@interface SettingsViewController ()

@end

@implementation SettingsViewController
@synthesize _acronymTextField;
@synthesize _warningLabel;
@synthesize _backToScheduleButton;
@synthesize _acronymAutocompleteTableView;
@synthesize _dbCachingForAutocomplete;
@synthesize _autocomplete;
@synthesize _suggestions;
@synthesize _studentsAndLecturerArray;
@synthesize _studentsAndLecturerArrayFromDB;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _generalDictionary;

@synthesize _translator;

@synthesize _searchType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _translator = [[LanguageTranslation alloc] init];
    
    _studentsAndLecturerArray       = [[NSMutableArray alloc] init];
    _studentsAndLecturerArrayFromDB = [[NSMutableArray alloc] init];
    
    self._acronymTextField.delegate = self;    
    _autocomplete = [[Autocomplete alloc] initWithArray:_studentsAndLecturerArray];
	_acronymTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    self._connectionTrials = 1;
    _generalDictionary = nil;
    
    NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
    _acronymTextField.text                = [_acronymUserDefaults stringForKey:@"TimeTableAcronym"];
    [_backToScheduleButton useAlertStyle];
}


-(void) setAutocompleteCandidatesWithDBUpdate:(BOOL)doDBUpdate
{
    _autocomplete._candidates = _studentsAndLecturerArray;
    if(doDBUpdate && [_studentsAndLecturerArray count] != [_studentsAndLecturerArray count])
    {
        [_dbCachingForAutocomplete storeLecturers:_studentsAndLecturerArray];
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
            
            NSArray      *_generalArrayFromServer = [_generalDictionary objectForKey:generalKey];
            int          _generalArrayFromServerI;
            
            if ([generalKey isEqualToString:@"lecturers"])
            {
                NSDictionary    *_lecturerDictionary;
                NSString        *_lecturerName;
                NSString        *_lecturerShortName;

                
                for (_generalArrayFromServerI = 0; _generalArrayFromServerI < [_generalArrayFromServer count]; _generalArrayFromServerI++)
                {
                    _lecturerDictionary = [_generalArrayFromServer objectAtIndex:_generalArrayFromServerI];
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
                            [_studentsAndLecturerArray addObject:_lecturerShortName];
                        }
                    }
                }
            }
            
            if ([generalKey isEqualToString:@"students"])
            {
                //[_studentsAndLecturerArray removeAllObjects];
                for (_generalArrayFromServerI = 0; _generalArrayFromServerI < [_generalArrayFromServer count]; _generalArrayFromServerI++)
                {
                    NSString *_student = [_generalArrayFromServer objectAtIndex:_generalArrayFromServerI];
                    //NSLog(@"students: %@",_student);
                    [_studentsAndLecturerArray addObject:_student];
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
    NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/schedules/%@/"
                            , _searchType];
    
    NSLog(@"urlString SettingsViewController: %@", _urlString);
    
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
    //if (self._courseArray == nil)
    //{
    self._generalDictionary = nil;
    [_studentsAndLecturerArray removeAllObjects];
    
    self._searchType = @"students";
    self._generalDictionary = [self getDictionaryFromUrl];
    
    //self._searchType = @"lecturers";
    //self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"SearchViewController: no connection");
    }
    //else
    //{
    //    NSLog(@"IF connection established");
    //}
    //}
}





// IMPORTANT, OTHERWISE DATA WILL NOT BE UPDATED, WHEN APP IS STARTED FIRST TIME
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (_connectionTrials < 20  && self._generalDictionary == nil)
    {
        NSLog(@"no connection so get data from database: %i", _connectionTrials);
        _connectionTrials++;
        [self getData];
    }
        
    //_studentsAndLecturerArray       = [_dbCachingForAutocomplete getLecturers];
    //_studentsAndLecturerArrayFromDB = _studentsAndLecturerArray;
        
    [self setAutocompleteCandidatesWithDBUpdate:(NO)];
    [self.view addSubview:_acronymAutocompleteTableView];
    [_acronymAutocompleteTableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self set_acronymTextField:nil];
    _acronymTextField = nil;
    _warningLabel = nil;
    _backToScheduleButton = nil;
    _acronymAutocompleteTableView = nil;
    [super viewDidUnload];
}



- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


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
            _localType = @"Student";
        }
    }
    else
    {
        if ([_newAcronym length] >= 3 && [_newAcronym length] <= 5)
        {
            
            if ([[_newAcronym stringByTrimmingCharactersInSet:alphabecticalSet] isEqualToString: _newAcronym])
            {
                _localType = @"Dozent";
            }
        }
    }
    return _localType;
}


// handling the search button
- (IBAction)moveToTimeTable:(id)sender
{
    NSString *_localAcronym = _acronymTextField.text;
    NSString *_localType    = [self getAcronymType:_localAcronym];
    
    if ([_localType compare: @"empty" ] != NSOrderedSame)
    {
        _warningLabel.text = @"";
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchType" object:_localType];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchText" object:_localAcronym];
        
        NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
        [_acronymUserDefaults setObject:_localAcronym forKey:@"TimeTableAcronym"];
        [_acronymUserDefaults synchronize];
        
        self.tabBarController.selectedIndex = 0;
        [self dismissModalViewControllerAnimated:YES];
    }
    else
    {
        if (_acronymTextField.text == nil || [_acronymTextField.text length] == 0)
        {
            _warningLabel.text = @"Bitte ein Kürzel eingeben.";
        }
        else
        {
            _warningLabel.text = @"Nur Kürzel von Studenten und Dozenten sind möglich.";
        }
    }
}

- (IBAction)acronymTextFieldChanged:(id)sender
{
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:((UITextField*)sender).text]];
	
    NSLog(@"acronymTextFieldChanged -> _studentsAndLecturerArray count: %i",[_studentsAndLecturerArray count]);
    
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
        //NSLog(@"_suggestions: %i", [_suggestions count]);
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
	_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
	[_acronymAutocompleteTableView removeFromSuperview];
}


@end
