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

@synthesize _noConnectionButton;
@synthesize _noConnectionLabel;

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
    [self getStationArray];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorSelection *_zhawColors = [[ColorSelection alloc]init];
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToPublicTransport:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:[UIColor whiteColor]];
    _titleNavigationLabel.text = @"ÖV-Fahrplan";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColors._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_zhawColors._zhawOriginalBlue];
    
    self._stationArray = [[StationArrayDto alloc] init:nil];
    
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    [_noConnectionButton useAlertStyle];
    
    _actualStation = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) getStationArray
{
    
    //[NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
    
    [_stationArray getData:@"Winter"];
    
    //[_waitForChangeActivityIndicator stopAnimating];
    //_waitForChangeActivityIndicator.hidden = YES;
    
    if ([_stationArray._stations count] == 0)
    {
        _noConnectionButton.hidden = NO;
        _noConnectionLabel.hidden = NO;
    }
    else
    {
        _noConnectionButton.hidden = YES;
        _noConnectionLabel.hidden = YES;
        [_publicStopTableView reloadData];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _actualStation = nil;
    [self getStationArray];    
}

- (void)viewDidUnload
{
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _publicStopTableView = nil;
    _noConnectionLabel = nil;
    _noConnectionButton = nil;
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
