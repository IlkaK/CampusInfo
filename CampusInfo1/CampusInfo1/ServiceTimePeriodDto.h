//
//  ServiceTimePeriodDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import <Foundation/Foundation.h>
#import <DateFormation.h>

@class LunchTimePlanDto;
@class OpeningTimePlanDto;

@interface ServiceTimePeriodDto : NSObject
{
    NSDate              *_startsOn;
    NSDate              *_endsOn;
    int                 _serviceTimePeriodId;
    LunchTimePlanDto    *_lunchTimePlan;
    OpeningTimePlanDto  *_openingTimePlan;
    DateFormation       *_dateFormatter;
}

@property (nonatomic, retain) NSDate                *_startsOn;
@property (nonatomic, retain) NSDate                *_endsOn;
@property (nonatomic, assign) int                   _serviceTimePeriodId;
@property (nonatomic, retain) LunchTimePlanDto      *_lunchTimePlan;
@property (nonatomic, retain) OpeningTimePlanDto    *_openingTimePlan;
@property (nonatomic, retain) DateFormation         *_dateFormatter;

-(id)                  init: (NSDate *) newStartsOn
                 withEndsOn: (NSDate *) newEndsOn
    withServiceTimePeriodId: (int) newServiceTimePeriodId
          withLunchTimePlan: (LunchTimePlanDto *)newLunchTimePlan
        withOpeningTimePlan: (OpeningTimePlanDto *)newOpeningTimePlan;

- (ServiceTimePeriodDto *)getServiceTimePeriod:(NSDictionary *)serviceTimePeriodDictionary;

@end