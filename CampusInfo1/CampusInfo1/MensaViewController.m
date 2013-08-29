//
//  MensaViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import "MensaViewController.h"
#import "GastronomicFacilityDto.h"
#import "HolidayDto.h"
#import "ServiceTimePeriodDto.h"
#import "OpeningTimePlanDto.h"
#import "LunchTimePlanDto.h"
#import "WeekdayDto.h"
#import "ColorSelection.h"

@implementation MensaViewController

@synthesize _mensaOverviewTable;
@synthesize _mensaOverviewTableCell;

@synthesize _gastronomyFacilityArray;

@synthesize _actualDate;
@synthesize _dateFormatter;
@synthesize _translator;
@synthesize _mensaDetailVC;

@synthesize _dateLabel;
@synthesize _backgroundImageView;
@synthesize _noConnectionLabel;
@synthesize _noConnectionButton;

@synthesize _titleNavigationLabel;
@synthesize _titleNavigationItem;
@synthesize _titleNavigationBar;

@synthesize _waitForChangeActivityIndicator;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    _dateFormatter  = [[DateFormation alloc] init];
    _translator     = [[LanguageTranslation alloc] init];
    ColorSelection *_zhawColor = [[ColorSelection alloc]init];
    
    self._gastronomyFacilityArray = [[GastronomicFacilityArrayDto alloc] init:nil];
    
    self._actualDate = [NSDate date];
    //self._actualDate    = [[_dateFormatter _dayFormatter] dateFromString:@"20.02.2013"];
    
    NSString *_dateString = [NSString stringWithFormat:@"%@, %@"
                             ,[[_dateFormatter _weekDayFormatter] stringFromDate:self._actualDate]
                             ,[[_dateFormatter _dayFormatter]     stringFromDate:self._actualDate]];
    
    _dateLabel.text = _dateString;
    
    
    // ----- DETAIL PAGE -----
    if (_mensaDetailVC == nil)
    {
		_mensaDetailVC = [[MensaDetailViewController alloc] init];
	}
    _mensaDetailVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    
    UIButton *backButton = [UIButton buttonWithType:101];
    UIView *backButtonView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backButton.frame.size.width, backButton.frame.size.height)];
    
    [backButton addTarget:self action:@selector(moveBackToMenuOverview:) forControlEvents:UIControlEventTouchUpInside];
    [backButton setTitle:@"zurück" forState:UIControlStateNormal];
    [backButtonView addSubview:backButton];
    
    // set buttonview as custom view for bar button item
    UIBarButtonItem *backButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButtonView];
    [_titleNavigationItem setLeftBarButtonItem :backButtonItem animated :true];
    
    [_titleNavigationLabel setTextColor:_zhawColor._zhawWhite];
    _titleNavigationLabel.text = @"Mensa";
    _titleNavigationItem.title = @"";
    
    CGRect imageRect = CGRectMake(0, 0, _titleNavigationBar.frame.size.width, _titleNavigationBar.frame.size.height);
    UIGraphicsBeginImageContext(imageRect.size);
    [_zhawColor._zhawOriginalBlue set];
    UIRectFill(imageRect);
    UIImage *aImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [_titleNavigationBar setBackgroundImage:aImage forBarMetrics:UIBarMetricsDefault];
    
    [_titleNavigationLabel setBackgroundColor:_zhawColor._zhawOriginalBlue];
    
    // set default values for spinner/activity indicator
    _waitForChangeActivityIndicator.hidesWhenStopped = YES;
    _waitForChangeActivityIndicator.hidden = YES;
    [_waitForChangeActivityIndicator setBackgroundColor:_zhawColor._zhawOriginalBlue];
    [self.view bringSubviewToFront:_waitForChangeActivityIndicator];
    
    
    [self.view bringSubviewToFront:_noConnectionButton];
    [self.view bringSubviewToFront:_noConnectionLabel];
    [self.view bringSubviewToFront:_dateLabel];
    
    [_backgroundImageView setBackgroundColor:_zhawColor._zhawLighterBlue];
    [_noConnectionLabel setTextColor:_zhawColor._zhawWhite];
    [_dateLabel setTextColor:_zhawColor._zhawWhite];
    
    _noConnectionButton.hidden = YES;
    _noConnectionLabel.hidden = YES;
    [_noConnectionButton useAlertStyle];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidUnload {
    [self set_mensaOverviewTable:nil];
    _mensaOverviewTable = nil;
    _mensaOverviewTableCell = nil;
    _dateLabel = nil;
    _mensaDetailVC = nil;
    _titleNavigationBar = nil;
    _titleNavigationItem = nil;
    _titleNavigationLabel = nil;
    _waitForChangeActivityIndicator = nil;
    _noConnectionLabel = nil;
    _noConnectionButton = nil;
    _backgroundImageView = nil;
    [super viewDidUnload];
}

- (void)moveBackToMenuOverview:(id)sender
{
    [self dismissModalViewControllerAnimated:YES];
    self.tabBarController.selectedIndex = 0;
}


- (void) threadWaitForChangeActivityIndicator:(id)data
{
    _waitForChangeActivityIndicator.hidden = NO;
    [_waitForChangeActivityIndicator startAnimating];
}

- (void) getGastronomyFacilityArray
{
    //int _actualTrials = 0;
    
    [NSThread detachNewThreadSelector:@selector(threadWaitForChangeActivityIndicator:) toTarget:self withObject:nil];
    
    //NSLog(@"gastronomy faciliities count: %i",[_gastronomyFacilityArray._gastronomicFacilities count]);
    
    //while (_actualTrials < 20 && [_gastronomyFacilityArray._gastronomicFacilities count] == 0)
    //{
        //NSLog(@"viewWillAppear Loop: %i", _actualTrials);
        [_gastronomyFacilityArray getData];
        //_actualTrials++;
    //}

    
    [_waitForChangeActivityIndicator stopAnimating];
    _waitForChangeActivityIndicator.hidden = YES;
    
    if ([_gastronomyFacilityArray._gastronomicFacilities count] == 0)
    {
        _noConnectionButton.hidden = NO;
        _noConnectionLabel.hidden = NO;
    }
    else
    {
        if (_gastronomyFacilityArray._threadDone == YES)
        {
            _noConnectionButton.hidden = YES;
            _noConnectionLabel.hidden = YES;
            [_mensaOverviewTable reloadData];
        }
    }

}

- (IBAction)tryConnectionAgain:(id)sender
{
    [self getGastronomyFacilityArray];
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getGastronomyFacilityArray];
}




- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if ([_gastronomyFacilityArray._gastronomicFacilities  lastObject] == nil)
    {
        return 0;
    }
    else
    {
        return [_gastronomyFacilityArray._gastronomicFacilities count];
    }

}

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
    
    _mensaLabel.text = [NSString stringWithFormat:@"%@ (%@)", gastronomyName
                        ,[_translator getGermanGastronomyTypeTranslation:gastronomyType]
                        ];
    
    _openingTimesLabel.text = openingTime;
    _lunchTimesLabel.text   = lunchTime;

    return _cell;
}


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
        NSLog(@"_gastronomyArray count %i cellSelection %i", [_gastronomyFacilityArray._gastronomicFacilities count], _cellRow);

        
        GastronomicFacilityDto *_oneGastronomy = [_gastronomyFacilityArray._gastronomicFacilities objectAtIndex:_cellRow];
        _gastronomyName = _oneGastronomy._name;
        _gastronomyType = _oneGastronomy._type;
        
        NSLog(@"_gastronomyName %@ _gastronomyType %@", _gastronomyName, _gastronomyType);

        
        HolidayDto *_oneHoliday;
        
        if ([_oneGastronomy._holidays lastObject] != nil)
        {
            for (holidayArrayI=0; holidayArrayI < [_oneGastronomy._holidays count]; holidayArrayI++)
            {
                _oneHoliday = [_oneGastronomy._holidays objectAtIndex:holidayArrayI];
            
                _fromHolidayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_oneHoliday._startsAt];
                _toHolidayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_oneHoliday._endsAt];
                //NSLog(@"_actualDayString %@ with from %@ and to %@", _actualDayString, _fromHolidayString, _toHolidayString);
            
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
            _openingTime = @"geschlossen";
        }
        else
        {
            //NSLog(@"serviceTimePeriod count: %i", [_oneGastronomy._serviceTimePeriods count]);
            
            if([ _oneGastronomy._serviceTimePeriods lastObject] != nil)
            {
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
                                    _openingTime = @"geschlossen";
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 66;
}




// method necessary for UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger    _cellSelection = indexPath.section;
    GastronomicFacilityDto *_oneGastronomy = [_gastronomyFacilityArray._gastronomicFacilities objectAtIndex:_cellSelection];
    
    //NSString *_actualDateString = [[_dateFormatter _dayFormatter] stringFromDate:_actualDate];
    //NSLog(@"you've selected %@ for date %@", _oneGastronomy._name, _actualDateString);
    
    _mensaDetailVC._actualGastronomy = _oneGastronomy;
    _mensaDetailVC._gastronomyLabel.text  = _oneGastronomy._name;
    _mensaDetailVC._actualDate = _actualDate;
    [self presentModalViewController:_mensaDetailVC animated:YES];
    
}


@end
