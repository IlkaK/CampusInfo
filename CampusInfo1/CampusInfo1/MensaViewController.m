//
//  MensaViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import "MensaViewController.h"
#import "LunchTimePlanDto.h"
#import "OpeningTimePlanDto.h"

@implementation MensaViewController

@synthesize _mensaOverviewTable;
@synthesize _mensaOverviewTableCell;
@synthesize _generalDictionary;
@synthesize _asyncTimeTableRequest;
@synthesize _dataFromUrl;
@synthesize _errorMessage;
@synthesize _connectionTrials;

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
    _generalDictionary = nil;
    self._connectionTrials = 1;
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
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSDictionary *_oneGastronomicDictionary;
        NSDictionary *_oneHolidayDictionary;
        NSDictionary *_locationDictionary;
        NSDictionary *_oneServiceTimePeriodDictionary;
        NSArray  *_gastronomicArray;
        NSArray *_holidayArray;
        NSArray *_serviceTimePeriodArray;
        int _gastronomicArrayI;
        int _holidayArrayI;
        int _serviceTimePeriodArrayI;
        
        
        LunchTimePlanDto *_localLunchTimePlan = [[LunchTimePlanDto alloc] init:nil withPlanType:nil];
        OpeningTimePlanDto *_localOpeningTimePlan = [[OpeningTimePlanDto alloc] init:nil withPlanType:nil];
        
        for (id generalKey in _generalDictionary)
        {
            NSLog(@"generalDictionary key: %@", generalKey);
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
                    
                    NSLog(@"count of _gastronomicArray: %i", [_gastronomicArray count]);
                    
                    for (_gastronomicArrayI = 0; _gastronomicArrayI < [_gastronomicArray count]; _gastronomicArrayI++)
                    {
                        _oneGastronomicDictionary = [_gastronomicArray objectAtIndex:_gastronomicArrayI];
                    
                        for (id oneGastronomicKey in _oneGastronomicDictionary)
                        {
                            //NSLog(@"_gastronomicFacilitiesDictionary key: %@", gastronomicFacilitiesKey);
                            
                            if ([oneGastronomicKey isEqualToString:@"holidays"])
                            {
                                _holidayArray = [_oneGastronomicDictionary objectForKey:oneGastronomicKey];
                                for (_holidayArrayI = 0; _holidayArrayI < [_holidayArray count]; _holidayArrayI++)
                                {
                                    _oneHolidayDictionary = [_holidayArray objectAtIndex:_holidayArrayI];
                                    for (id holidayKey in _oneHolidayDictionary)
                                    {
                                        if ([holidayKey isEqualToString:@"id"])
                                        {
                                            NSLog(@"holiday id: %@", [_oneHolidayDictionary objectForKey:holidayKey]);
                                        }
                                        if ([holidayKey isEqualToString:@"version"])
                                        {
                                            NSLog(@"holiday version: %@", [_oneHolidayDictionary objectForKey:holidayKey]);
                                        }
                                        if ([holidayKey isEqualToString:@"name"])
                                        {
                                            NSLog(@"holiday name: %@", [_oneHolidayDictionary objectForKey:holidayKey]);
                                        }
                                        if ([holidayKey isEqualToString:@"startsAt"])
                                        {
                                            NSLog(@"holiday startsAt: %@", [_oneHolidayDictionary objectForKey:holidayKey]);
                                        }
                                        if ([holidayKey isEqualToString:@"endsAt"])
                                        {
                                            NSLog(@"holiday endsAt: %@", [_oneHolidayDictionary objectForKey:holidayKey]);
                                        }
                                    }
                                }
                            }
                            if ([oneGastronomicKey isEqualToString:@"id"])
                            {
                                NSLog(@"gastronomy id: %@", [_oneGastronomicDictionary objectForKey:oneGastronomicKey]);
                            }
                            if ([oneGastronomicKey isEqualToString:@"name"])
                            {
                                NSLog(@"gastronomy name: %@", [_oneGastronomicDictionary objectForKey:oneGastronomicKey]);
                            }
                            if ([oneGastronomicKey isEqualToString:@"type"])
                            {
                                NSLog(@"gastronomy type: %@", [_oneGastronomicDictionary objectForKey:oneGastronomicKey]);
                            }
                            if ([oneGastronomicKey isEqualToString:@"version"])
                            {
                                NSLog(@"gastronomy version: %@", [_oneGastronomicDictionary objectForKey:oneGastronomicKey]);
                            }
                            if ([oneGastronomicKey isEqualToString:@"location"])
                            {
                                _locationDictionary = [_oneGastronomicDictionary objectForKey:oneGastronomicKey];
                                for (id locationKey in _locationDictionary)
                                {
                                    if ([locationKey isEqualToString:@"id"])
                                    {
                                        NSLog(@"location id: %@", [_locationDictionary objectForKey:locationKey]);
                                    }
                                    if ([locationKey isEqualToString:@"version"])
                                    {
                                        NSLog(@"location version: %@", [_locationDictionary objectForKey:locationKey]);
                                    }
                                    if ([locationKey isEqualToString:@"name"])
                                    {
                                        NSLog(@"location name: %@", [_locationDictionary objectForKey:locationKey]);
                                    }
                                }
                            }
                            if ([oneGastronomicKey isEqualToString:@"serviceTimePeriods"])
                            {
                                _serviceTimePeriodArray = [_oneGastronomicDictionary objectForKey:oneGastronomicKey];
                                for (_serviceTimePeriodArrayI = 0; _serviceTimePeriodArrayI < [_serviceTimePeriodArray count]; _serviceTimePeriodArrayI++)
                                {
                                    _oneServiceTimePeriodDictionary = [_serviceTimePeriodArray objectAtIndex:_serviceTimePeriodArrayI];
                                    for (id oneServiceTimePeriodKey in _oneServiceTimePeriodDictionary)
                                    {
                                        if ([oneServiceTimePeriodKey isEqualToString:@"id"])
                                        {
                                            NSLog(@"service time period id: %@", [_oneServiceTimePeriodDictionary objectForKey:oneServiceTimePeriodKey]);
                                        }
                                        if ([oneServiceTimePeriodKey isEqualToString:@"startsAt"])
                                        {
                                            NSLog(@"service time period startsAt: %@", [_oneServiceTimePeriodDictionary objectForKey:oneServiceTimePeriodKey]);
                                        }
                                        if ([oneServiceTimePeriodKey isEqualToString:@"endsAt"])
                                        {
                                            NSLog(@"service time period endsAt: %@", [_oneServiceTimePeriodDictionary objectForKey:oneServiceTimePeriodKey]);
                                        }
                                        if ([oneServiceTimePeriodKey isEqualToString:@"lunchTimePlan"])
                                        {
                                            _localLunchTimePlan = [_localLunchTimePlan getLunchTimePlan:[_oneServiceTimePeriodDictionary objectForKey:oneServiceTimePeriodKey]];
                                        }
                                        if ([oneServiceTimePeriodKey isEqualToString:@"openingTimePlan"])
                                        {
                                            _localOpeningTimePlan = [_localOpeningTimePlan getOpeningTimePlan:[_oneServiceTimePeriodDictionary objectForKey:oneServiceTimePeriodKey]];
                                        }

                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
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
    return 10;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)oneSlotOneRoomWithView:(UITableView *)actualTableView
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
    _mensaLabel.text = [NSString stringWithFormat:@"Gruental"];
    
    UILabel          *_detailLabel     = (UILabel  *)[_cell viewWithTag:2];
    _detailLabel.text = [NSString stringWithFormat:@"offen bis 19:00"];

    return _cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self oneSlotOneRoomWithView :tableView];
}

@end
