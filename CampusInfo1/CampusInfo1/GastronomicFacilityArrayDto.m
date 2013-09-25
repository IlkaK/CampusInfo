//
//  GastronomicFacilityArrayDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 28.08.13.
//
//

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


-(void)threadDone:(NSNotification*)arg
{
    _threadDone = YES;
}


-(void) downloadData
{

    [_asyncTimeTableRequest downloadData:_url];
}


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
