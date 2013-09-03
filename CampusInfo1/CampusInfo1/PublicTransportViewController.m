//
//  PublicTransportViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 14.08.13.
//
//

#import "PublicTransportViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"
#import "ConnectionDto.h"

@interface PublicTransportViewController ()
@end

@implementation PublicTransportViewController

@synthesize _publicTransportNavigationBar;
@synthesize _publicTransportNavigationItem;
@synthesize _publicTransportNavigationLabel;

@synthesize _fromButton;
@synthesize _searchButton;
@synthesize _toButton;

@synthesize _pubilcTransportOverviewTableCell;
@synthesize _publicTransportTableView;

@synthesize _publicStopVC;

@synthesize _connectionArray;
@synthesize _dateFormatter;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void) moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    _connectionArray = [[ConnectionArrayDto alloc]init:nil];
    _dateFormatter = [[DateFormation alloc] init];
    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_publicTransportNavigationItem setLeftBarButtonItem :backButtonItem animated :true];

    
    [_publicTransportNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _publicTransportNavigationLabel.text = PublicTransportVCTitle;
    _publicTransportNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _publicTransportNavigationBar.frame.size.width, _publicTransportNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_publicTransportNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_publicTransportNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
    
    [_fromButton useAlertStyle];
    [_toButton useAlertStyle];
    [_searchButton useAlertStyle];
    
    if (_publicStopVC == nil)
    {
		_publicStopVC = [[PublicStopViewController alloc] init];
	}
    _publicStopVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(_publicStopVC._actualStation != nil)
    {
        NSString *_stationName =  _publicStopVC._actualStation._name;
        //NSLog(@"actual Station: %@",_stationName);
        if ([_publicStopVC._actualStationType isEqualToString:@"to"])
        {
            [_toButton setTitle:_stationName forState:UIControlStateNormal];
        }
        else
        {
            [_fromButton setTitle:_stationName forState:UIControlStateNormal];
        }
        
    }
    [self getConnectionArray];
}

- (void) getConnectionArray
{
    
    //[NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
    

    
    //[_waitForChangeActivityIndicator stopAnimating];
    //_waitForChangeActivityIndicator.hidden = YES;
    
    if ([_connectionArray._connections count] == 0)
    {
        [_connectionArray getData];
        
        //_noConnectionButton.hidden = NO;
        //_noConnectionLabel.hidden = NO;
    //}
    //else
    //{
        //_noConnectionButton.hidden = YES;
        //_noConnectionLabel.hidden = YES;

    }
    [_publicTransportTableView reloadData];
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)viewDidUnload
{
    _publicTransportNavigationBar = nil;
    _publicTransportNavigationItem = nil;
    _publicTransportNavigationLabel = nil;
    _fromButton = nil;
    _toButton = nil;
    _searchButton = nil;
    _pubilcTransportOverviewTableCell = nil;
    _publicStopVC = nil;
    _publicTransportTableView = nil;
    [super viewDidUnload];
}


- (IBAction)moveToFromStopController:(id)sender
{
    _publicStopVC._actualStationType = @"from";

    //NSLog(@"to button title: %@", _fromButton.titleLabel.text);
    _publicStopVC._publicStopTextFieldString = _fromButton.titleLabel.text;
    [self presentModalViewController:_publicStopVC animated:YES];
}

- (IBAction)moveToToStopController:(id)sender
{
    _publicStopVC._actualStationType = @"to";
    
    //NSLog(@"to button title: %@", _toButton.titleLabel.text);
    _publicStopVC._publicStopTextFieldString = _toButton.titleLabel.text;
    [self presentModalViewController:_publicStopVC animated:YES];
}

- (IBAction)startConnectionSearch:(id)sender
{
    [self getConnectionArray];
}


// needed for table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"numberOfRowsInSection connection count: %i", [_connectionArray._connections count]);
    return [_connectionArray._connections count] + 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellRow = indexPath.row;
    static NSString *_cellIdentifier = @"PublicTransportOverviewTableCell";
    UITableViewCell *_cell           = [tableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"PublicTransportOverviewTableCell" owner:self options:nil];
        _cell = _pubilcTransportOverviewTableCell;
        self._pubilcTransportOverviewTableCell = nil;
    }
    
    UILabel          *_startLabel           = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_startDateLabel       = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_startTimeLabel       = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_durationLabel        = (UILabel  *)[_cell viewWithTag:4];
    UILabel          *_transfersLabel       = (UILabel  *)[_cell viewWithTag:5];
    UILabel          *_transportationLabel  = (UILabel  *)[_cell viewWithTag:6];
    UILabel          *_stopLabel            = (UILabel  *)[_cell viewWithTag:7];
    UILabel          *_stopDateLabel        = (UILabel  *)[_cell viewWithTag:8];
    UILabel          *_stopTimeLabel        = (UILabel  *)[_cell viewWithTag:9];

    
    NSLog(@" cellForRowAtIndexPath - connection count: %i _cellRow: %i", [_connectionArray._connections count], _cellRow);
    
    // title row
    if (_cellRow == 0)
    {
        _startLabel.text            = @"Bahnhof, Haltestelle";
        _startDateLabel.text        = @"Datum";
        _startTimeLabel.text        = @"Zeit";
        _durationLabel.text         = @"Dauer";
        _transfersLabel.text        = @"U.";
        _transportationLabel.text   = @"Reise mit";
        _stopLabel.text             = @"";
        _stopDateLabel.text         = @"";
        _stopTimeLabel.text         = @"";
    }
    else
    {
        _cellRow = _cellRow-1;
        if (    [_connectionArray._connections lastObject] != nil
            &&  [_connectionArray._connections count] > _cellRow)
        {
            ConnectionDto *_localConnection = [_connectionArray._connections objectAtIndex:_cellRow];
            
            _startLabel.text        = _localConnection._from._station._name;
            _startDateLabel.text    = [[_dateFormatter _dayFormatter] stringFromDate:_localConnection._from._departureDate];
            _startTimeLabel.text    = [NSString stringWithFormat:@"ab %@", [[_dateFormatter _timeFormatter] stringFromDate:_localConnection._from._departureTime]];
            
            _durationLabel.text     = _localConnection._duration;
            _transfersLabel.text    = [NSString stringWithFormat:@"%i",_localConnection._transfers];
            
            
            int _productsArrayI;
            NSString *_productsString;
            for (_productsArrayI=0; _productsArrayI < [_localConnection._products count]; _productsArrayI++)
            {
                NSString *_oneProduct = [_localConnection._products objectAtIndex:_productsArrayI];
                if (_productsArrayI > 0)
                {   
                    _productsString = [NSString stringWithFormat:@"%@, %@",_productsString, _oneProduct];
                }
                else
                {
                    _productsString = [NSString stringWithFormat:@"%@",_oneProduct];
                }
            }
            _transportationLabel.text = _productsString;
            
            _stopLabel.text       = _localConnection._to._station._name;
            _stopDateLabel.text   = [[_dateFormatter _dayFormatter] stringFromDate:_localConnection._to._arrivalDate];
            _stopTimeLabel.text   = [NSString stringWithFormat:@"an %@", [[_dateFormatter _timeFormatter] stringFromDate:_localConnection._to._arrivalTime]];
        }
    }
        
    return _cell;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSUInteger    _cellSelection = indexPath.section;
    
}


@end
