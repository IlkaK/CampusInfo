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
@synthesize _actualStation;
@synthesize _actualStationType;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationLabel;

@synthesize _publicStopTableView;
@synthesize _actualizeButton;

@synthesize _publicStopTextField;
@synthesize _publicStopTextFieldString;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}

- (void)moveBackToPublicTransport:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
}

- (IBAction)tryConnectionAgain:(id)sender
{
    [self getStationArray:_publicStopTextFieldString];
}

- (IBAction)actualizeSuggestions:(id)sender
{
    NSLog(@"_publicStopTextFieldString: %@", _publicStopTextFieldString);
    //_stationArray = nil;
    [self getStationArray:_publicStopTextFieldString];
    [_publicStopTableView reloadData];
}

- (IBAction)publicStopTextFieldChanged:(id)sender
{
    _publicStopTextFieldString = ((UITextField*)sender).text;
    
    [self getStationArray:_publicStopTextFieldString];
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
    
    ColorSelection *_zhawColors = [[ColorSelection alloc]init];
    
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
    
    [_actualizeButton useAlertStyle];
    
    _actualStation = nil;
    
    self._publicStopTextField.delegate = self;
 	_publicStopTextField.autocorrectionType = UITextAutocorrectionTypeNo;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) getStationArray:(NSString *)proposalStation
{
    
    //[NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
    
    [_stationArray getData:proposalStation];
    
    //[_waitForChangeActivityIndicator stopAnimating];
    //_waitForChangeActivityIndicator.hidden = YES;
    
    [_publicStopTableView reloadData];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _actualStation = nil;
    
    
    _publicStopTableView.hidden = YES;

    
    
}

- (void)viewDidUnload
{
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _publicStopTableView = nil;
    _publicStopTextField = nil;
    _actualizeButton = nil;
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
    return [_stationArray._stations count];
}


// Override to support row selection in the table view.
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellRow = indexPath.row;
    
    if (    [_stationArray._stations lastObject] != nil
        &&  [_stationArray._stations count] > _cellRow)
    {
        StationDto *_localStation = [_stationArray._stations objectAtIndex:_cellRow];
        _actualStation = _localStation;
        [self dismissModalViewControllerAnimated:YES];
    }
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSUInteger        _cellSelection = indexPath.row; //indexPath.section;
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
	{
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (    [_stationArray._stations lastObject] != nil
        &&  [_stationArray._stations count] > _cellSelection)
    {
        StationDto *_localStation = [_stationArray._stations objectAtIndex:_cellSelection];
        cell.textLabel.text = _localStation._name;
    }
        
    return cell;
}



@end
