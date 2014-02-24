/*
 MensaViewController.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header MensaViewController.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Control of MensaViewController.xib, where a list of gastronomic facilities is displayed. </li>
 *      <li> Getting and handling gastronomic facilities with opening and eating times.  </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives delegate from MenuOverviewController and passes it back, if back button is clicked. </li>
 *      <li> Gets data from MensaOverviewDto package for gastronomic facilities, their opening and eating times. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It passes the delegate to MensaDetailViewController and receives it back from there. </li>
 *      <li> It sets the actual chosen gastronomic facility on MensaDetailViewController so it can show the menus of that gastronomic facility. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "MensaViewController.h"
#import "GastronomicFacilityDto.h"
#import "HolidayDto.h"
#import "ServiceTimePeriodDto.h"
#import "OpeningTimePlanDto.h"
#import "LunchTimePlanDto.h"
#import "WeekdayDto.h"
#import "ColorSelection.h"
#import "UIConstantStrings.h"

@implementation MensaViewController

@synthesize _mensaOverviewTable;
@synthesize _mensaOverviewTableCell;

@synthesize _gastronomyFacilityArray;

@synthesize _actualDate;
@synthesize _dateFormatter;
@synthesize _translator;
@synthesize _mensaDetailVC;

@synthesize _noConnectionLabel;
@synthesize _noConnectionButton;

@synthesize _titleNavigationBar;
@synthesize _titleNavigationItem;
@synthesize _dateNavigationBar;
@synthesize _dateNavigationItem;

@synthesize _waitForChangeActivityIndicator;

@synthesize _tableRows;

@synthesize _zhawColor;

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
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    _dateFormatter  = [[DateFormation alloc] init];
    _translator     = [[LanguageTranslation alloc] init];
    _zhawColor      = [[ColorSelection alloc]init];
    
    _tableRows = 0;
    
    self._gastronomyFacilityArray = [[GastronomicFacilityArrayDto alloc] init:nil];
    
    self._actualDate = [NSDate date];
    //self._actualDate    = [[_dateFormatter _dayFormatter] dateFromString:@"20.02.2013"];
    
    
    // title
    UIBarButtonItem *_backButtonItem = [[UIBarButtonItem alloc] initWithTitle:LeftArrowSymbol style:UIBarButtonItemStyleBordered target:self action:@selector(moveBackToMenuOverview:)];
    [_backButtonItem setTitleTextAttributes:@{NSForegroundColorAttributeName:_zhawColor._zhawWhite} forState:UIControlStateNormal];
    [_titleNavigationItem setLeftBarButtonItem :_backButtonItem animated :true];
    [_titleNavigationItem setTitle:MensaVCTitle];

    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           UITextAttributeTextColor: _zhawColor._zhawWhite,
                                                           UITextAttributeFont: [UIFont fontWithName:NavigationBarFont size:NavigationBarTitleSize],
                                                           }];
    [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:NavigationBarBackground] forBarMetrics:UIBarMetricsDefault];
    
    
    
    NSString *_dateString = [NSString stringWithFormat:@"%@, %@"
                             ,[[_dateFormatter _weekDayFormatter] stringFromDate:self._actualDate]
                             ,[[_dateFormatter _dayFormatter]     stringFromDate:self._actualDate]];
    
    [_titleNavigationItem setTitle:MensaVCTitle];
    [_dateNavigationItem setTitle:_dateString];
    
    // set default values for spinner/activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
    
    [self.view bringSubviewToFront:_noConnectionButton];
    [self.view bringSubviewToFront:_noConnectionLabel];
    
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    [_noConnectionButton useAlertStyle];
    [_noConnectionLabel setTextColor:_zhawColor._zhawFontGrey];
    
    // ----- DETAIL PAGE -----
    if (_mensaDetailVC == nil)
    {
		_mensaDetailVC = [[MensaDetailViewController alloc] init];
	}
    _mensaDetailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
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
 * @function viewDidLoad
 * The function is included, since class inherits from UIViewController.
 * Is called first time, the view is started for initialization.
 * Is only called once, after initialization, never again.
 */
- (void)viewDidUnload
{
    [self set_mensaOverviewTable:nil];
    _mensaOverviewTable = nil;
    _mensaOverviewTableCell = nil;
    _mensaDetailVC = nil;
    
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _dateNavigationBar = nil;
    _dateNavigationItem = nil;
    
    _waitForChangeActivityIndicator = nil;
    _noConnectionLabel = nil;
    _noConnectionButton = nil;
    [super viewDidUnload];
}

/*!
 @function moveBackToMenuOverview
 Function is called, when back button on navigation bar is hit, to move back to gastronomic facilties overview.
 @param sender
 */
- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
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
 * @function startLoading
 * Called to start thread for the activity indicator to indicate data is loaded and the user needs to wait.
 */
-(void)startLoading
{
    self._noConnectionButton.hidden = YES;
    self._noConnectionLabel.hidden = YES;
    [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
}

/*!
 * @function doneLoading
 * Called to trigger loading all data and stop the thread for the activity indicator.
 */
-(void)doneLoading
{
    [_gastronomyFacilityArray getData];
    [_mensaOverviewTable reloadData];
    [_waitForChangeActivityIndicator stopAnimating];
    _waitForChangeActivityIndicator.hidden = YES;
    
    if ( [_gastronomyFacilityArray._gastronomicFacilities count] == 0 )
    {
        _noConnectionButton.hidden = NO;
        _noConnectionLabel.hidden = NO;
    }
}

/*!
 @function tryConnectionAgain
 Triggered by clicking the _noConnectionButton, another trial to connect to server is started.
 @param sender
 */
- (IBAction)tryConnectionAgain:(id)sender
{
    [self startLoading];
    [self doneLoading];
}

/*!
 * @function viewWillAppear
 * The function is included, since class inherits from UIViewController.
 * It is called every time the view is called again.
 */
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    self._actualDate = [NSDate date];
    [self startLoading];
}

/*!
 * @function viewDidAppear
 * The function is included, since class inherits from UIViewController.
 * It is called before viewWillAppear is called.
 * It is needed to respond to the shaking gesture.
 */
-(void)viewDidAppear:(BOOL)animated
{
    [self doneLoading];
}


// ------- MANAGE TABLE CELLS ----
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
    return [_gastronomyFacilityArray._gastronomicFacilities count];
}

/*!
 * @function showGastronomy
 * Method to show the single gastronomic facility in one table cell.
 */
- (UITableViewCell *)showGastronomy:(UITableView *)actualTableView
                 withGastronomyName:(NSString *)gastronomyName
                 withGastronomyType:(NSString *)gastronomyType
                    withOpeningTime:(NSString *)openingTime
                      withLunchTime:(NSString *)lunchTime
{
    static NSString *_cellIdentifier = @"MensaOverviewTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MensaOverviewTableCell" owner:self options:nil];
        _cell = _mensaOverviewTableCell;
        self._mensaOverviewTableCell = nil;
    }
    
    UILabel          *_mensaLabel           = (UILabel  *)[_cell viewWithTag:1];
    UILabel          *_openingTimesLabel    = (UILabel  *)[_cell viewWithTag:2];
    UILabel          *_lunchTimesLabel      = (UILabel  *)[_cell viewWithTag:3];
    
    [_mensaLabel        setTextColor:_zhawColor._zhawFontGrey];
    [_openingTimesLabel setTextColor:_zhawColor._zhawFontGrey];
    [_lunchTimesLabel   setTextColor:_zhawColor._zhawFontGrey];
    
    _mensaLabel.text = [NSString stringWithFormat:@"%@ (%@)", gastronomyName
                        ,[_translator getGermanGastronomyTypeTranslation:gastronomyType]
                        ];
    
    _openingTimesLabel.text = openingTime;
    _lunchTimesLabel.text   = lunchTime;

    return _cell;
}

/*!
 * @function cellForRowAtIndexPath
 * The function is for customizing the table view cells.
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger    _cellRow = indexPath.row;
    NSString     *_gastronomyName;
    NSString     *_gastronomyType;
    NSString     *_openingTime;
    NSString     *_lunchTime = @"";
    BOOL          _isHoliday = NO;
    
    NSString     *_fromHolidayString;
    NSString     *_toHolidayString;
    NSString     *_actualDayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_actualDate];
    NSString     *_actualDayWeekday = [[_dateFormatter _weekDayFormatter] stringFromDate:_actualDate];
    NSString     *_oneDayWeekdayGermanTranslation;
    
    int           holidayArrayI;
    int           serviceTimePeriodArrayI;
    int           weekdaysArrayForOpeningTimePlanI;
    int           weekdaysArrayForLunchTimePlanI;
    
    ServiceTimePeriodDto    *_oneServiceTimePeriod;
    LunchTimePlanDto        *_lunchTimePlan;
    OpeningTimePlanDto      *_openingTimePlan;
    WeekdayDto              *_oneWeekdayForOpeningTimePlan;
    WeekdayDto              *_oneWeekdayForLunchTimePlan;
    
    
    if (    [_gastronomyFacilityArray._gastronomicFacilities lastObject] != nil
        &&  [_gastronomyFacilityArray._gastronomicFacilities count] > _cellRow)
    {
        //NSLog(@"xx _gastronomyArray count %i _cellRow %i", [_gastronomyFacilityArray._gastronomicFacilities count], _cellRow);
        GastronomicFacilityDto *_oneGastronomy = [_gastronomyFacilityArray._gastronomicFacilities objectAtIndex:_cellRow];
        _gastronomyName = _oneGastronomy._name;
        _gastronomyType = _oneGastronomy._type;
        
        //NSLog(@"xxxx _gastronomyName %@ _gastronomyType %@", _gastronomyName, _gastronomyType);
        
        HolidayDto *_oneHoliday;
        
        if ([_oneGastronomy._holidays lastObject] != nil)
        {
            for (holidayArrayI=0; holidayArrayI < [_oneGastronomy._holidays count]; holidayArrayI++)
            {
                _oneHoliday = [_oneGastronomy._holidays objectAtIndex:holidayArrayI];
            
                _fromHolidayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_oneHoliday._startsAt];
                _toHolidayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_oneHoliday._endsAt];
                
                //NSLog(@"holiday? _actualDayString %@ with from %@ and to %@", _actualDayString, _fromHolidayString, _toHolidayString);
            
                // _fromString is later in time than _fromLocalScheduleEvent
                // and _fromString is earlier in time than _toLocalScheduleEvent
                if (
                     (  [_actualDayString          compare: _fromHolidayString  ] == NSOrderedDescending
                     && [_actualDayString          compare: _toHolidayString    ] == NSOrderedAscending
                     )
                    ||[_actualDayString compare: _fromHolidayString] == NSOrderedSame
                    ||[_actualDayString compare: _toHolidayString  ] == NSOrderedSame
                   )
                {
                    _isHoliday = YES;
                }
            
            }
        }
        
        if (_isHoliday)
        {
            _openingTime = MensaClosed;
        }
        else
        {
            //NSLog(@"serviceTimePeriod count: %i", [_oneGastronomy._serviceTimePeriods count]);
            
            if([ _oneGastronomy._serviceTimePeriods lastObject] == nil)
            {
                _openingTime = MensaClosed;
            }
            else
            {
                //NSLog(@"serviceTimePeriod last object is not nil");
                for (serviceTimePeriodArrayI=0; serviceTimePeriodArrayI < [_oneGastronomy._serviceTimePeriods count]; serviceTimePeriodArrayI++)
                {
                    _oneServiceTimePeriod = [_oneGastronomy._serviceTimePeriods objectAtIndex:serviceTimePeriodArrayI];
                    _openingTimePlan = _oneServiceTimePeriod._openingTimePlan;
                    _lunchTimePlan   = _oneServiceTimePeriod._lunchTimePlan;
                
                    //NSLog(@"weekday count: %i", [_openingTimePlan._weekdays count]);
                
                    if([_openingTimePlan._weekdays lastObject] != nil)
                    {
                        for (weekdaysArrayForOpeningTimePlanI = 0; weekdaysArrayForOpeningTimePlanI < [_openingTimePlan._weekdays count]; weekdaysArrayForOpeningTimePlanI++)
                        {
                            _oneWeekdayForOpeningTimePlan = [_openingTimePlan._weekdays objectAtIndex:weekdaysArrayForOpeningTimePlanI];
                            _oneDayWeekdayGermanTranslation = [NSString stringWithFormat:@"%@",[_translator getGermanWeekdayTranslation:_oneWeekdayForOpeningTimePlan._weekdayType]];
                            
                            //NSLog(@"compare weekdays: %@ (%@) - %@", _oneWeekday._weekdayType, _oneDayWeekdayGermanTranslation, _actualDayWeekday);
                            
                            if( [_oneWeekdayForOpeningTimePlan._weekdayType caseInsensitiveCompare:_actualDayWeekday] == NSOrderedSame
                               ||  [_oneDayWeekdayGermanTranslation  caseInsensitiveCompare:_actualDayWeekday] == NSOrderedSame
                               )
                            {
                                if (_oneWeekdayForOpeningTimePlan._fromTime == nil && _oneWeekdayForOpeningTimePlan._toTime == nil)
                                {
                                    _openingTime = MensaClosed;
                                }
                                else
                                {
                                    _openingTime = [NSString stringWithFormat:@"offen von %@ bis %@",
                                            [[_dateFormatter _timeFormatter] stringFromDate:_oneWeekdayForOpeningTimePlan._fromTime]
                                            ,[[_dateFormatter _timeFormatter] stringFromDate:_oneWeekdayForOpeningTimePlan._toTime]
                                            ];
                                    
                                    if([_lunchTimePlan._weekdays lastObject] != nil)
                                    {
                                        for (weekdaysArrayForLunchTimePlanI = 0; weekdaysArrayForLunchTimePlanI < [_lunchTimePlan._weekdays count]; weekdaysArrayForLunchTimePlanI++)
                                        {
                                            _oneWeekdayForLunchTimePlan = [_lunchTimePlan._weekdays objectAtIndex:weekdaysArrayForLunchTimePlanI];
                                            _oneDayWeekdayGermanTranslation = [NSString stringWithFormat:@"%@",[_translator getGermanWeekdayTranslation:_oneWeekdayForLunchTimePlan._weekdayType]];
                                            
                                            //NSLog(@"compare weekdays: %@ (%@) - %@", _oneWeekdayForLunchTimePlan._weekdayType, _oneDayWeekdayGermanTranslation, _actualDayWeekday);
                                            
                                            if( [_oneWeekdayForLunchTimePlan._weekdayType caseInsensitiveCompare:_actualDayWeekday] == NSOrderedSame
                                               ||  [_oneDayWeekdayGermanTranslation  caseInsensitiveCompare:_actualDayWeekday] == NSOrderedSame
                                               )
                                            {
                                                _lunchTime = [NSString stringWithFormat:@"Mittagessen von %@ bis %@",
                                                                 [[_dateFormatter _timeFormatter] stringFromDate:_oneWeekdayForLunchTimePlan._fromTime]
                                                                 ,[[_dateFormatter _timeFormatter] stringFromDate:_oneWeekdayForLunchTimePlan._toTime]
                                                                 ];
                                            }
                                        }
                                    }
                                    else
                                    {
                                        _lunchTime   = @"kein Mittagsmenü";
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    return [self showGastronomy :tableView
            withGastronomyName  :_gastronomyName
            withGastronomyType  :_gastronomyType
            withOpeningTime     :_openingTime
            withLunchTime       :_lunchTime];
}

/*!
 * @function heightForRowAtIndexPath
 * The function is for customizing the table view cells.
 * It sets the height for each cell individually.
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}

/*!
 * @function didSelectRowAtIndexPath
 * The function supports row selection.
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger    _cellSelection = indexPath.row;
    GastronomicFacilityDto *_oneGastronomy = [_gastronomyFacilityArray._gastronomicFacilities objectAtIndex:_cellSelection];
    
    //NSString *_actualDateString = [[_dateFormatter _dayFormatter] stringFromDate:_actualDate];
    //NSLog(@"you've selected %@ for date %@", _oneGastronomy._name, _actualDateString);
    
    _mensaDetailVC._actualGastronomy = _oneGastronomy;
    _mensaDetailVC._gastronomyLabel.text  = _oneGastronomy._name;
    _mensaDetailVC._actualDate = _actualDate;
    [self presentModalViewController:_mensaDetailVC animated:YES];
    
}

/*!
 * @function scrollViewDidScroll
 * Triggers reload of data while scrolling.
 */
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //NSLog(@"scrolling table");
    if (_tableRows < [_gastronomyFacilityArray._gastronomicFacilities count])
    {
        [_mensaOverviewTable reloadData];
    }
    
}
    
@end
