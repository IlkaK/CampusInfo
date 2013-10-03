/*
 PrognosisDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header PrognosisDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds prognosis data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives platform, arrival, departure and capacity ids to be initally set or a dictionary to browse the data itself. </li>
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

#import "PrognosisDto.h"

@implementation PrognosisDto
@synthesize _arrival;
@synthesize _capacity1st;
@synthesize _capacity2nd;
@synthesize _departure;
@synthesize _platform;
@synthesize _dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of PrognosisDto is created.
 @param newPlatform
 @param newArrival
 @param newDeparture
 @param newCapacity1st
 @param newCapacity2nd
 */
-(id)                   init: (NSString *)newPlatform
                 withArrival: (NSDate *)newArrival
               withDeparture: (NSDate *)newDeparture
             withCapacity1st: (int) newCapacity1st
             withCapacity2nd: (int) newCapacity2nd
{
    self = [super init];
    _dateFormatter  = [[DateFormation alloc] init];
    if (self)
    {
        self._platform          = newPlatform;
        self._arrival           = newArrival;
        self._departure         = newDeparture;
        self._capacity1st       = newCapacity1st;
        self._capacity2nd       = newCapacity2nd;
    }
    return self;
}

/*!
 @function getPrognosis
 Is called when a new PrognosisDto instance should be created based on the dictionary information.
 @param prognosisDictionary
 */
- (PrognosisDto *)getPrognosis:(NSDictionary *)prognosisDictionary
{
    NSString        *_localPlatform;
    NSDate          *_localArrival;
    NSDate          *_localDeparture;
    int               _localCapacity1st;
    int               _localCapacity2nd;

    PrognosisDto *_localPrognosis = [[PrognosisDto alloc]init:nil withArrival:nil withDeparture:nil withCapacity1st:0 withCapacity2nd:0];
    
    for (id prognosisKey in prognosisDictionary)
    {
        if ([prognosisDictionary objectForKey:prognosisKey] != [NSNull null])
        {
            
            if ([prognosisKey isEqualToString:@"capacity1st"])
            {
                _localCapacity1st = [[prognosisDictionary objectForKey:prognosisKey] intValue];
                //NSLog(@"StationDto _localStationId: %i", _localStationId);
            }
            
            if ([prognosisKey isEqualToString:@"capacity2nd"])
            {
                
                _localCapacity2nd = [[prognosisDictionary objectForKey:prognosisKey] intValue];
                //NSLog(@"StationDto _localScore: %i", _localScore);
            }
            
            if ([prognosisKey isEqualToString:@"platform"])
            {
                _localPlatform = [prognosisDictionary objectForKey:prognosisKey];
                //NSLog(@"StationDto _localName: %@", _localName);
            }
            
            if ([prognosisKey isEqualToString:@"arrival"])
            {
                _localArrival = [_dateFormatter parseDate:[prognosisDictionary objectForKey:prognosisKey]];
                //NSLog(@"StationDto _localDistance: %@", _localDistance);
            }
            
            if ([prognosisKey isEqualToString:@"departure"])
            {
                _localDeparture = [_dateFormatter parseDate:[prognosisDictionary objectForKey:prognosisKey]];
            }
        }
    }
    _localPrognosis = [_localPrognosis init:_localPlatform
                                withArrival:_localArrival
                              withDeparture:_localDeparture
                            withCapacity1st:_localCapacity1st
                            withCapacity2nd:_localCapacity2nd];
    return _localPrognosis;
}


@end
