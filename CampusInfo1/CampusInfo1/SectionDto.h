//
//  SectionDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 02.09.13.
//
//

#import <Foundation/Foundation.h>
#import <JourneyDto.h>
#import <FromOrToDto.h>

@interface SectionDto : NSObject
{
    JourneyDto      *_journey;
    NSString        *_walk;
    FromOrToDto     *_departure;
    FromOrToDto     *_arrival;
}

@property (nonatomic, retain) JourneyDto        *_journey;
@property (nonatomic, retain) NSString          *_walk;
@property (nonatomic, retain) FromOrToDto       *_departure;
@property (nonatomic, retain) FromOrToDto       *_arrival;

-(id)                     init:(JourneyDto *)newJourney
                      withWalk:(NSString *)newWalk
                 withDeparture:(FromOrToDto *)newDeparture
                   withArrival:(FromOrToDto *)newArrival;


- (SectionDto *)getSection:(NSDictionary *)sectionDictionary;

@end
