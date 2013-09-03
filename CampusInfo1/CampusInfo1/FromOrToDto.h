//
//  FromOrToDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 31.08.13.
//
//

#import <Foundation/Foundation.h>
#import <StationDto.h>
#import <PrognosisDto.h>
#import <DateFormation.h>

@interface FromOrToDto : NSObject
{
    StationDto        *_station;
    StationDto        *_location;
    PrognosisDto      *_prognosis;
    NSString          *_delay;
    NSDate            *_arrivalDate;
    NSDate            *_arrivalTime;
    NSDate            *_departureDate;
    NSDate            *_departureTime;
    NSString          *_platform;
    
    DateFormation       *_dateFormatter;
}

@property (nonatomic, retain) DateFormation     *_dateFormatter;

@property (nonatomic, retain) StationDto        *_station;
@property (nonatomic, retain) StationDto        *_location;
@property (nonatomic, retain) PrognosisDto      *_prognosis;
@property (nonatomic, retain) NSString          *_delay;
@property (nonatomic, retain) NSDate            *_arrivalDate;
@property (nonatomic, retain) NSDate            *_arrivalTime;
@property (nonatomic, retain) NSDate            *_departureDate;
@property (nonatomic, retain) NSDate            *_departureTime;
@property (nonatomic, retain) NSString          *_platform;

-(id)                   init: (StationDto *)newStation
                withLocation: (StationDto *)newLocation
               withPrognosis: (PrognosisDto *)newPrognosis
                   withDelay: (NSString *)newDelay
             withArrivalDate: (NSDate *)newArrivalDate
             withArrivalTime: (NSDate *)newArrivalTime
           withDepartureDate: (NSDate *)newDepartureDate
           withDepartureTime: (NSDate *)newDepartureTime
                withPlatform: (NSString *)newPlatform;


- (FromOrToDto *)getFromOrTo:(NSDictionary *)fromOrToDictionary;

@end
