//
//  StationArrayDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

#import "StationArrayDto.h"
#import <StationDto.h>
#import "CharTranslation.h"
#import "URLConstantStrings.h"

@implementation StationArrayDto

@synthesize _stations;
@synthesize _actualStation;

@synthesize _errorMessage;
@synthesize _asyncTimeTableRequest;
@synthesize _connectionTrials;
@synthesize _dataFromUrl;
@synthesize _generalDictionary;
@synthesize _url;


-(id) init          :(NSMutableArray *) newStations
{
    self = [super init];
    if (self)
    {
        if (newStations == nil)
        {
            self._stations = [[NSMutableArray alloc] init];
        }
        else
        {
            self._stations = newStations;
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
        ///_receivedString = [_receivedString substringToIndex:5000];
        //NSLog(@"dataDownloadDidFinish for StationArrayDto: %@", _receivedString);
        
        NSError *_error;
        _stations = [[NSMutableArray alloc] init];
        
        //if (_generalDictionary == nil)
        //{
        
        _generalDictionary = [NSJSONSerialization
                              JSONObjectWithData:_dataFromUrl
                              options:kNilOptions
                              error:&_error];
        
        NSArray     *_stationArray;
        int         _stationArrayI;
        
        //GastronomicFacilityDto *_localGastronomicFacilty = [[GastronomicFacilityDto alloc]init:nil withGastroId:nil withLocation:nil withName:nil withServiceTimePeriods:nil withType:nil withVersion:nil];
        
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
                if ([_stationArray count] == 0)
                {
                    //self._errorMessage = nil;
                    // define type of schedule
                    if ([generalKey isEqualToString:@"stations"])
                    {
                        _stationArray = [_generalDictionary objectForKey:generalKey];
                        
                        //NSLog(@"count of _stationArray: %i", [_stationArray count]);
                        
                        StationDto *_localStation = [[StationDto alloc]init:nil withScore:nil withName:nil withDistance:nil withCoordinate:nil];
                        
                        for (_stationArrayI = 0; _stationArrayI < [_stationArray count]; _stationArrayI++)
                        {
                            _localStation = [_localStation getStation:[_stationArray objectAtIndex:_stationArrayI]];
                            [_stations addObject:_localStation];
                        }
                    }
                }
                //NSLog(@"nacher _stations count: %i", [_stations count]);
                
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
    CharTranslation *_charTranslation = [CharTranslation alloc];
    _actualStation = [_charTranslation replaceSpecialChars:_actualStation];
    
    NSString *_urlString = [NSString stringWithFormat:URLStations, _actualStation];
    
    //NSLog(@"url StationArrayDto: %@", _urlString);
    
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



-(void) getData:(NSString *)newActualStation
{
    self._actualStation = newActualStation;
    self._generalDictionary = [self getDictionaryFromUrl];
    
    if (self._generalDictionary == nil)
    {
        NSLog(@"StationArrayDto: no connection");
    }
}


@end
