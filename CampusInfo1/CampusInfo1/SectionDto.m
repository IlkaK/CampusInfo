//
//  SectionDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.09.13.
//
//

#import "SectionDto.h"


@implementation SectionDto
@synthesize _arrival;
@synthesize _departure;
@synthesize _journey;
@synthesize _walk;

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


- (SectionDto *)getSection:(NSDictionary *)sectionDictionary
{
    SectionDto *_localSection = [[SectionDto alloc]init:nil withWalk:nil withDeparture:nil withArrival:nil];
    JourneyDto      *_localJourney = [[JourneyDto alloc]init:nil withCategory:nil withCategoryCode:nil withJourneyNumber:nil withOperator:nil withTo:nil withPassList:nil withCapacity1st:nil withCapacity2nd:nil];
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
