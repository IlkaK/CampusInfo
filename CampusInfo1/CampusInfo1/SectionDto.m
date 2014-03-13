/*
 SectionDto.h
 ZHAW Engineering CampusInfo
 */

/*!
 * @header SectionDto.h
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds section data for PublicTransportConnectionDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives journey, walk, departure and arrival to be initally set or a dictionary to browse the data itself. </li>
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

#import "SectionDto.h"


@implementation SectionDto
@synthesize _arrival;
@synthesize _departure;
@synthesize _journey;
@synthesize _walkTime;
@synthesize _dateFormatter;

/*!
 @function init
 Needs to be called initally, when instance of SectionDto is created.
 @param newJourney
 @param newWalk
 @param newDeparture
 @param newArrival
 */
-(id)                     init:(JourneyDto *)newJourney
                      withWalkTime:(NSDate *)newWalkTime
                 withDeparture:(FromOrToDto *)newDeparture
                   withArrival:(FromOrToDto *)newArrival
{
    self = [super init];
    _dateFormatter  = [[DateFormation alloc] init];
    if (self)
    {
        self._journey           = newJourney;
        self._walkTime          = newWalkTime;
        self._departure         = newDeparture;
        self._arrival           = newArrival;
    }
    return self;
}

/*!
 @function getSection
 Is called when a new SectionDto instance should be created based on the dictionary information.
 @param sectionDictionary
 */
- (SectionDto *)getSection:(NSDictionary *)sectionDictionary
{
    SectionDto *_localSection = [[SectionDto alloc]init:nil withWalkTime:nil withDeparture:nil withArrival:nil];
    JourneyDto      *_localJourney = [[JourneyDto alloc]init:nil withCategory:nil withCategoryCode:0 withJourneyNumber:0 withOperator:nil withTo:nil withPassList:nil withCapacity1st:0 withCapacity2nd:0];
    NSDate          *_localWalkTime;
    
    FromOrToDto     *_localDeparture = [[FromOrToDto alloc]init:nil
                                                   withLocation:nil
                                                  withPrognosis:nil
                                                      withDelay:nil
                                                    withArrivalDate:nil
                                                withArrivalTime:nil
                                              withDepartureDate:nil
                                              withDepartureTime:nil
                                                   withPlatform:nil];
    
    FromOrToDto     *_localArrival = [[FromOrToDto alloc]init:nil
                                                 withLocation:nil
                                                withPrognosis:nil
                                                    withDelay:nil
                                              withArrivalDate:nil
                                              withArrivalTime:nil
                                            withDepartureDate:nil
                                            withDepartureTime:nil
                                                 withPlatform:nil];
    
    for (id sectionKey in sectionDictionary)
    {
        if ([sectionDictionary objectForKey:sectionKey] != [NSNull null])
        {
            if ([sectionKey isEqualToString:@"journey"])
            {
                _localJourney =  [_localJourney getJourney:[sectionDictionary objectForKey:sectionKey]];
                //NSLog(@"SectionDto _localStationId: %i", _localStationId);
            }
            
            if ([sectionKey isEqualToString:@"walk"])
            {
                NSDictionary *_walkDictionary = [sectionDictionary objectForKey:sectionKey];
                for (id walkKey in _walkDictionary)
                {
                    if ([_walkDictionary objectForKey:walkKey] != [NSNull null])
                    {
                        if ([walkKey isEqualToString:@"duration"])
                        {
                            _localWalkTime = [_dateFormatter parseMinutesAndSeconds:[_walkDictionary objectForKey:walkKey]];
                        }
                        //NSLog(@"SectionDto _localWalkTime: %@", [[_dateFormatter _minutesAndSecondsFormatter] stringFromDate:_localWalkTime]);
                    }
                }
            }
            
            if ([sectionKey isEqualToString:@"departure"])
            {
                _localDeparture = [_localDeparture getFromOrTo:[sectionDictionary objectForKey:sectionKey]];
                //NSLog(@"SectionDto _localName: %@", _localName);
            }
            
            if ([sectionKey isEqualToString:@"arrival"])
            {
                _localArrival = [_localArrival getFromOrTo:[sectionDictionary objectForKey:sectionKey]];
                
                //NSLog(@"arrival time of section %@", [[_dateFormatter _timeFormatter] stringFromDate:_localArrival._departureTime]);
                //NSLog(@"SectionDto _localDistance: %@", _localDistance);
            }
        }
    }
    _localSection = [_localSection init:_localJourney
                           withWalkTime:_localWalkTime
                          withDeparture:_localDeparture
                            withArrival:_localArrival];
    return _localSection;
}

@end
