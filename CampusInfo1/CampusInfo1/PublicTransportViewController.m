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

@synthesize _pubilcTransportOverviewTableCell;
@synthesize _publicTransportTableView;

@synthesize _publicStopVC;

@synthesize _connectionArray;
@synthesize _dateFormatter;

@synthesize _startStation;
@synthesize _stopStation;
@synthesize _changedStartStation;
@synthesize _changedStopStation;

@synthesize _dbCachingForAutocomplete;
@synthesize _storedStartStationArray;
@synthesize _storedStopStationArray;

@synthesize _startLabel;
@synthesize _changeStartButtonIsActivated;
@synthesize _lastStart1Button;
@synthesize _lastStart2Button;
@synthesize _chooseNewStartButton;

@synthesize _stopLabel;
@synthesize _changeStopButtonIsActivated;
@synthesize _lastStop1Button;
@synthesize _lastStop2Button;
@synthesize _chooseNewStopButton;

@synthesize _searchButton;

@synthesize _waitForChangeActivityIndicator;

@synthesize _showStart1;

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
    
    // general initialization
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    _connectionArray = [[ConnectionArrayDto alloc]init:nil];
    _dateFormatter = [[DateFormation alloc] init];
    _dbCachingForAutocomplete = [[DBCachingForAutocomplete alloc]init];
    
    _changeStartButtonIsActivated = NO;
    _changeStopButtonIsActivated = NO;
    _changedStartStation = NO;
    _changedStopStation = NO;
    
    // title
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStylePlain target:self action:@selector(moveBackToMenuOverview:)];
    
    [backButtonItem setTintColor:_zhawColor._zhawOriginalBlue];
    [_publicTransportNavigationItem setLeftBarButtonItem :backButtonItem animated :true];

    
    [_publicTransportNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _publicTransportNavigationLabel.text = PublicTransportVCTitle;
    _publicTransportNavigationItem.title = @"";
    
    [_publicTransportNavigationLabel setTextAlignment:UITextAlignmentCenter];
    
    [_publicTransportNavigationBar setTintColor:_zhawColor._zhawDarkerBlue];
    
    [_searchButton useAlertStyle];
    
    if (_publicStopVC == nil)
    {
		_publicStopVC = [[PublicStopViewController alloc] init];
	}
    _publicStopVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self actualizeStartStationArray];
    
    
    
    // set start/stop buttons with last results
    [self.view bringSubviewToFront:_lastStart1Button];
    [self.view bringSubviewToFront:_lastStart2Button];
    [self.view bringSubviewToFront:_chooseNewStartButton];

    [self.view bringSubviewToFront:_lastStop1Button];
    [self.view bringSubviewToFront:_lastStop2Button];
    [self.view bringSubviewToFront:_chooseNewStopButton];
    
    _lastStart1Button.hidden        = YES;
    _lastStart2Button.hidden        = YES;
    _chooseNewStartButton.hidden    = YES;

    _lastStop1Button.hidden        = YES;
    _lastStop2Button.hidden        = YES;
    _chooseNewStopButton.hidden    = YES;
    
    NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:@"neu..."];
    [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
    //[_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawDarkGrey range:NSMakeRange(0, [_titleString length])];
    
    [_chooseNewStartButton  setAttributedTitle:_titleString forState:UIControlStateNormal];
    [_chooseNewStopButton   setAttributedTitle:_titleString forState:UIControlStateNormal];

    // set default values for spinner/activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
}


- (void)actualizeStartStationArray
{
    _storedStartStationArray = [_dbCachingForAutocomplete getStartStations];
    if([_storedStartStationArray count] >= 3)
    {
        _startLabel.text = [_storedStartStationArray objectAtIndex:2];
        _startStation = [_storedStartStationArray objectAtIndex:2];
        [_lastStart1Button setTitle:[_storedStartStationArray objectAtIndex:1] forState:UIControlStateNormal];
        [_lastStart2Button setTitle:[_storedStartStationArray objectAtIndex:0] forState:UIControlStateNormal];
    }
    else
    {        
        if([_storedStartStationArray count] == 2)
        {
            _startLabel.text = [_storedStartStationArray objectAtIndex:1];
            _startStation = [_storedStartStationArray objectAtIndex:1];
            [_lastStart1Button setTitle:[_storedStartStationArray objectAtIndex:0] forState:UIControlStateNormal];
            [_lastStart2Button setTitle:@"" forState:UIControlStateNormal];
        }
        else
        {
            if([_storedStartStationArray count] == 1)
            {
                _startLabel.text = [_storedStartStationArray objectAtIndex:0];
                _startStation = [_storedStartStationArray objectAtIndex:0];
            }
        }
    }
}


- (void)actualizeStopStationArray
{
    _storedStopStationArray  = [_dbCachingForAutocomplete getStopStations];

    if([_storedStopStationArray count] >= 1)
    {
        _stopLabel.text = [_storedStopStationArray objectAtIndex:0];
        _stopStation = [_storedStopStationArray objectAtIndex:0];
    
        if([_storedStopStationArray count] >= 2)
        {
            [_lastStop1Button setTitle:[_storedStopStationArray objectAtIndex:1] forState:UIControlStateNormal];
        
            if([_storedStopStationArray count] >= 3)
            {
                [_lastStop2Button setTitle:[_storedStopStationArray objectAtIndex:2] forState:UIControlStateNormal];
            }
        }
    }
}



- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // TODO set start or stop label and _changedStart/StopStation when coming back from publicStopVC
    
    if(
            ([_publicStopVC._actualStationName length] > 0)
         && (_changedStopStation || _changedStartStation )
       )
    {
        NSString *_stationName =  _publicStopVC._actualStationName;
        //NSLog(@"actual Station: %@",_stationName);
        if ([_publicStopVC._actualStationType isEqualToString:@"from"])
        {
            //_startLabel.text = _stationName;
            _startStation = _stationName;
            
            if ([_storedStartStationArray count] >= 3)
            {
                [_dbCachingForAutocomplete deleteStartStation];
                [_dbCachingForAutocomplete addStartStation:_lastStart1Button.titleLabel.text];
                [_dbCachingForAutocomplete addStartStation:_lastStart2Button.titleLabel.text];
            }
            [_dbCachingForAutocomplete addStartStation:_startStation];
            
            [self actualizeStartStationArray];
            
            
        }
        else
        {
            //_stopLabel.text = _stationName;
            _stopStation = _stationName;
            
            if ([_storedStopStationArray count] >= 3)
            {
                [_dbCachingForAutocomplete deleteStopStation];
                [_dbCachingForAutocomplete addStopStation:_lastStop1Button.titleLabel.text];
                [_dbCachingForAutocomplete addStopStation:_lastStop2Button.titleLabel.text];
            }
            [_dbCachingForAutocomplete addStopStation:_stopStation];
            
            [self actualizeStopStationArray];
        }
    }
    
    [self getConnectionArray];
}

- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}

- (void) getConnectionArray
{
    
    if ([_connectionArray._connections count] == 0
        || _changedStartStation || _changedStopStation)
    {
        if ([_startStation length] > 0 && [_stopStation length] > 0)
        {
            [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
            
            [_connectionArray getData: _startStation
                  withStopStation:_stopStation];
        }
        //_noConnectionButton.hidden = NO;
        //_noConnectionLabel.hidden = NO;
    //}
    //else
    //{
        //_noConnectionButton.hidden = YES;
        //_noConnectionLabel.hidden = YES;

    }
    
    [_publicTransportTableView reloadData];
    
    [_waitForChangeActivityIndicator stopAnimating];
    _waitForChangeActivityIndicator.hidden = YES;
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
    _searchButton = nil;
    _pubilcTransportOverviewTableCell = nil;
    _publicStopVC = nil;
    _publicTransportTableView = nil;
    _lastStart1Button = nil;
    _lastStart2Button = nil;
    _startLabel = nil;
    _lastStart2Button = nil;
    _chooseNewStartButton = nil;
    _stopLabel = nil;
    _lastStop1Button = nil;
    _lastStop2Button = nil;
    _chooseNewStopButton = nil;
    _waitForChangeActivityIndicator = nil;
    [super viewDidUnload];
}


- (IBAction)changeStart:(id)sender
{
    if (_changeStartButtonIsActivated)
    {
        _lastStart1Button.hidden        = YES;
        _lastStart2Button.hidden        = YES;
        _chooseNewStartButton.hidden    = YES;
        _changeStartButtonIsActivated   = NO;
    }
    else
    {
        _changeStartButtonIsActivated   = YES;
        _lastStart1Button.hidden        = NO;
        _lastStart2Button.hidden        = NO;
        _chooseNewStartButton.hidden    = NO;
        
        _lastStop1Button.hidden        = YES;
        _lastStop2Button.hidden        = YES;
        _chooseNewStopButton.hidden    = YES;
        _changeStopButtonIsActivated   = NO;
        
        [_chooseNewStartButton setTitle:@"neu..." forState:UIControlStateNormal];
    }
}

- (IBAction)changeStartToLast1:(id)sender
{
    _lastStart1Button.hidden        = YES;
    _lastStart2Button.hidden        = YES;
    _chooseNewStartButton.hidden    = YES;
    
    _changeStartButtonIsActivated   = NO;
    _changedStartStation = YES;
    
    if ([_storedStartStationArray count] >= 3)
    {
        [_dbCachingForAutocomplete deleteStartStation];
        [_dbCachingForAutocomplete addStartStation:_startLabel.text];
        [_dbCachingForAutocomplete addStartStation:_lastStart2Button.titleLabel.text];
        [_dbCachingForAutocomplete addStartStation:_lastStart1Button.titleLabel.text];
    }
    else
    {
        if ([_storedStartStationArray count] == 2)
        {
            [_dbCachingForAutocomplete deleteStartStation];
            [_dbCachingForAutocomplete addStartStation:_startLabel.text];
            [_dbCachingForAutocomplete addStartStation:_lastStart1Button.titleLabel.text];
        }        
    }
    
    [self actualizeStartStationArray];
    
    
    
    //NSLog(@"old _startLabel.text: %@ new _startLabel.text: %@", _startStation, _lastStart1Button.titleLabel.text);
    
    //_startLabel.text = _lastStart1Button.titleLabel.text;
    //_lastStart1Button.titleLabel.text = _startStation;
    //_startStation = _lastStart1Button.titleLabel.text;

    [self getConnectionArray];
}

- (IBAction)changeStartToLast2:(id)sender
{
    _lastStart1Button.hidden        = YES;
    _lastStart2Button.hidden        = YES;
    _chooseNewStartButton.hidden    = YES;
    
    _changeStartButtonIsActivated   = NO;
    _changedStartStation = YES;

    _startLabel.text = _lastStart2Button.titleLabel.text;
    _lastStart2Button.titleLabel.text = _startStation;
    _startStation = _lastStart2Button.titleLabel.text;
    
    [self getConnectionArray];
}


- (IBAction)chooseNewStart:(id)sender
{
    _changedStartStation            = YES;
    _changeStartButtonIsActivated   = NO;
    _lastStart1Button.hidden        = YES;
    _lastStart2Button.hidden        = YES;
    _chooseNewStartButton.hidden    = YES;
    
    _publicStopVC._actualStationType = @"from";
    _publicStopVC._actualStationName = @"";
    _publicStopVC._publicStopTextFieldString = @"";
    _publicStopVC._stationArray = nil;
    _publicStopVC._publicStopTextField.text = @"";
    [self presentModalViewController:_publicStopVC animated:YES];
}



- (IBAction)changeStop:(id)sender
{
    if (_changeStopButtonIsActivated)
    {
        _lastStop1Button.hidden        = YES;
        _lastStop2Button.hidden        = YES;
        _chooseNewStopButton.hidden    = YES;
        _changeStopButtonIsActivated   = NO;
    }
    else
    {
        _changeStopButtonIsActivated   = YES;
        _lastStop1Button.hidden        = NO;
        _lastStop2Button.hidden        = NO;
        _chooseNewStopButton.hidden    = NO;
        
        _changeStartButtonIsActivated   = NO;
        _lastStart1Button.hidden        = YES;
        _lastStart2Button.hidden        = YES;
        _chooseNewStartButton.hidden    = YES;
        
        [_chooseNewStopButton setTitle:@"neu..." forState:UIControlStateNormal];
    }
}

- (IBAction)changeStopToLast1:(id)sender
{
    _lastStop1Button.hidden        = YES;
    _lastStop2Button.hidden        = YES;
    _chooseNewStopButton.hidden    = YES;

    _changedStopStation = YES;
    _changeStopButtonIsActivated  = NO;
    
    _stopStation = _lastStop1Button.titleLabel.text;
    _stopLabel.text = _stopStation;
    
    [self getConnectionArray];
}

- (IBAction)changeStopToLast2:(id)sender
{
    _lastStop1Button.hidden        = YES;
    _lastStop2Button.hidden        = YES;
    _chooseNewStopButton.hidden    = YES;
    
    _changeStopButtonIsActivated   = NO;
    _changedStopStation = YES;
    
    _stopStation = _lastStop2Button.titleLabel.text;
    _stopLabel.text = _stopStation;
    
    [self getConnectionArray];
}

- (IBAction)chooseNewStop:(id)sender
{
    _changedStopStation = YES;
    _lastStop1Button.hidden        = YES;
    _lastStop2Button.hidden        = YES;
    _chooseNewStopButton.hidden    = YES;
    _changeStopButtonIsActivated   = NO;
    
    _publicStopVC._actualStationType = @"to";
    _publicStopVC._actualStationName = @"";
    _publicStopVC._publicStopTextFieldString = @"";
    _publicStopVC._stationArray = nil;
    _publicStopVC._publicStopTextField.text = @"";
    [self presentModalViewController:_publicStopVC animated:YES];
}

- (IBAction)startConnectionSearch:(id)sender
{
    if ([_startStation length] == 0 || [_stopStation length] == 0)
    {
        UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                          initWithTitle:PublicTransportVCTitle
                                          message:@"Bitte Start und Ziel eingeben."
                                          delegate:self
                                          cancelButtonTitle:AlertViewOk
                                          otherButtonTitles:nil];
        
        [_acronymAlertView show];
    }
    else
    {
        NSLog(@"startConnectionSearch -> _startStation: %@ _stopStation: %@", _startStation, _stopStation);
        [self getConnectionArray];
    }
}



// needed for textfield delegate
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}


// needed for table delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberOfRowsInSection connection count: %i", [_connectionArray._connections count]);
    return [_connectionArray._connections count]; 
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
    
    UILabel          *_startDestinationLabel = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_startDateLabel       = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_startTimeLabel       = (UILabel  *)[_cell viewWithTag:3];
    UILabel          *_durationLabel        = (UILabel  *)[_cell viewWithTag:4];
    UILabel          *_transfersLabel       = (UILabel  *)[_cell viewWithTag:5];
    UILabel          *_transportationLabel  = (UILabel  *)[_cell viewWithTag:6];
    UILabel          *_stopDestinationLabel = (UILabel  *)[_cell viewWithTag:7];
    UILabel          *_stopDateLabel        = (UILabel  *)[_cell viewWithTag:8];
    UILabel          *_stopTimeLabel        = (UILabel  *)[_cell viewWithTag:9];

    //NSLog(@" cellForRowAtIndexPath - connection count: %i _cellRow: %i", [_connectionArray._connections count], _cellRow);
    
        if (    [_connectionArray._connections lastObject] != nil
            &&  [_connectionArray._connections count] > _cellRow)
        {
            ConnectionDto *_localConnection = [_connectionArray._connections objectAtIndex:_cellRow];
            
            _startDestinationLabel.text        = _localConnection._from._station._name;
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
            
            _stopDestinationLabel.text       = _localConnection._to._station._name;
            _stopDateLabel.text   = [[_dateFormatter _dayFormatter] stringFromDate:_localConnection._to._arrivalDate];
            _stopTimeLabel.text   = [NSString stringWithFormat:@"an %@", [[_dateFormatter _timeFormatter] stringFromDate:_localConnection._to._arrivalTime]];
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
