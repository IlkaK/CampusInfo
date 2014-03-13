/*
 FromOrToDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header FromOrToDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds from or to data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives station, location, prognosis, delay, arrival date/time, departure date/time and platform to be initally set or a dictionary to browse the data itself. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "FromOrToDto.h"

@implementation FromOrToDto
@synthesize _platform;
@synthesize _departureDate;
@synthesize _departureTime;
@synthesize _arrivalDate;
@synthesize _arrivalTime;
@synthesize _delay;
@synthesize _location;
@synthesize _prognosis;
@synthesize _station;
@synthesize _dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of FromOrToDto is created.
 @param newStation
 @param newLocation
 @param newPrognosis
 @param newDelay
 @param newArrivalDate
 @param newArrivalTime
 @param newDepartureDate
 @param newDepartureTime
 @param newPlatform
 */
-(id)                   init: (StationDto *)newStation
                withLocation: (StationDto *)newLocation
               withPrognosis: (PrognosisDto *)newPrognosis
                   withDelay: (NSString *)newDelay
             withArrivalDate: (NSDate *)newArrivalDate
             withArrivalTime: (NSDate *)newArrivalTime
           withDepartureDate: (NSDate *)newDepartureDate
           withDepartureTime: (NSDate *)newDepartureTime
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
        self._arrivalDate       = newArrivalDate;
        self._arrivalTime       = newArrivalTime;
        self._departureDate     = newDepartureDate;
        self._departureTime     = newDepartureTime;
        self._platform          = newPlatform;
    }
    return self;
}

/*!
 @function getFromOrTo
 Is called when a new FromOrToDto instance should be created based on the dictionary information.
 @param fromOrToDictionary
 */
- (FromOrToDto *)getFromOrTo:(NSDictionary *)fromOrToDictionary
{
    StationDto        *_localStation = [[StationDto alloc]init:nil withScore:0 withName:nil withDistance:nil withCoordinate:nil];
    StationDto        *_localLocation = [[StationDto alloc]init:nil withScore:0 withName:nil withDistance:nil withCoordinate:nil];
    PrognosisDto      *_localPrognosis = [[PrognosisDto alloc]init:nil withArrival:nil withDeparture:nil withCapacity1st:0 withCapacity2nd:0];
    
    NSString          *_localDelay;
    NSDate            *_localArrivalDate;
    NSDate            *_localDepartureDate;
    NSDate            *_localArrivalTime;
    NSDate            *_localDepartureTime;
    NSString          *_localPlatform;
    
    FromOrToDto *_localFromOrTo = [[FromOrToDto alloc]init:nil withLocation:nil withPrognosis:nil withDelay:nil withArrivalDate:nil withArrivalTime:nil withDepartureDate:nil withDepartureTime:nil withPlatform:nil];
    
    for (id fromOrToKey in fromOrToDictionary)
    {
        if ([fromOrToDictionary objectForKey:fromOrToKey] != [NSNull null])
        {
            if ([fromOrToKey isEqualToString:@"arrival"])
            {
                _localArrivalDate = [_dateFormatter parseDate:[fromOrToDictionary objectForKey:fromOrToKey]];
                _localArrivalTime = [_dateFormatter parseTime:[fromOrToDictionary objectForKey:fromOrToKey]];
                //NSLog(@"FromOrToDto _localArrivalTime: %@", [[_dateFormatter _timeFormatter] stringFromDate:_localArrivalTime]);
                
            }
            
            if ([fromOrToKey isEqualToString:@"departure"])
            {
                //NSLog(@"FromOrToDto departure: %@", [fromOrToDictionary objectForKey:fromOrToKey]);
                _localDepartureDate = [_dateFormatter parseDate:[fromOrToDictionary objectForKey:fromOrToKey]];
                _localDepartureTime = [_dateFormatter parseTime:[fromOrToDictionary objectForKey:fromOrToKey]];
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
                          withArrivalDate:_localArrivalDate
                          withArrivalTime:_localArrivalTime
                        withDepartureDate:_localDepartureDate
                        withDepartureTime:_localDepartureTime
                             withPlatform:_localPlatform];
    return _localFromOrTo;
}

@end
