//
//  MensaViewController.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import "MensaViewController.h"
#import "GastronomicFacilityDto.h"

@implementation MensaViewController

@synthesize _mensaOverviewTable;
@synthesize _mensaOverviewTableCell;
@synthesize _generalDictionary;
@synthesize _asyncTimeTableRequest;
@synthesize _dataFromUrl;
@synthesize _errorMessage;
@synthesize _connectionTrials;
@synthesize _gastronomyArray;

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
    
    self._gastronomyArray = [[NSMutableArray alloc] init];
    
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
    _mensaLabel.text = gastronomyName;
    
    UILabel          *_detailLabel     = (UILabel  *)[_cell viewWithTag:2];
    _detailLabel.text = gastronomyType;

    return _cell;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSUInteger        _cellSelection = indexPath.section;
    NSString     *_gastronomyName;
    NSString     *_gastronomyType;
    
    if ([_gastronomyArray count] >= _cellSelection)
    {
        GastronomicFacilityDto *_oneGastronomy = [_gastronomyArray objectAtIndex:_cellSelection];
        _gastronomyName = _oneGastronomy._name;
        _gastronomyType = _oneGastronomy._type;
    }
    return [self showGastronomy :tableView
            withGastronomyName:_gastronomyName
            withGastronomyType:_gastronomyType];
}

@end
