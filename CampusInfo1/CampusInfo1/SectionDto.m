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
@synthesize _walk;

/*!
 @function init
 Needs to be called initally, when instance of SectionDto is created.
 @param newJourney
 @param newWalk
 @param newDeparture
 @param newArrival
 */
-(id)                     init:(JourneyDto *)newJourney
                      withWalk:(NSString *)newWalk
                 withDeparture:(FromOrToDto *)newDeparture
                   withArrival:(FromOrToDto *)newArrival
{
    self = [super init];
    if (self)
    {
        self._journey           = newJourney;
        self._walk              = newWalk;
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
    SectionDto *_localSection = [[SectionDto alloc]init:nil withWalk:nil withDeparture:nil withArrival:nil];
    JourneyDto      *_localJourney = [[JourneyDto alloc]init:nil withCategory:nil withCategoryCode:0 withJourneyNumber:0 withOperator:nil withTo:nil withPassList:nil withCapacity1st:0 withCapacity2nd:0];
    NSString        *_localWalk;
    
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
                //NSLog(@"StationDto _localStationId: %i", _localStationId);
            }
            
            if ([sectionKey isEqualToString:@"walk"])
            {
                _localWalk = [sectionDictionary objectForKey:sectionKey];
                //NSLog(@"StationDto _localScore: %i", _localScore);
            }
            
            if ([sectionKey isEqualToString:@"departure"])
            {
                _localDeparture = [_localDeparture getFromOrTo:[sectionDictionary objectForKey:sectionKey]];
                //NSLog(@"StationDto _localName: %@", _localName);
            }
            
            if ([sectionKey isEqualToString:@"arrival"])
            {
                _localArrival = [_localArrival getFromOrTo:[sectionDictionary objectForKey:sectionKey]];
                //NSLog(@"StationDto _localDistance: %@", _localDistance);
            }
        }
    }
    _localSection = [_localSection init:_localJourney
                               withWalk:_localWalk
                          withDeparture:_localDeparture
                            withArrival:_localArrival];
    return _localSection;
}

@end
