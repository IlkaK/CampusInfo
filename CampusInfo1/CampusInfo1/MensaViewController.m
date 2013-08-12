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

@implementation MensaViewController

@synthesize _mensaOverviewTable;
@synthesize _mensaOverviewTableCell;
@synthesize _generalDictionary;
@synthesize _asyncTimeTableRequest;
@synthesize _dataFromUrl;
@synthesize _errorMessage;
@synthesize _connectionTrials;
@synthesize _gastronomyArray;
@synthesize _actualDate;
@synthesize _dateFormatter;
@synthesize _translator;
@synthesize _dateLabel;
@synthesize _mensaDetailVC;
@synthesize _titleLabel;

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
    
    _generalDictionary = nil;
    self._connectionTrials = 1;
    
    self._gastronomyArray = [[NSMutableArray alloc] init];
    
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
    
    [self.view bringSubviewToFront:_dateLabel];
    [_dateLabel setTextColor:[UIColor whiteColor]];
    self.navigationItem.titleView = _dateLabel;
    
    UIColor *_backgroundColor = [UIColor colorWithRed:1.0/255.0 green:100.0/255.0 blue:167.0/255.0 alpha:1.0];

    [_titleLabel setBackgroundColor:_backgroundColor];
    [_titleLabel setTextColor:[UIColor whiteColor]];
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
    _titleLabel = nil;
    [super viewDidUnload];
}

// 

//-------------------------------
// asynchronous request
//-------------------------------

-(void) dataDownloadDidFinish:(NSData*) data
{
    
    self._dataFromUrl = data;
    
    // NSLog(@"dataDownloadDidFinish 1 %@",[NSThread callStackSymbols]);
    
    if (self._dataFromUrl != nil)
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:5000];
        //NSLog(@"dataDownloadDidFinish for MensaViewController %@", _receivedString);
        
        NSError *_error;
        
        //if (_generalDictionary == nil)
        //{
        
        [_gastronomyArray removeAllObjects];
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSArray  *_gastronomicArray;
        int _gastronomicArrayI;
        
        GastronomicFacilityDto *_localGastronomicFacilty = [[GastronomicFacilityDto alloc]init:nil withGastroId:nil withLocation:nil withName:nil withServiceTimePeriods:nil withType:nil withVersion:nil];
        
        for (id generalKey in _generalDictionary)
        {
            //NSLog(@"generalDictionary key: %@", generalKey);
            if ([generalKey isEqualToString:@"Message"])
            {
                NSString *_message = [_generalDictionary objectForKey:generalKey];
                //self._errorMessage = _message;
                NSLog(@"Message: %@",_message);
            }
            else
            {
                //self._errorMessage = nil;
                // define type of schedule
                if ([generalKey isEqualToString:@"gastronomicFacilities"])
                {
                    _gastronomicArray = [_generalDictionary objectForKey:generalKey];
                    
                    //NSLog(@"count of _gastronomicArray: %i", [_gastronomicArray count]);
                    
                    for (_gastronomicArrayI = 0; _gastronomicArrayI < [_gastronomicArray count]; _gastronomicArrayI++)
                    {
                        _localGastronomicFacilty = [_localGastronomicFacilty getGastronomicFacility:[_gastronomicArray objectAtIndex:_gastronomicArrayI]];
                        [_gastronomyArray addObject:_localGastronomicFacilty];
                    }
                }
            }
        }
        [_mensaOverviewTable reloadData];
    }
}


-(void)threadDone:(NSNotification*)arg
{
    //NSLog(@"Thread exiting");
}


-(void) downloadData
{
    NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/catering/facilities"];
    
    NSLog(@"urlString: %@", _urlString);
    
    NSURL *_url = [NSURL URLWithString:_urlString];
    [_asyncTimeTableRequest downloadData:_url];
}


- (NSDictionary *) getDictionaryFromUrl
{
    
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    
    NSError      *_error = nil;
    NSDictionary *_scheduleDictionary;
    
    if (_dataFromUrl == nil)
    {
        return nil;
    }
    else
    {
        //NSLog(@"getDictionaryFromUrl got some data putting it now into dictionary");
        _scheduleDictionary = [NSJSONSerialization
                               JSONObjectWithData:_dataFromUrl
                               options:kNilOptions
                               error:&_error];
        
    }
    return _scheduleDictionary;
}



-(void) getData
{
    //self._generalDictionary = nil;
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"MensaViewController: no connection");
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    if (_connectionTrials < 20 && self._generalDictionary == nil)
    {
        //NSLog(@"viewWillAppear try connecting");
        _connectionTrials++;
       [self getData];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [self._gastronomyArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
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
    NSUInteger    _cellSelection = indexPath.section;
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
    
    //NSLog(@"_gastronomyArray count %i cellSelection %i", [_gastronomyArray count], _cellSelection);
    
    if (    [_gastronomyArray lastObject] != nil
        &&  [_gastronomyArray count] > _cellSelection)
    {
        GastronomicFacilityDto *_oneGastronomy = [_gastronomyArray objectAtIndex:_cellSelection];
        _gastronomyName = _oneGastronomy._name;
        _gastronomyType = _oneGastronomy._type;
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
    GastronomicFacilityDto *_oneGastronomy = [_gastronomyArray objectAtIndex:_cellSelection];
    
    //NSString *_actualDateString = [[_dateFormatter _dayFormatter] stringFromDate:_actualDate];
    //NSLog(@"you've selected %@ for date %@", _oneGastronomy._name, _actualDateString);
    
    _mensaDetailVC._actualGastronomy = _oneGastronomy;
    _mensaDetailVC._gastronomyLabel.text  = _oneGastronomy._name;
    _mensaDetailVC._actualDate = _actualDate;
    [self presentModalViewController:_mensaDetailVC animated:YES];
    
}


@end
