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

@synthesize _timetableSettingsTitle;
@synthesize _acronymAutocompleteTableView;
@synthesize _autocomplete;
@synthesize _suggestions;

@synthesize _lecturers;
@synthesize _students;

@synthesize _timeTableVC;
@synthesize _menuOverviewVC;

@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationBar;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];
    
    _students = [[StudentsDto alloc]init];
    _lecturers = [[LecturersDto alloc]init];

    self._acronymTextField.delegate = self;    
    _autocomplete = [[Autocomplete alloc] initWithArray:_students._studentArray];
	_acronymTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
    _acronymTextField.text                = [_acronymUserDefaults stringForKey:@"TimeTableAcronym"];

    [self._acronymAutocompleteTableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];    
        
    // ----- TIME TABLE PAGE -----
    if (_timeTableVC == nil)
    {
		_timeTableVC = [[TimeTableOverviewController alloc] init];
	}
    _timeTableVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    if (_menuOverviewVC == nil)
    {
		_menuOverviewVC = [[MenuOverviewController alloc] init];
	}
    _menuOverviewVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMenuOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:[UIColor whiteColor]];
    _titleNavigationLabel.text = @"Einstellungen";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_backgroundColor set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_backgroundColor];
    
}


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



// IMPORTANT, OTHERWISE DATA WILL NOT BE UPDATED, WHEN APP IS STARTED FIRST TIME
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



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self set_acronymTextField:nil];
    _acronymTextField = nil;
    _acronymAutocompleteTableView = nil;
    _timetableSettingsTitle = nil;
    _timeTableVC = nil;
    _menuOverviewVC = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    [super viewDidUnload];
}

- (void)moveBackToMenuOverview:(id)sender
{
    NSString *_localAcronym = _acronymTextField.text;
    NSString *_localType    = [self getAcronymType:_localAcronym];
    
    if ([_localType compare: @"empty" ] != NSOrderedSame)
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchType" object:_localType];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"SearchText" object:_localAcronym];
        
        NSUserDefaults *_acronymUserDefaults = [NSUserDefaults standardUserDefaults];
        [_acronymUserDefaults setObject:_localAcronym forKey:@"TimeTableAcronym"];
        [_acronymUserDefaults synchronize];
    }
    
    [self dismissModalViewControllerAnimated:YES];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
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
    return 20;
}

// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	_acronymTextField.text = [_suggestions objectAtIndex:indexPath.row];
    _acronymAutocompleteTableView.hidden = YES;
}


@end
