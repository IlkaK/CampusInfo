/*
 GastronomicFacilityArrayDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header GastronomicFacilityArrayDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds gastronomic facitlity array in MensaOverviewDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain gastronomic facility data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It does not need extra data to build the url which is send to the server. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> Using TimeTableAsyncRequestDelegate it gets the date from server request. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "GastronomicFacilityArrayDto.h"
#import "URLConstantStrings.h"

@implementation GastronomicFacilityArrayDto
@synthesize _dateFormatter;
@synthesize _gastronomicFacilities;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _generalDictionary;
@synthesize _url;

@synthesize _threadDone;
@synthesize _noConnection;

/*!
 @function init
 Initializes GastronomicFacilityArrayDto.
 @param newGastronomicFacilities
 */
-(id) init:(NSMutableArray *) newGastronomicFacilities
{
    self = [super init];
    if (self)
    {
        if (newGastronomicFacilities == nil)
        {
            _gastronomicFacilities = [[NSMutableArray alloc] init];
        }
        else
        {
            self._gastronomicFacilities = newGastronomicFacilities;
        }
    }
    NSString *_urlString = URLGastroArray;
    
    _url = [NSURL URLWithString:_urlString];
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
    _dateFormatter  = [[DateFormation alloc] init];
    _threadDone = NO;
    _noConnection = YES;
    return self;
}

//-------------------------------
// asynchronous request
//-------------------------------
/*!
 @function dataDownloadDidFinish
 Needed since TimeTableAsyncRequest is used.
 Function receives data, when download from server is finished.
 */
-(void) dataDownloadDidFinish:(NSData*) data
{
    
    self._dataFromUrl = data;
    
    // NSLog(@"dataDownloadDidFinish 1 %@",[NSThread callStackSymbols]);
    
    if (self._dataFromUrl != nil)
    {
        //NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
        //_receivedString = [_receivedString substringToIndex:5000];
        //NSLog(@"dataDownloadDidFinish for GastronomyFacilityArrayDto: %@", _receivedString);
        
        NSError *_error;
        //_gastronomicFacilities = [[NSMutableArray alloc] init];
        
        //if (_generalDictionary == nil)
        //{
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSArray *_gastronomicArray = [[NSArray alloc] init];
        int _gastronomicArrayI;
        
        GastronomicFacilityDto *_localGastronomicFacilty = [[GastronomicFacilityDto alloc]init:nil withGastroId:0 withLocation:nil withName:nil withServiceTimePeriods:nil withType:nil withVersion:nil];
        GastronomicFacilityDto *_localFormerGastronomy = [[GastronomicFacilityDto alloc]init:nil withGastroId:0 withLocation:nil withName:nil withServiceTimePeriods:nil withType:nil withVersion:nil];
        
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
                //NSLog(@"vorher gastronomies count: %i", [_gastronomicFacilities count]);
                if ([_gastronomicFacilities count] == 0)
                {
                    //self._errorMessage = nil;
                    // define type of schedule
                    if ([generalKey isEqualToString:@"gastronomicFacilities"])
                    {
                        _gastronomicArray = [_generalDictionary objectForKey:generalKey];
                        //NSLog(@"vorher _gastronomicArray count: %i", [_gastronomicArray count]);
                        NSDictionary *_gastronomicFacilityDictionary; 
                    
                        for (_gastronomicArrayI = 0; _gastronomicArrayI < [_gastronomicArray count]; _gastronomicArrayI++)
                        {
                            //NSLog(@"start gastronomic facility: %i", _gastronomicArrayI);
                            _gastronomicFacilityDictionary = [_gastronomicArray objectAtIndex:_gastronomicArrayI];
                            //NSLog(@"getting gastronomicFacilityDictionary: %i", _gastronomicArrayI);
                            _localGastronomicFacilty = [_localGastronomicFacilty getGastronomicFacility:_gastronomicFacilityDictionary];
                            
                            if ([_gastronomicFacilities count] > 0)
                            {
                                _localFormerGastronomy = _gastronomicFacilities.lastObject;
                                if(_localFormerGastronomy._gastroId == _localGastronomicFacilty._gastroId)
                                {
                                //    NSLog(@"same connection don't add again");
                                    
                                }
                                else
                                {
                                    [_gastronomicFacilities addObject:_localGastronomicFacilty];
                                }
                            }
                            else
                            {
                                //NSLog(@"found new gastronomic facility: %i", _gastronomicArrayI);
                                [_gastronomicFacilities addObject:_localGastronomicFacilty];
                                //NSLog(@"added new gastronomic facility: %i", _gastronomicArrayI);
                            }
                        }
                    }
                }
                //NSLog(@"nacher gastronomies count: %i", [_gastronomicFacilities count]);
            }
        }
    }
}

/*!
 @function threadDone
 Needed since TimeTableAsyncRequest is used.
 If thread to download data is done, this function is called.
 */
-(void)threadDone:(NSNotification*)arg
{
    _threadDone = YES;
}

/*!
 @function downloadData
 Needed since TimeTableAsyncRequest is used.
 Function sends the request for data to server.
 */
-(void) downloadData
{

    [_asyncTimeTableRequest downloadData:_url];
}

/*!
 @function getDictionaryFromUrl
 Needed since TimeTableAsyncRequest is used.
 TimeTableAsyncRequest is initialized and data download is triggered here.
 If data is downloaded from server it is processed as well.
 */
- (NSDictionary *) getDictionaryFromUrl
{
    //[self performSelectorInBackground:@selector(downloadData) withObject:nil];
    [self performSelectorOnMainThread:@selector(downloadData) withObject:nil waitUntilDone:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    NSError      *_error = nil;
    if (_dataFromUrl == nil)
    {
        return nil;
    }
    else
    {
        //NSLog(@"getDictionaryFromUrl got some data putting it now into dictionary");
        NSDictionary *_scheduleDictionary = [NSJSONSerialization
                               JSONObjectWithData:_dataFromUrl
                               options:kNilOptions
                               error:&_error];
        return _scheduleDictionary;
    }
}


/*!
 @function getData
 Gets gastronomic facitlities.
 */
-(void) getData
{
    _threadDone = NO;
    //self._generalDictionary = nil;
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        //NSLog(@"GastronomicFacilityArrayDto: no connection");
        _noConnection = YES;
    }
    else
    {
        _noConnection = NO;
    }
}


@end
