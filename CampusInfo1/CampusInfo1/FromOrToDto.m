//
//  FromOrToDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 31.08.13.
//
//

#import "FromOrToDto.h"

@implementation FromOrToDto
@synthesize _platform;
@synthesize _departure;
@synthesize _arrival;
@synthesize _delay;
@synthesize _location;
@synthesize _prognosis;
@synthesize _station;
@synthesize _dateFormatter;


-(id)                   init: (StationDto *)newStation
                withLocation: (StationDto *)newLocation
               withPrognosis: (PrognosisDto *)newPrognosis
                   withDelay: (NSString *)newDelay
                 withArrival: (NSDate *)newArrival
               withDeparture: (NSDate *)newDeparture
                withPlatform: (NSString *)newPlatform
{
    self = [super init];
    _dateFormatter  = [[DateFormation alloc] init];
    if (self)
    {
        self._station           = newStation;
        self._location          = newLocation;
        self._prognosis         = newPrognosis;
        self._delay             = newDelay;
        self._platform          = newPlatform;
        self._arrival           = newArrival;
        self._departure         = newDeparture;
        self._platform          = newPlatform;
    }
    return self;
}


- (FromOrToDto *)getFromOrTo:(NSDictionary *)fromOrToDictionary
{
    StationDto        *_localStation = [[StationDto alloc]init:nil withScore:nil withName:nil withDistance:nil withCoordinate:nil];
    StationDto        *_localLocation = [[StationDto alloc]init:nil withScore:nil withName:nil withDistance:nil withCoordinate:nil];

    PrognosisDto      *_localPrognosis = [[PrognosisDto alloc]init:nil withArrival:nil withDeparture:nil withCapacity1st:nil withCapacity2nd:nil];
    
    NSString          *_localDelay;
    NSDate            *_localArrival;
    NSDate            *_localDeparture;
    NSString          *_localPlatform;
    
    FromOrToDto *_localFromOrTo = [[FromOrToDto alloc]init:nil withLocation:nil withPrognosis:nil withDelay:nil withArrival:nil withDeparture:nil withPlatform:nil];
    
    for (id fromOrToKey in fromOrToDictionary)
    {
        if ([fromOrToDictionary objectForKey:fromOrToKey] != [NSNull null])
        {
            
            if ([fromOrToKey isEqualToString:@"arrival"])
            {
                _localArrival =  [_dateFormatter parseDate:[fromOrToDictionary objectForKey:fromOrToKey]];
                //NSLog(@"StationDto _localStationId: %i", _localStationId);
            }
            
            if ([fromOrToKey isEqualToString:@"departure"])
            {
                
                _localDeparture = [_dateFormatter parseDate:[fromOrToDictionary objectForKey:fromOrToKey]];
                //NSLog(@"StationDto _localScore: %i", _localScore);
            }
            
            if ([fromOrToKey isEqualToString:@"delay"])
            {
                _localDelay = [fromOrToDictionary objectForKey:fromOrToKey];
                //NSLog(@"StationDto _localName: %@", _localName);
            }
            
            if ([fromOrToKey isEqualToString:@"platform"])
            {
                _localPlatform = [fromOrToDictionary objectForKey:fromOrToKey];
                //NSLog(@"StationDto _localDistance: %@", _localDistance);
            }
            
            if ([fromOrToKey isEqualToString:@"station"])
            {
                _localStation = [_localStation getStation:[fromOrToDictionary objectForKey:fromOrToKey]];
            }
            if ([fromOrToKey isEqualToString:@"location"])
            {
                _localLocation = [_localStation getStation:[fromOrToDictionary objectForKey:fromOrToKey]];
            }
            if ([fromOrToKey isEqualToString:@"prognosis"])
            {
                _localPrognosis = [_localPrognosis getPrognosis:[fromOrToDictionary objectForKey:fromOrToKey]];
            }
        }
    }
    
    
    _localFromOrTo = [_localFromOrTo init:_localStation
                             withLocation:_localLocation
                            withPrognosis:_localPrognosis
                                withDelay:_localDelay
                              withArrival:_localArrival
                            withDeparture:_localDeparture
                             withPlatform:_localPlatform];
    
    return _localFromOrTo;
}

@end
