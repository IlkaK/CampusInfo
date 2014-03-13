/*
 PublicTransportViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PublicTransportViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of PublicTransportViewController.xib, where data for public transport connection can be entered and the connections are displayed. </li>
 *      <li> Getting and handling start and stop data as well as the connections.  </li>
 *      <li> With two buttons it can be switched to PubliStopViewController to search for different stops. </li>
 *      <li> Three start (from) and stop (to) stations are stored in database and handled here as well. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
 *      <li> Receives chosen station from PublicStopViewController, if a new one is found. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the delegate to PublicStopViewController and receives it back from there. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "PublicTransportViewController.h"
#import "DetailTransportViewController.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"
#import "ConnectionDto.h"
#import "CharTranslation.h"

@interface PublicTransportViewController ()
@end

@implementation PublicTransportViewController

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;

@synthesize _publicTransportCollectionView;

@synthesize _pubilcTransportOverviewTableCell;
@synthesize _publicTransportTableView;

@synthesize _publicStopVC;
@synthesize _detailVC;

@synthesize _connectionArray;
@synthesize _dateFormatter;
@synthesize _zhawColor;

@synthesize _startStation;
@synthesize _stopStation;
@synthesize _changedStartStation;
@synthesize _changedStopStation;

@synthesize _dbCachingForAutocomplete;
@synthesize _storedStartStationArray;
@synthesize _storedStopStationArray;

@synthesize _waitForChangeActivityIndicator;

@synthesize _veryNextConnectionDate;
@synthesize _veryNextConnectionTime;

/*!
 * @function initWithNibName
 * Initializiation of class.
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


/*!
 * @function prefersStatusBarHidden
 * Used to hide the iOS status bar with time and battery symbol.
 */
-(BOOL) prefersStatusBarHidden
{
    return YES;
}


/*!
 @function moveBackToMenuOverview
 When back button is triggered, delegate is returned to MenuOverviewController.
 @param sender
 */
- (void) moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}

/*!
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // general initialization
    _zhawColor                  = [[ColorSelection alloc]init];
    _connectionArray            = [[ConnectionArrayDto alloc]init:nil];
    _dateFormatter              = [[DateFormation alloc] init];
    _dbCachingForAutocomplete   = [[DBCachingForAutocomplete alloc]init];
    
    _changedStartStation = NO;
    _changedStopStation = NO;
    
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMenuOverview:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:NSLocalizedString(@"PublicTransportVCTitle", nil)];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    
    if (_publicStopVC == nil)
    {
		_publicStopVC = [[PublicStopViewController alloc] init];
	}
    _publicStopVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;

    if (_detailVC == nil)
    {
		_detailVC = [[DetailTransportViewController alloc] init];
	}
    _detailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    
    UINib *cellNib1 = [UINib nibWithNibName:@"PublicTransportLabelCollectionCell" bundle:nil];
    [self._publicTransportCollectionView registerNib:cellNib1 forCellWithReuseIdentifier:@"PublicTransportLabelCollectionCell"];
    
    UINib *cellNib2 = [UINib nibWithNibName:@"PublicTransportButtonCollectionCell" bundle:nil];
    [self._publicTransportCollectionView registerNib:cellNib2 forCellWithReuseIdentifier:@"PublicTransportButtonCollectionCell"];
    
    UINib *cellNib3 = [UINib nibWithNibName:@"PublicTransportDetailCollectionCell" bundle:nil];
    [self._publicTransportCollectionView registerNib:cellNib3 forCellWithReuseIdentifier:@"PublicTransportDetailCollectionCell"];

    UINib *cellNib4 = [UINib nibWithNibName:@"PublicTransportPushCollectionCell" bundle:nil];
    [self._publicTransportCollectionView registerNib:cellNib4 forCellWithReuseIdentifier:@"PublicTransportPushCollectionCell"];
    
    [_publicTransportCollectionView setBackgroundColor:_zhawColor._zhawWhite];
    
    [self actualizeStartStationArray];
    [self actualizeStopStationArray];
    
    // set activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
}


/*!
 * @function actualizeStartStationArray
 * Actualizing the array of start stations according to the data in the database.
 */
- (void)actualizeStartStationArray
{
    _storedStartStationArray = [_dbCachingForAutocomplete getStartStations];
    if([_storedStartStationArray count] >= 3)
    {
        _startStation =[_storedStartStationArray objectAtIndex:2];
    }
    else
    {        
        if([_storedStartStationArray count] == 2)
        {
            _startStation =[_storedStartStationArray objectAtIndex:1];
        }
        else
        {
            if([_storedStartStationArray count] == 1)
            {
                _startStation =[_storedStartStationArray objectAtIndex:0];
            }
        }
    }
    [self._publicTransportCollectionView reloadData];
}


/*!
 * @function actualizeStopStationArray
 * Actualizing the array of stop stations according to the data in the database.
 */
- (void)actualizeStopStationArray
{
    _storedStopStationArray = [_dbCachingForAutocomplete getStopStations];
    if([_storedStopStationArray count] >= 3)
    {
        _stopStation =[_storedStopStationArray objectAtIndex:2];
    }
    else
    {
        if([_storedStopStationArray count] == 2)
        {
            _stopStation =[_storedStopStationArray objectAtIndex:1];
        }
        else
        {
            if([_storedStopStationArray count] == 1)
            {
                _stopStation =[_storedStopStationArray objectAtIndex:0];
            }
        }
    }
    [self._publicTransportCollectionView reloadData];
}


/*!
 * @function newStartAlreadyInArray
 * Check if new start is already in cache
 */
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


/*!
 * @function newStopAlreadyInArray
 * Check if new stop is already in cache
 */
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

// check if new start is already in array otherwise add it
- (void)addToStartArray:(NSString *)newStart
{
    if ([self newStartAlreadyInArray:newStart] == NO)
    {
        _storedStartStationArray = [_dbCachingForAutocomplete getStartStations];
        if ([_storedStartStationArray count] < 3)
        {
            [_dbCachingForAutocomplete addStartStation:newStart];
        }
        else
        {
            [_dbCachingForAutocomplete deleteStartStation];
            [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:2]];
            [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:1]];
            [_dbCachingForAutocomplete addStartStation:newStart];
        }
    }
    else
    {
        [_dbCachingForAutocomplete deleteStartStation];
        
        // reorganize caching table if a recent stop was chosen
        if ([_storedStartStationArray count] >= 3)
        {
            if ([[_storedStartStationArray objectAtIndex:2] isEqualToString:newStart])
            {
                [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:1]];
                [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:0]];
                [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:2]];
            }
            else
            {
                if ([[_storedStartStationArray objectAtIndex:1] isEqualToString:newStart])
                {
                    [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:0]];
                    [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:2]];
                    [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:1]];
                }
                else
                {
                    if ([[_storedStartStationArray objectAtIndex:0]  isEqualToString:newStart])
                    {
                        [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:2]];
                        [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:1]];
                        [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:0]];
                    }
                }
            }
        }
        else
        {
            if ([_storedStartStationArray count] == 2)
            {
                if ([[_storedStartStationArray objectAtIndex:1] isEqualToString:newStart])
                {
                    [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:0]];
                    [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:1]];
                }
                else
                {
                    if ([[_storedStartStationArray objectAtIndex:0]  isEqualToString:newStart])
                    {
                        [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:1]];
                        [_dbCachingForAutocomplete addStartStation:[_storedStartStationArray objectAtIndex:0]];
                    }
                }
            }
        }
    }
    [self actualizeStartStationArray];

}


// check if new stop is already in array otherwise add it
- (void)addToStopArray:(NSString *)newStop
{
    if ([self newStopAlreadyInArray:newStop] == NO)
    {
        if ([_storedStopStationArray count] < 3)
        {
            [_dbCachingForAutocomplete addStopStation:newStop];
        }
        else
        {
            [_dbCachingForAutocomplete deleteStopStation];
            [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:2]];
            [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:1]];
            [_dbCachingForAutocomplete addStopStation:newStop];
        }
    }
    else
    {
        [_dbCachingForAutocomplete deleteStopStation];
        
        // reorganize caching table if a recent stop was chosen
        if ([_storedStopStationArray count] >= 3)
        {
            if ([[_storedStopStationArray objectAtIndex:2] isEqualToString:newStop])
            {
                [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:1]];
                [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:0]];
                [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:2]];
            }
            else
            {
                if ([[_storedStopStationArray objectAtIndex:1] isEqualToString:newStop])
                {
                    [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:0]];
                    [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:2]];
                    [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:1]];
                }
                else
                {
                    if ([[_storedStopStationArray objectAtIndex:0]  isEqualToString:newStop])
                    {
                        [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:2]];
                        [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:1]];
                        [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:0]];
                    }
                }
            }
        }
        else
        {
            if ([_storedStopStationArray count] == 2)
            {
                if ([[_storedStopStationArray objectAtIndex:1] isEqualToString:newStop])
                {
                    [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:0]];
                    [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:1]];
                }
                else
                {
                    if ([[_storedStopStationArray objectAtIndex:0]  isEqualToString:newStop])
                    {
                        [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:1]];
                        [_dbCachingForAutocomplete addStopStation:[_storedStopStationArray objectAtIndex:0]];
                    }
                }
            }
        }
    }
    [self actualizeStopStationArray];
}


/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    // found new station with PublicStopViewController
    if(
            ([_publicStopVC._actualStationName length] > 0)
         && (_changedStopStation || _changedStartStation )
       )
    {
        if ([_publicStopVC._actualStationType isEqualToString:PublicTransportVCFromEnglish])
        {
            [self addToStartArray:_publicStopVC._actualStationName];
        }
        else
        {
            [self addToStopArray:_publicStopVC._actualStationName];
        }
    }
}


/*!
 * @function threadWaitForLoadingActivityIndicator
 * Thread is called to start the activity indicator while waiting for data to be downloaded.
 */
- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}


/*!
 * @function getConnectionArray
 * Trigger search for new connections.
 */
- (void) getConnectionArray
{
    ConnectionDto *_localConnection = [[ConnectionDto alloc]init:nil withTo:nil withDuration:nil withTransfers:nil withService:nil withProducts:nil withCapacity1st:0 withCapacity2nd:0 withSections:nil];
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
    BOOL newTime = NO;

    //NSLog(@"_localConnection._from._station._name: %@ ", [_charTranslation replaceSpecialChars:_localConnection._from._station._name]);
    //NSLog(@"_localConnection._to._station._name: %@ ", [_charTranslation replaceSpecialChars:_localConnection._to._station._name]);
    //NSLog(@"_connectionArray._startStation: %@ ", [_charTranslation replaceSpecialChars:_connectionArray._startStation]);
    //NSLog(@"_connectionArray._stopStation: %@ ", [_charTranslation replaceSpecialChars:_connectionArray._stopStation]);
    //NSLog(@"_startLabel.text: %@ ", [_charTranslation replaceSpecialChars:_startLabel.text]);
    //NSLog(@"_stopLabel: %@ ", [_charTranslation replaceSpecialChars:_stopLabel.text]);
    
    if (   [_startStation length] > 0
        && [_stopStation  length] > 0
        //&& ![_startStation isEqualToString:PublicTransportVCStart]
        //&& ![_stopStation  isEqualToString:PublicTransportVCGoal]
        )
    {
        //NSLog(@"getConnectionArray -> _startLabel.text: %@", _startLabel.text);
        //NSLog(@"getConnectionArray -> _startStation: %@", _connectionArray._startStation);
        
        // check if there is a new start station
        if ([_connectionArray._startStation length] == 0)
        {
            newStart = YES;
        }
        else
        {
            if  ([[_charTranslation replaceSpecialCharsUTF8:_connectionArray._startStation] isEqualToString:[_charTranslation replaceSpecialCharsUTF8:_startStation]]
                 )
            {
                newStart = NO;
            }
            else
            {
                newStart = YES;
            }
        }
        
        // check if there is a new stop station
        if ([_connectionArray._stopStation length] == 0)
        {
            newStart = YES;
        }
        else
        {
            if  (  [[_charTranslation replaceSpecialCharsUTF8:_connectionArray._stopStation] isEqualToString:[_charTranslation replaceSpecialCharsUTF8:_stopStation]]
                 )
            {
                newStop = NO;
            }
            else
            {
                newStop = YES;
            }
        }
        
        // check if either the connection date or the time is old

        NSString *_actualDayString        = [[_dateFormatter _dayFormatter] stringFromDate:[NSDate date]];
        NSString *_lastConnectionDaySting = [[_dateFormatter _dayFormatter] stringFromDate:_veryNextConnectionDate];
        
        // if dates are different search new connections
        if (!([_actualDayString isEqualToString: _lastConnectionDaySting]))
        {
            newTime = YES;
            //NSLog(@"not the same dates: %@ = %@", _actualDayString, _lastConnectionDaySting);
        }
        
        NSString *_lastConnectionTimeString = [[_dateFormatter _timeFormatter] stringFromDate: _veryNextConnectionTime];
        NSString *_actualTimeString         = [[_dateFormatter _timeFormatter] stringFromDate: [NSDate date]];
        
        // last connection needs to be before actual time, than trigger new search
       if(  [_actualTimeString compare: _lastConnectionTimeString] == NSOrderedDescending
        )
       {
           newTime = YES;
           //NSLog(@"time is either the same or after: %@ = %@", _actualTimeString, _lastConnectionTimeString);
       }
        

        if (newStart || newStop || noValues || newTime)
        {
            [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
            [_connectionArray getData: _startStation
                      withStopStation:_stopStation
                      withNewStations:newStart || newStop || newTime];
        }
    }
    [_publicTransportTableView reloadData];
    [_waitForChangeActivityIndicator stopAnimating];
    _waitForChangeActivityIndicator.hidden = YES;
}


/*!
 * @function didReceiveMemoryWarning
 * The function is included per default.
 */
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*!
 @function viewDidUnload
 * The function is included, since class inherits from UIViewController.
 * It is called while the view is unloaded.
 */
- (void)viewDidUnload
{
    _pubilcTransportOverviewTableCell = nil;
    _publicStopVC = nil;
    _detailVC = nil;
    _publicTransportTableView = nil;
    _waitForChangeActivityIndicator = nil;
    [super viewDidUnload];
}



-(void) getNewStart:(id)sender event:(id)event
{
    _changedStartStation = YES;
    _changedStopStation  = NO;
    
    _publicStopVC._actualStationType            = PublicTransportVCFromEnglish;
    _publicStopVC._actualStationName            = @"";
    _publicStopVC._publicStopTextFieldString    = @"";
    _publicStopVC._stationArray                 = nil;
    
    _storedStartStationArray = [_dbCachingForAutocomplete getStartStations];
    if([_storedStartStationArray count] >= 3)
    {
        _publicStopVC._lastStation1 = [_storedStartStationArray objectAtIndex:1];
        _publicStopVC._lastStation2 = [_storedStartStationArray objectAtIndex:0];
    }
    else
    {
        _publicStopVC._lastStation2 = @"";
        if([_storedStartStationArray count] == 2)
        {
            _publicStopVC._lastStation1 = [_storedStartStationArray objectAtIndex:0];
        }
        else
        {
            _publicStopVC._lastStation1 = @"";
        }
    }
    [self presentModalViewController:_publicStopVC animated:YES];
}


-(void) getNewStop:(id)sender event:(id)event
{
    _changedStopStation = YES;
    _changedStartStation = NO;
    
    _publicStopVC._actualStationType            = PublicTransportVCToEnglish;
    _publicStopVC._actualStationName            = @"";
    _publicStopVC._publicStopTextFieldString    = @"";
    _publicStopVC._stationArray                 = nil;
    
    _storedStopStationArray = [_dbCachingForAutocomplete getStopStations];
    if([_storedStopStationArray count] >= 3)
    {
        _publicStopVC._lastStation1 = [_storedStopStationArray objectAtIndex:1];
        _publicStopVC._lastStation2 = [_storedStopStationArray objectAtIndex:0];
    }
    else
    {
        _publicStopVC._lastStation2 = @"";
        if([_storedStopStationArray count] == 2)
        {
            _publicStopVC._lastStation1 = [_storedStopStationArray objectAtIndex:0];
        }
        else
        {
            _publicStopVC._lastStation1 = @"";
        }
    }
    [self presentModalViewController:_publicStopVC animated:YES];
}



/*!
 @function startConnectionSearch
 Triggers searching for new connections.
 @param sender
 @param event
 */
-(void) startConnectionSearch:(id)sender event:(id)event
{
    if (
           [_startStation length] == 0
        || [_stopStation  length] == 0
        //|| [_startStation isEqualToString:PublicTransportVCStart]
        //|| [_stopStation  isEqualToString:PublicTransportVCGoal]
        )
    {
        UIAlertView *_acronymAlertView = [[UIAlertView alloc]
                                          initWithTitle:NSLocalizedString(@"PublicTransportVCTitle", nil)
                                        message:NSLocalizedString(@"PublicTransportVCHint", nil)
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



/*!
 @function changeDirection
 Switches start and stop station.
 @param sender
 @param event
 */
-(void) changeDirection:(id)sender event:(id)event
{
    NSString *_newStart = _stopStation;
    NSString *_newStop  = _startStation;
    [self addToStartArray:_newStart];
    [self addToStopArray:_newStop]; 
}


/*!
 * @function textFieldShouldReturn
 * The function is included, since the class delegates its textFields on its own. (UITextFieldDelegate)
 */
-(BOOL) textFieldShouldReturn:(UITextField *)textField
{    
    [textField resignFirstResponder];
    return YES;
}




//-------------------------------------------------
// ------- MANAGE COLLECTION CELLS ----
//-------------------------------------------------
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in collectionView.
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 3;
}

/*!
 * @function numberOfItemsInSection
 * The function defines the number of items in each section in collectionView.
 */
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (section == 0 || section == 1)
        return 3;
    else // section == 2
        return 1;
}


/*!
 * @function cellForItemAtIndexPath
 * The function is for customizing the collection view cells.
 * According to the position of the cell the given view is called.
 */
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellRow = indexPath.section;
    NSUInteger        _cellTab = indexPath.item;
    UICollectionViewCell *_cell;
    [_cell setBackgroundColor:_zhawColor._zhawWhite];
    _cell.contentView.backgroundColor = _zhawColor._zhawWhite;
    
    if (
            (_cellRow == 0 && _cellTab == 0) // from
        ||  (_cellRow == 1 && _cellTab == 0) // to
        )
    {
        static NSString *_cellIdentifier = @"PublicTransportLabelCollectionCell";
        _cell           = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
    
        UILabel *_descrLabel = (UILabel *)[_cell viewWithTag:1];
        [_descrLabel setTextAlignment:UITextAlignmentRight];
        [_descrLabel setTextColor:_zhawColor._zhawFontGrey];
        [_descrLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        
        if (_cellRow == 0 && _cellTab == 0)
        {
            [_descrLabel setText:NSLocalizedString(@"PublicTransportVCFrom2", nil)];
        }
        if (_cellRow == 1 && _cellTab == 0)
        {
            [_descrLabel setText:NSLocalizedString(@"PublicTransportVCTo2", nil)];
        }
    }
    
    if (
            (_cellRow == 0 && _cellTab == 1) // start
        ||  (_cellRow == 1 && _cellTab == 1) // stop
        )
    {
        static NSString *_cellIdentifier = @"PublicTransportButtonCollectionCell";
        _cell           = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
        UILabel *_connectionLabel =(UILabel *)[_cell viewWithTag:1];
        [_connectionLabel setTextAlignment:UITextAlignmentLeft];
        [_connectionLabel setTextColor:_zhawColor._zhawFontGrey];
        [_connectionLabel setFont:[UIFont fontWithName:NavigationBarFont size:NavigationBarDescriptionSize]];
        
        if (_cellRow == 0 && _cellTab == 1)
        {
            [_connectionLabel setText:_startStation];
        }
        if (_cellRow == 1 && _cellTab == 1)
        {
            [_connectionLabel setText:_stopStation];
        }
    }
    
    if (
            (_cellRow == 0 && _cellTab == 2) // show starts, detail button
        ||  (_cellRow == 1 && _cellTab == 2) // show stops, detail button
        )
    {
        static NSString *_cellIdentifier = @"PublicTransportDetailCollectionCell";
        _cell           = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
        UIButton *_newStationButton = (UIButton *)[_cell viewWithTag:1];
        [_newStationButton removeTarget:nil
                           action:NULL
                 forControlEvents:UIControlEventAllEvents];
        
        if (_cellRow == 0 && _cellTab == 2)
        {
            [_newStationButton addTarget:self action:@selector(getNewStart:event:) forControlEvents:UIControlEventTouchUpInside];
        }
        if (_cellRow == 1 && _cellTab == 2)
        {
            [_newStationButton addTarget:self action:@selector(getNewStop:event:) forControlEvents:UIControlEventTouchUpInside];
        }
    }
    
    if (
            (_cellRow == 2 && _cellTab == 0) // start searching and reverse direction
        )
    {
        static NSString *_cellIdentifier = @"PublicTransportPushCollectionCell";
        _cell           = [collectionView dequeueReusableCellWithReuseIdentifier:_cellIdentifier forIndexPath:indexPath];
        UIButton    *_searchConnectionButton    = (UIButton *)[_cell viewWithTag:1];
        UIButton    *_reverseConnectionButton   = (UIButton *)[_cell viewWithTag:2];
        
        [_searchConnectionButton setTitleColor:_zhawColor._zhawWhite forState:UIControlStateNormal];
        [_searchConnectionButton setBackgroundImage:[UIImage imageNamed:NoConnectionButtonBackground]  forState:UIControlStateNormal];
        [_searchConnectionButton addTarget:self action:@selector(startConnectionSearch:event:) forControlEvents:UIControlEventTouchUpInside];
        [_searchConnectionButton setTitle:NSLocalizedString(@"PublicTransportSearchConnection", nil) forState:UIControlStateNormal];
        
        [_reverseConnectionButton setTitleColor:_zhawColor._zhawWhite forState:UIControlStateNormal];
        [_reverseConnectionButton setBackgroundImage:[UIImage imageNamed:NoConnectionButtonBackground]  forState:UIControlStateNormal];
        [_reverseConnectionButton addTarget:self action:@selector(changeDirection:event:) forControlEvents:UIControlEventTouchUpInside];
        [_reverseConnectionButton setTitle:NSLocalizedString(@"PublicTransportOppositeDirection", nil) forState:UIControlStateNormal];
    }
    
    return _cell;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellRow = indexPath.section;
    NSUInteger        _cellTab = indexPath.item;
    
    if (
            (_cellRow == 0 && _cellTab == 0) // from
        ||  (_cellRow == 1 && _cellTab == 0) // to
        )
    {
        return CGSizeMake(100, 30);
    }
    if (
            (_cellRow == 0 && _cellTab == 1) // start
        ||  (_cellRow == 1 && _cellTab == 1) // stop
        )
    {
        return CGSizeMake(140, 30);
    }
    if (
            (_cellRow == 0 && _cellTab == 2) // show starts, detail button
        ||  (_cellRow == 1 && _cellTab == 2) // show stops, detail button
        )
    {
        return CGSizeMake(50, 30);
    }
    if (
            (_cellRow == 2 && _cellTab == 0) // start searching and reverse direction
        )
    {
        return CGSizeMake(290, 40);
    }
    
    return CGSizeMake(50, 30);
}


//-------------------------------------------------
// ------- MANAGE TABLE CELLS ----
//-------------------------------------------------
/*!
 * @function numberOfSectionsInTableView
 * The function defines the number of sections in table.
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

/*!
 * @function numberOfRowsInSection
 * The function defines the number of rows in table.
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //NSLog(@"numberOfRowsInSection connection count: %i", [_connectionArray._connections count]);
    return [_connectionArray._connections count]; 
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
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
    UILabel          *_stopDestinationLabel = (UILabel  *)[_cell viewWithTag:5];
    UILabel          *_stopDateLabel        = (UILabel  *)[_cell viewWithTag:6];
    UILabel          *_stopTimeLabel        = (UILabel  *)[_cell viewWithTag:7];
    [_startDestinationLabel     setTextColor:_zhawColor._zhawFontGrey];
    [_startDateLabel            setTextColor:_zhawColor._zhawFontGrey];
    [_startTimeLabel            setTextColor:_zhawColor._zhawFontGrey];
    [_durationLabel             setTextColor:_zhawColor._zhawFontGrey];
    [_stopDestinationLabel      setTextColor:_zhawColor._zhawFontGrey];
    [_stopDateLabel             setTextColor:_zhawColor._zhawFontGrey];
    [_stopTimeLabel             setTextColor:_zhawColor._zhawFontGrey];
    
    //NSLog(@" cellForRowAtIndexPath - connection count: %i _cellRow: %i", [_connectionArray._connections count], _cellRow);
    
    if (    [_connectionArray._connections lastObject] != nil
            &&  [_connectionArray._connections count] > _cellRow)
    {
            ConnectionDto *_localConnection = [_connectionArray._connections objectAtIndex:_cellRow];
        
            // store the very next departure time and date to check if another search is needed
            if(_cellRow == 0)
            {
                _veryNextConnectionDate = _localConnection._from._departureDate;
                _veryNextConnectionTime = _localConnection._from._departureTime;
            }
            
            _startDestinationLabel.text        = _localConnection._from._station._name;
            _startDateLabel.text    = [[_dateFormatter _dayFormatter] stringFromDate:_localConnection._from._departureDate];
            _startTimeLabel.text    = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"PublicTransportVCFrom1", nil), [[_dateFormatter _timeFormatter] stringFromDate:_localConnection._from._departureTime]];
            
            _durationLabel.text     = _localConnection._duration;
            _stopDestinationLabel.text = _localConnection._to._station._name;
            _stopDateLabel.text   = [[_dateFormatter _dayFormatter] stringFromDate:_localConnection._to._arrivalDate];
            _stopTimeLabel.text   = [NSString stringWithFormat:@"%@ %@",NSLocalizedString(@"PublicTransportVCTo1", nil), [[_dateFormatter _timeFormatter] stringFromDate:_localConnection._to._arrivalTime]];
    }
    return _cell;
}

/*!
 * @function heightForRowAtIndexPath
 * The function is for customizing the table view cells.
 * It sets the height for each cell individually.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 70;
}

/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellRow = indexPath.row;
    ConnectionDto *_localConnection;
    if ( [_connectionArray._connections count] > _cellRow)
    {
        _localConnection = [_connectionArray._connections objectAtIndex:_cellRow];
        _detailVC._actualConnection = _localConnection;
        [self presentModalViewController:_detailVC animated:YES];

    }
}

@end
