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

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
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
    //self._actualDate    = [[_dateFormatter _dayFormatter] dateFromString:@"01.05.2013"];
    
    NSString *_dateString = [NSString stringWithFormat:@"%@, %@"
                             ,[[_dateFormatter _weekDayFormatter] stringFromDate:self._actualDate]
                             ,[[_dateFormatter _dayFormatter]     stringFromDate:self._actualDate]];
    
    _dateLabel.text = _dateString;
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
    self._generalDictionary = nil;
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"MensaViewController: no connection");
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (_connectionTrials < 20)
    {
        //NSLog(@"viewWillAppear try connecting");
        _connectionTrials++;
        [self getData];
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_gastronomyArray count];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)showGastronomy:(UITableView *)actualTableView
                 withGastronomyName:(NSString *)gastronomyName
                 withGastronomyType:(NSString *)gastronomyType
                    withOpeningTime:(NSString *)openingTime
{
    static NSString *_cellIdentifier = @"MensaOverviewTableCell";
    UITableViewCell *_cell           = [actualTableView dequeueReusableCellWithIdentifier:_cellIdentifier];
    if (_cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"MensaOverviewTableCell" owner:self options:nil];
        _cell = _mensaOverviewTableCell;
        self._mensaOverviewTableCell = nil;
    }
    
    UILabel          *_mensaLabel     = (UILabel  *)[_cell viewWithTag:1];
    _mensaLabel.text = [NSString stringWithFormat:@"%@ (%@)", gastronomyName
                        ,[_translator getGermanGastronomyTypeTranslation:gastronomyType]
                        ];
    
    UILabel          *_detailLabel     = (UILabel  *)[_cell viewWithTag:2];
    _detailLabel.text = openingTime;

    return _cell;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger    _cellSelection = indexPath.section;
    NSString     *_gastronomyName;
    NSString     *_gastronomyType;
    NSString     *_openingTime;
    BOOL          _isHoliday = NO;
    
    NSString     *_fromHolidayString;
    NSString     *_toHolidayString;
    NSString     *_actualDayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_actualDate];
    NSString     *_actualDayWeekday = [[_dateFormatter _weekDayFormatter] stringFromDate:_actualDate];
    
    int           holidayArrayI;
    int           serviceTimePeriodArrayI;
    int           weekdaysArrayI;
    
    ServiceTimePeriodDto    *_oneServiceTimePeriod;
    OpeningTimePlanDto      *_openingTimePlan;
    WeekdayDto              *_oneWeekday;
    
    if ([_gastronomyArray count] >= _cellSelection)
    {
        GastronomicFacilityDto *_oneGastronomy = [_gastronomyArray objectAtIndex:_cellSelection];
        _gastronomyName = _oneGastronomy._name;
        _gastronomyType = _oneGastronomy._type;
        HolidayDto *_oneHoliday;
        
        for (holidayArrayI=0; holidayArrayI < [_oneGastronomy._holidays count]; holidayArrayI++)
        {
            _oneHoliday = [_oneGastronomy._holidays objectAtIndex:holidayArrayI];
            
            _fromHolidayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_oneHoliday._startsAt];
            _toHolidayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_oneHoliday._endsAt];
            //NSLog(@"_actualDayString %@ with from %@ and to %@", _actualDayString, _fromHolidayString, _toHolidayString);
            
            // _fromString is later in time than _fromLocalScheduleEvent
            // and _fromString is earlier in time than _toLocalScheduleEvent
            if(
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
        if (_isHoliday)
        {
            _openingTime = @"geschlossen";
        }
        else
        {
            //NSLog(@"serviceTimePeriod count: %i", [_oneGastronomy._serviceTimePeriods count]);
            for (serviceTimePeriodArrayI=0; serviceTimePeriodArrayI < [_oneGastronomy._serviceTimePeriods count]; serviceTimePeriodArrayI++)
            {
                _oneServiceTimePeriod = [_oneGastronomy._serviceTimePeriods objectAtIndex:serviceTimePeriodArrayI];
                _openingTimePlan = _oneServiceTimePeriod._openingTimePlan;
                
                //NSLog(@"weekday count: %i", [_openingTimePlan._weekdays count]);
                
                for (weekdaysArrayI = 0; weekdaysArrayI < [_openingTimePlan._weekdays count]; weekdaysArrayI++)
                {
                    _oneWeekday = [_openingTimePlan._weekdays objectAtIndex:weekdaysArrayI];
                    
                    //NSLog(@"compare weekdays: %@ - %@", _oneWeekday._weekdayType, _actualDayWeekday);
                    
                    if( [_oneWeekday._weekdayType caseInsensitiveCompare:_actualDayWeekday] == NSOrderedSame )
                    {
                        if (_oneWeekday._fromTime == nil && _oneWeekday._toTime == nil)
                        {
                            _openingTime = @"geschlossen";
                        }
                        else
                        {
                            _openingTime = [NSString stringWithFormat:@"offen von %@ bis %@",
                                            [[_dateFormatter _timeFormatter] stringFromDate:_oneWeekday._fromTime]
                                            ,[[_dateFormatter _timeFormatter] stringFromDate:_oneWeekday._toTime]
                                            ];
                        }
                    }
                }
            }
        }
    }
    return [self showGastronomy :tableView
            withGastronomyName:_gastronomyName
            withGastronomyType:_gastronomyType
            withOpeningTime:_openingTime];
}

@end
