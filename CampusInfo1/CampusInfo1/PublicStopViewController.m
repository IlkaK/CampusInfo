//
//  PublicStopViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

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
@synthesize _titleNavigationLabel;

@synthesize _publicStopTableView;

@synthesize _publicStopTextField;
@synthesize _publicStopTextFieldString;

@synthesize _dbCachingForAutocomplete;
@synthesize _autocomplete;
@synthesize _suggestions;

@synthesize _zhawColors;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)moveBackToPublicTransport:(id)sender
{    
    _actualStationName = _publicStopTextField.text;
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)publicStopTextFieldChanged:(id)sender
{
    _suggestions = [[NSMutableArray alloc] initWithArray:[_autocomplete GetSuggestions:((UITextField*)sender).text]];
    _publicStopTextFieldString = ((UITextField*)sender).text;
    _publicStopTableView.hidden = NO;
    [_publicStopTableView reloadData];
}


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return NO;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initialization
    _zhawColors = [[ColorSelection alloc]init];
    
    // handling of autocompletion while using station db
    _dbCachingForAutocomplete = [[DBCachingForAutocomplete alloc]init];
    
    NSMutableArray *_stationDBArray = [_dbCachingForAutocomplete getDBStations];
    //NSLog(@"count db station array: %i", [_stationDBArray count]);
    _autocomplete = [[Autocomplete alloc] initWithArray:_stationDBArray];

    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToPublicTransport:)];
    
    [backButtonItem setTintColor:_zhawColors._zhawOriginalBlue];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:[UIColor whiteColor]];
    _titleNavigationLabel.text = PublicTransportVCTitle;
    _titleNavigationItem.title = @"";
    
    [_titleNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    [_titleNavigationBar setTintColor:_zhawColors._zhawDarkerBlue];
    
    self._stationArray = [[StationArrayDto alloc] init:nil];
    
    _actualStationName = @"";
    
    self._publicStopTextField.delegate = self;
 	_publicStopTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    [_publicStopTextField setTextColor:_zhawColors._zhawFontGrey];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _actualStationName = @"";
    _publicStopTableView.hidden = YES;

}

- (void)viewDidUnload
{
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _publicStopTableView = nil;
    _publicStopTextField = nil;
    [super viewDidUnload];
}


//---------- Handling of menu table -----
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_suggestions count];
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _publicStopTextField.text = [_suggestions objectAtIndex:indexPath.row];
    _publicStopTableView.hidden = YES;
    _actualStationName = _publicStopTextField.text;
    [self dismissModalViewControllerAnimated:YES];
    
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.textLabel.text = [_suggestions objectAtIndex:indexPath.row];
    [cell.textLabel setTextColor:_zhawColors._zhawFontGrey];
    return cell;
}



@end
