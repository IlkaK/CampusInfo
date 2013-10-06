/*
 ConnectionArrayDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ConnectionArrayDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds connections array in PublicTransportConnectionDto model. </li>
 *      <li> Uses TimeTableAsyncRequestDelegate to connect to server and gain public transportat connection data from there. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives start and stop station to build the url which is send to the server. </li>
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

#import "ConnectionArrayDto.h"
#import "ConnectionDto.h"
#import "CharTranslation.h"
#import "DateFormation.h"
#import "URLConstantStrings.h"

@implementation ConnectionArrayDto

@synthesize _connections;
@synthesize _stopStation;
@synthesize _startStation;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _generalDictionary;
@synthesize _url;

@synthesize _connectionStopStation;
@synthesize _connectionStartStation;

/*!
 @function init
 Initializes ConnectionArrayDto.
 @param newConnections
 */
-(id) init          :(NSMutableArray *) newConnections
{
    self = [super init];
    if (self)
    {
        if (newConnections == nil)
        {
            self._connections = [[NSMutableArray alloc] init];
        }
        else
        {
            self._connections = newConnections;
        }
    }
    
    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self;
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
        //NSLog(@"dataDownloadDidFinish for StationArrayDto: %@", _receivedString);
        
        NSError *_error;
        
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSArray     *_connectionArray;
        int         _connectionArrayI;
        DateFormation *_dateFormatter = [[DateFormation alloc] init];
        
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
                if ([_connectionArray count] == 0)
                {
                    //self._errorMessage = nil;
                    // define type of schedule
                    if ([generalKey isEqualToString:@"connections"])
                    {
                        _connectionArray = [_generalDictionary objectForKey:generalKey];
                        
                        //NSLog(@"count of _connectionArray: %i", [_connectionArray count]);
                        
                        ConnectionDto *_localConnection = [[ConnectionDto alloc]init:0 withTo:nil withDuration:nil withTransfers:0 withService:nil withProducts:nil withCapacity1st:0 withCapacity2nd:0 withSections:nil];
                        ConnectionDto *_localFormerConnection = [[ConnectionDto alloc]init:nil withTo:nil withDuration:nil withTransfers:0 withService:nil withProducts:nil withCapacity1st:0 withCapacity2nd:0 withSections:nil];

                        
                        for (_connectionArrayI = 0; _connectionArrayI < [_connectionArray count]; _connectionArrayI++)
                        {

                            _localConnection = [_localConnection getConnection:[_connectionArray objectAtIndex:_connectionArrayI]];
                            if ([_connections count] > 0)
                            {
                                _localFormerConnection = _connections.lastObject;
                                if (
                                    [_localConnection._from._station._name isEqualToString:_localFormerConnection._from._station._name]
                                    &&
                                    [_localConnection._to._station._name isEqualToString:_localFormerConnection._to._station._name]
                                    &&
                                    [[[_dateFormatter _dayFormatter] stringFromDate:_localConnection._from._departureDate] isEqualToString:[[_dateFormatter _dayFormatter] stringFromDate:_localFormerConnection._from._departureDate]
                                     ]
                                    &&
                                     [[[_dateFormatter _dayFormatter] stringFromDate:_localConnection._from._departureDate] isEqualToString:[[_dateFormatter _dayFormatter] stringFromDate:_localFormerConnection._from._departureDate]
                                      ]
                                    &&
                                      [[[_dateFormatter _timeFormatter] stringFromDate:_localConnection._from._departureTime]
                                       isEqualToString:[[_dateFormatter _timeFormatter] stringFromDate:_localFormerConnection._from._departureTime]
                                       ]
                                    &&
                                      [[[_dateFormatter _dayFormatter] stringFromDate:_localConnection._to._arrivalDate] isEqualToString:[[_dateFormatter _dayFormatter] stringFromDate:_localFormerConnection._to._arrivalDate]
                                       ]
                                    &&
                                       [[[_dateFormatter _timeFormatter] stringFromDate:_localConnection._to._arrivalTime]
                                        isEqualToString:[[_dateFormatter _timeFormatter] stringFromDate:_localFormerConnection._to._arrivalTime]
                                        ]
                                    )
                                {
                                   // NSLog(@"same connection don't add again");
                                    
                                }
                                else
                                {
                                     [_connections addObject:_localConnection];      
                                }
                                       
                            }
                            else
                            {
                                [_connections addObject:_localConnection];
                            }
                            if(_connectionArrayI == 0)
                            {
                                _connectionStartStation = _localConnection._from._station._name;
                                _connectionStopStation  = _localConnection._to._station._name;
                            }
                        }
                    }
                }
                //NSLog(@"nacher _connections count: %i", [_connections count]);
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
    //NSLog(@"Thread exiting");
}

/*!
 @function downloadData
 Needed since TimeTableAsyncRequest is used.
 Function sends the request for data to server.
 */
-(void) downloadData
{
    CharTranslation *_charTranslation = [CharTranslation alloc];
    NSString *_newStopStation = [_charTranslation replaceSpecialCharsUTF8:_stopStation];
    NSString *_newStartStation = [_charTranslation replaceSpecialCharsUTF8:_startStation];

    NSString *_urlString = [NSString stringWithFormat:URLTransportConnections, _newStartStation, _newStopStation];

    //NSLog(@"url ConnectionArrayDto: %@", _urlString);
    
    _url = [NSURL URLWithString:_urlString];
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
 Gets connection array for given start and stop station.
 @param newStartStation
 @param newStopStation
 @param newStations
 */
-(void) getData:(NSString *)newStartStation
withStopStation:(NSString *)newStopStation
withNewStations:(BOOL)newStations
{
    _startStation = newStartStation;
    _stopStation  = newStopStation;
    if (newStations)
    {
        [_connections removeAllObjects];
    }
    self._generalDictionary = [self getDictionaryFromUrl];
    
    //if (self._generalDictionary == nil)
    //{
    //    NSLog(@"ConnectionArrayDto: no connection");
    //}
}


@end
