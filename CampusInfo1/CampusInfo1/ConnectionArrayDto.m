//
//  ConnectionArrayDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.09.13.
//
//

#import "ConnectionArrayDto.h"
#import "ConnectionDto.h"

@implementation ConnectionArrayDto

@synthesize _connections;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _generalDictionary;
@synthesize _url;


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
        _connections = [[NSMutableArray alloc] init];
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSArray     *_connectionArray;
        int         _connectionArrayI;
        
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
                        
                        NSLog(@"count of _connectionArray: %i", [_connectionArray count]);
                        
                        ConnectionDto *_localConnection = [[ConnectionDto alloc]init:nil withTo:nil withDuration:nil withTransfers:nil withService:nil withProducts:nil withCapacity1st:nil withCapacity2nd:nil withSections:nil];
                        
                        for (_connectionArrayI = 0; _connectionArrayI < [_connectionArray count]; _connectionArrayI++)
                        {
                            _localConnection = [_localConnection getConnection:[_connectionArray objectAtIndex:_connectionArrayI]];
                            [_connections addObject:_localConnection];
                        }
                    }
                }
                NSLog(@"nacher _connections count: %i", [_connections count]);
                
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
    /*
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"(" withString:@"%28"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@")" withString:@"%29"];
    
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"*" withString:@"%2A"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"-" withString:@"%2D"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"." withString:@"%2E"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
    
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];
    
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
    
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"ä" withString:@"&auml;"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"Ä" withString:@"&Auml;"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"ö" withString:@"&ouml;"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"Ö" withString:@"&Ouml;"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"ü" withString:@"&uuml;"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"Ü" withString:@"&Uuml;"];
    _actualStation = [_actualStation stringByReplacingOccurrencesOfString:@"ß" withString:@"&szlig;"];
    */
    
    //NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/transport/web/api.php/v1/locations?query=%@", _actualStation];
    
    NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/transport/web/api.php/v1/connections?from=Basel&to=Winterthur"];

    NSLog(@"url ConnectionArrayDto: %@", _urlString);
    
    _url = [NSURL URLWithString:_urlString];
    [_asyncTimeTableRequest downloadData:_url];
}


- (NSDictionary *) getDictionaryFromUrl
{
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];
    
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



-(void) getData
{
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"ConnectionArrayDto: no connection");
    }
}


@end
