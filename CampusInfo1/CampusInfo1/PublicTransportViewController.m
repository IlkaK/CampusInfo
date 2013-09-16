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
#import "CharTranslation.h"

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
@synthesize _changeDirectionButton;

@synthesize _waitForChangeActivityIndicator;



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
    [_changeDirectionButton useAlertStyle];
    
    if (_publicStopVC == nil)
    {
		_publicStopVC = [[PublicStopViewController alloc] init];
	}
    _publicStopVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    [self actualizeStartStationArray];
    [self actualizeStopStationArray];
    
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
    
    _changeDirectionButton.hidden  = NO;
    
    NSMutableAttributedString *_titleString = [[NSMutableAttributedString alloc] initWithString:@"neu..."];
    [_titleString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [_titleString length])];
    //[_titleString addAttribute:NSForegroundColorAttributeName value:_zhawColor._zhawDarkGrey range:NSMakeRange(0, [_titleString length])];
    
    [_chooseNewStartButton  setAttributedTitle:_titleString forState:UIControlStateNormal];
    [_chooseNewStopButton   setAttributedTitle:_titleString forState:UIControlStateNormal];
    
    // set activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    //[_waitForChangeActivityIndicator setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
    
}


-(void)setStartFields:(NSString *)stringForLabel
withStringForButton1:(NSString *)stringForButton1
withStringForButton2:(NSString *)stringForButton2
{
    _startLabel.text = stringForLabel;
    [_lastStart1Button setTitle:stringForButton1 forState:UIControlStateNormal];
    [_lastStart2Button setTitle:stringForButton2 forState:UIControlStateNormal];
}

-(void)setStopFields:(NSString *)stringForLabel
 withStringForButton1:(NSString *)stringForButton1
 withStringForButton2:(NSString *)stringForButton2
{
    _stopLabel.text = stringForLabel;
    [_lastStop1Button setTitle:stringForButton1 forState:UIControlStateNormal];
    [_lastStop2Button setTitle:stringForButton2 forState:UIControlStateNormal];
}


- (void)actualizeStartStationArray
{
    _storedStartStationArray = [_dbCachingForAutocomplete getStartStations];
    if([_storedStartStationArray count] >= 3)
    {
        [self setStartFields:[_storedStartStationArray objectAtIndex:2]
         withStringForButton1:[_storedStartStationArray objectAtIndex:1]
        withStringForButton2:[_storedStartStationArray objectAtIndex:0]];
        
    }
    else
    {        
        if([_storedStartStationArray count] == 2)
        {
            [self setStartFields:[_storedStartStationArray objectAtIndex:1]
            withStringForButton1:[_storedStartStationArray objectAtIndex:0]
            withStringForButton2:@""];
        }
        else
        {
            if([_storedStartStationArray count] == 1)
            {
                [self setStartFields:[_storedStartStationArray objectAtIndex:0]
                withStringForButton1:@""
                withStringForButton2:@""];
            }
        }
    }
}


- (void)actualizeStopStationArray
{
    _storedStopStationArray = [_dbCachingForAutocomplete getStopStations];
    if([_storedStopStationArray count] >= 3)
    {
        [self setStopFields:[_storedStopStationArray objectAtIndex:2]
        withStringForButton1:[_storedStopStationArray objectAtIndex:1]
        withStringForButton2:[_storedStopStationArray objectAtIndex:0]];
        
    }
    else
    {
        if([_storedStopStationArray count] == 2)
        {
            [self setStopFields:[_storedStopStationArray objectAtIndex:1]
            withStringForButton1:[_storedStopStationArray objectAtIndex:0]
            withStringForButton2:@""];
        }
        else
        {
            if([_storedStopStationArray count] == 1)
            {
                [self setStopFields:[_storedStopStationArray objectAtIndex:0]
                withStringForButton1:@""
                withStringForButton2:@""];
            }
        }
    }
}


// check if new start is already in cache
- (BOOL)newStartAlreadyInArray:(NSString *)newStart
{
    int     _startArrayI;
    BOOL    _inStartArray = NO;
    for (_startArrayI = 0; _startArrayI < [_storedStartStationArray count]; _startArrayI++)
    {
        if ([newStart isEqualToString:[_storedStartStationArray objectAtIndex:_startArrayI]])
        {
            _inStartArray = YES;
        }
    }
    return _inStartArray;
}

// check if new stop is already in cache
- (BOOL)newStopAlreadyInArray:(NSString *)newStart
{
    int     _stopArrayI;
    BOOL    _inStopArray = NO;
    for (_stopArrayI = 0; _stopArrayI < [_storedStopStationArray count]; _stopArrayI++)
    {
        if ([newStart isEqualToString:[_storedStopStationArray objectAtIndex:_stopArrayI]])
        {
            _inStopArray = YES;
        }
    }
    return _inStopArray;
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if(
            ([_publicStopVC._actualStationName length] > 0)
         && (_changedStopStation || _changedStartStation )
       )
    {
        NSString *_stationName =  _publicStopVC._actualStationName;

        if ([_publicStopVC._actualStationType isEqualToString:@"from"])
        {
            if ([self newStartAlreadyInArray:_stationName] == NO)
            {
                if ([_storedStartStationArray count] >= 3)
                {
                    [_dbCachingForAutocomplete deleteStartStation];
                    [_dbCachingForAutocomplete addStartStation:_lastStart1Button.titleLabel.text];
                    [_dbCachingForAutocomplete addStartStation:_startLabel.text];
                }
                [_dbCachingForAutocomplete addStartStation:_stationName];
                [self actualizeStartStationArray];
            }
        }
        else
        {
            if ([self newStopAlreadyInArray:_stationName] == NO)
            {
                if ([_storedStopStationArray count] >= 3)
                {
                    [_dbCachingForAutocomplete deleteStopStation];
                    [_dbCachingForAutocomplete addStopStation:_lastStop1Button.titleLabel.text];
                    [_dbCachingForAutocomplete addStopStation:_stopLabel.text];
                }
                [_dbCachingForAutocomplete addStopStation:_stationName];
                [self actualizeStopStationArray];
            }
        }
    }
    
    //[self getConnectionArray];
}


- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}


- (void) getConnectionArray
{
    
    //if ([_connectionArray._connections count] == 0
    //    || _changedStartStation || _changedStopStation)
    //{
    ConnectionDto *_localConnection = [[ConnectionDto alloc]init:nil withTo:nil withDuration:nil withTransfers:nil withService:nil withProducts:nil withCapacity1st:nil withCapacity2nd:nil withSections:nil];
    BOOL noValues = NO;
    
    
    if (    [_connectionArray._connections lastObject] != nil
        &&  [_connectionArray._connections count] > 0)
    {
        _localConnection = [_connectionArray._connections objectAtIndex:0];
    }
    else
    {
        noValues = YES;
    }
    
    CharTranslation *_charTranslation = [CharTranslation alloc];
    BOOL newStart = NO;
    BOOL newStop = NO;

    //NSLog(@"_localConnection._from._station._name: %@ ", [_charTranslation replaceSpecialChars:_localConnection._from._station._name]);
    //NSLog(@"_localConnection._to._station._name: %@ ", [_charTranslation replaceSpecialChars:_localConnection._to._station._name]);
    //NSLog(@"_connectionArray._startStation: %@ ", [_charTranslation replaceSpecialChars:_connectionArray._startStation]);
    //NSLog(@"_connectionArray._stopStation: %@ ", [_charTranslation replaceSpecialChars:_connectionArray._stopStation]);
    //NSLog(@"_startLabel.text: %@ ", [_charTranslation replaceSpecialChars:_startLabel.text]);
    //NSLog(@"_stopLabel: %@ ", [_charTranslation replaceSpecialChars:_stopLabel.text]);
    
    
    if (   [_startLabel.text length] > 0
        && [_stopLabel.text length] > 0
        && ![_startLabel.text isEqualToString:@"Start"]
        && ![_stopLabel.text isEqualToString:@"Ziel"]
        )
    {
        if
             ([[_charTranslation replaceSpecialChars:_connectionArray._startStation] isEqualToString:[_charTranslation replaceSpecialChars:_startLabel.text]]
            )
        {
            newStart = NO;
        }
        else
        {
            newStart = YES;
        }
        
        if  (  [[_charTranslation replaceSpecialChars:_connectionArray._stopStation] isEqualToString:[_charTranslation replaceSpecialChars:_stopLabel.text]]
            )
        {
            newStop = NO;
        }
        else
        {
            newStop = YES;
        }
        
        if (newStart || newStop || noValues)
        {
            [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
        
            [_connectionArray getData: _startLabel.text
                      withStopStation:_stopLabel.text
                      withNewStations:newStart || newStop];
            
        }
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
    _changeDirectionButton = nil;
    _changeDirectionButton = nil;
    [super viewDidUnload];
}


- (IBAction)changeStart:(id)sender
{
    if (_changeStartButtonIsActivated)
    {
        _lastStart1Button.hidden        = YES;
        _lastStart2Button.hidden        = YES;
        _chooseNewStartButton.hidden    = YES;
        _changeDirectionButton.hidden   = NO;
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
        
        _changeDirectionButton.hidden  = YES;
        
        [_chooseNewStartButton setTitle:@"neu..." forState:UIControlStateNormal];
    }
}

- (IBAction)changeStartToLast1:(id)sender
{
    _lastStart1Button.hidden        = YES;
    _lastStart2Button.hidden        = YES;
    _chooseNewStartButton.hidden    = YES;
    _changeDirectionButton.hidden   = NO;
    
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
    
    [self getConnectionArray];
}

- (IBAction)changeStartToLast2:(id)sender
{
    _lastStart1Button.hidden        = YES;
    _lastStart2Button.hidden        = YES;
    _chooseNewStartButton.hidden    = YES;
    _changeDirectionButton.hidden   = NO;
    
    _changeStartButtonIsActivated   = NO;
    _changedStartStation = YES;

    //NSLog(@"how many stored: %i", [_storedStartStationArray count]);
    if ([_storedStartStationArray count] >= 3)
    {
        [_dbCachingForAutocomplete deleteStartStation];
        [_dbCachingForAutocomplete addStartStation:_startLabel.text];
        [_dbCachingForAutocomplete addStartStation:_lastStart1Button.titleLabel.text];
        [_dbCachingForAutocomplete addStartStation:_lastStart2Button.titleLabel.text];
    }
    [self actualizeStartStationArray];
    [self getConnectionArray];
}


- (IBAction)chooseNewStart:(id)sender
{
    _changedStartStation            = YES;
    _changeStartButtonIsActivated   = NO;
    _lastStart1Button.hidden        = YES;
    _lastStart2Button.hidden        = YES;
    _chooseNewStartButton.hidden    = YES;
    _changeDirectionButton.hidden   = NO;
    
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
        _changeDirectionButton.hidden   = NO;
    }
    else
    {
        _changeStopButtonIsActivated   = YES;
        _lastStop1Button.hidden        = NO;
        _lastStop2Button.hidden        = NO;
        _chooseNewStopButton.hidden    = NO;
        _changeDirectionButton.hidden   = YES;
        
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
    _changeDirectionButton.hidden   = NO;
    
    _changeStopButtonIsActivated   = NO;
    _changedStopStation = YES;
    
    if ([_storedStopStationArray count] >= 3)
    {
        [_dbCachingForAutocomplete deleteStopStation];
        [_dbCachingForAutocomplete addStopStation:_stopLabel.text];
        [_dbCachingForAutocomplete addStopStation:_lastStop2Button.titleLabel.text];
        [_dbCachingForAutocomplete addStopStation:_lastStop1Button.titleLabel.text];
    }
    else
    {
        if ([_storedStopStationArray count] == 2)
        {
            [_dbCachingForAutocomplete deleteStopStation];
            [_dbCachingForAutocomplete addStopStation:_stopLabel.text];
            [_dbCachingForAutocomplete addStopStation:_lastStop1Button.titleLabel.text];
        }
    }
    
    [self actualizeStopStationArray];
    
    //NSLog(@"old _startLabel.text: %@ new _startLabel.text: %@", _startStation, _lastStart1Button.titleLabel.text);
    
    [self getConnectionArray];
}


- (IBAction)changeStopToLast2:(id)sender
{
    _lastStop1Button.hidden        = YES;
    _lastStop2Button.hidden        = YES;
    _chooseNewStopButton.hidden    = YES;
    _changeDirectionButton.hidden   = NO;
    
    _changeStopButtonIsActivated   = NO;
    _changedStopStation = YES;
    
    //NSLog(@"how many stored: %i", [_storedStartStationArray count]);
    if ([_storedStopStationArray count] >= 3)
    {
        [_dbCachingForAutocomplete deleteStopStation];
        [_dbCachingForAutocomplete addStopStation:_stopLabel.text];
        [_dbCachingForAutocomplete addStopStation:_lastStop1Button.titleLabel.text];
        [_dbCachingForAutocomplete addStopStation:_lastStop2Button.titleLabel.text];
    }
    [self actualizeStopStationArray];
    [self getConnectionArray];
}


- (IBAction)chooseNewStop:(id)sender
{
    _changedStopStation = YES;
    _lastStop1Button.hidden        = YES;
    _lastStop2Button.hidden        = YES;
    _chooseNewStopButton.hidden    = YES;
    _changeStopButtonIsActivated   = NO;
    _changeDirectionButton.hidden   = NO;
    
    _publicStopVC._actualStationType = @"to";
    _publicStopVC._actualStationName = @"";
    _publicStopVC._publicStopTextFieldString = @"";
    _publicStopVC._stationArray = nil;
    _publicStopVC._publicStopTextField.text = @"";
    [self presentModalViewController:_publicStopVC animated:YES];
}

- (IBAction)startConnectionSearch:(id)sender
{
    if (
           [_startLabel.text length] == 0
        || [_stopLabel.text length] == 0
        || [_startLabel.text isEqualToString:@"Start"]
        || [_stopLabel.text isEqualToString:@"Ziel"]
        )
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
        //NSLog(@"startConnectionSearch -> _startStation: %@ _stopStation: %@", _startStation, _stopStation);
        [self getConnectionArray];
    }
}

- (IBAction)changeDirection:(id)sender
{
    NSString *_newStart = _stopLabel.text;
    NSString *_newStop  = _startLabel.text;
    
    BOOL _newStartEqualsStart1 = NO;
    BOOL _newStartEqualsStart2 = NO;
    BOOL _newStartEqualsStartLabel = NO;
    
    BOOL _newStopEqualsStop1 = NO;
    BOOL _newStopEqualsStop2 = NO;
    BOOL _newStopEqualsStopLabel = NO;
    
    
    if([_newStart isEqualToString:_lastStart1Button.titleLabel.text])
    {
        _newStartEqualsStart1 = YES;
    }
    if([_newStart isEqualToString:_lastStart2Button.titleLabel.text])
    {
        _newStartEqualsStart2 = YES;
    }
    if([_newStart isEqualToString:_startLabel.text])
    {
        _newStartEqualsStartLabel = YES;
    }

    [_dbCachingForAutocomplete deleteStartStation];
        
    if (_newStartEqualsStartLabel == YES || _newStartEqualsStart1 == YES)
    {
        [_dbCachingForAutocomplete addStartStation:_lastStart2Button.titleLabel.text];
    }
        
    if (_newStartEqualsStart1 == NO)
    {
        [_dbCachingForAutocomplete addStartStation:_lastStart1Button.titleLabel.text];
    }
        
    if (_newStartEqualsStartLabel == NO)
    {
        [_dbCachingForAutocomplete addStartStation:_startLabel.text];
    }
    
    [_dbCachingForAutocomplete addStartStation:_newStart];
    [self actualizeStartStationArray];

    
    if([_newStop isEqualToString:_lastStop1Button.titleLabel.text])
    {
        _newStopEqualsStop1 = YES;
    }
    if([_newStop isEqualToString:_lastStop2Button.titleLabel.text])
    {
        _newStopEqualsStop2 = YES;
    }
    if([_newStop isEqualToString:_stopLabel.text])
    {
        _newStopEqualsStopLabel = YES;
    }


    [_dbCachingForAutocomplete deleteStopStation];
    
    if (_newStopEqualsStopLabel == YES || _newStopEqualsStop1 == YES)
    {
        [_dbCachingForAutocomplete addStopStation:_lastStop2Button.titleLabel.text];
    }

    if (_newStopEqualsStop1 == NO)
    {
            [_dbCachingForAutocomplete addStopStation:_lastStop1Button.titleLabel.text];
    }
    
    if (_newStopEqualsStopLabel == NO)
    {
            [_dbCachingForAutocomplete addStopStation:_stopLabel.text];
    }
    
    [_dbCachingForAutocomplete addStopStation:_newStop];
    [self actualizeStopStationArray];
    
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
    NSLog(@"numberOfRowsInSection connection count: %i", [_connectionArray._connections count]);
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
