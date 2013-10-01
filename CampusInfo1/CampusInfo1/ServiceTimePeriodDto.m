//
//  ServiceTimePeriodDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import "ServiceTimePeriodDto.h"
#import "LunchTimePlanDto.h"
#import "OpeningTimePlanDto.h"

@implementation ServiceTimePeriodDto

@synthesize _startsOn;
@synthesize _endsOn;
@synthesize _serviceTimePeriodId;
@synthesize _lunchTimePlan;
@synthesize _openingTimePlan;
@synthesize _dateFormatter;

-(id)                  init: (NSDate *) newStartsOn
                 withEndsOn: (NSDate *) newEndsOn
    withServiceTimePeriodId: (int) newServiceTimePeriodId
          withLunchTimePlan: (LunchTimePlanDto *)newLunchTimePlan
        withOpeningTimePlan: (OpeningTimePlanDto *)newOpeningTimePlan
{
    self = [super init];
    if (self)
    {
        self._startsOn = newStartsOn;
        self._endsOn = newEndsOn;
        self._serviceTimePeriodId = newServiceTimePeriodId;
        self._lunchTimePlan = newLunchTimePlan;
        self._openingTimePlan = newOpeningTimePlan;
    }
    _dateFormatter  = [[DateFormation alloc] init];
    return self;
}


- (ServiceTimePeriodDto *)getServiceTimePeriod:(NSDictionary *)serviceTimePeriodDictionary
{
    ServiceTimePeriodDto *_localServiceTimePeriod = [[ServiceTimePeriodDto alloc] init:nil withEndsOn:nil withServiceTimePeriodId:0 withLunchTimePlan:nil withOpeningTimePlan:nil];
    
    int _localServiceTimePeriodId;
    NSDate *_localStartsOn;
    NSDate *_localEndsOn;

    LunchTimePlanDto *_localLunchTimePlan = [[LunchTimePlanDto alloc] init:nil withPlanType:nil];
    OpeningTimePlanDto *_localOpeningTimePlan = [[OpeningTimePlanDto alloc] init:nil withPlanType:nil];
    
    for (id serviceTimePeriodKey in serviceTimePeriodDictionary)
    {
        //NSLog(@"serviceTimePeriodKey: %@", serviceTimePeriodKey);
        if ([serviceTimePeriodKey isEqualToString:@"id"])
        {
            _localServiceTimePeriodId = [[serviceTimePeriodDictionary objectForKey:serviceTimePeriodKey] intValue];
            //NSLog(@"service time period id: %i", _localServiceTimePeriodId);
        }
        if ([serviceTimePeriodKey isEqualToString:@"startsOn"])
        {
            _localStartsOn = [_dateFormatter parseDate:[serviceTimePeriodDictionary objectForKey:serviceTimePeriodKey]];
            //NSLog(@"service time period startsOn: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localStartsOn]);
        }
        if ([serviceTimePeriodKey isEqualToString:@"endsOn"])
        {
            _localEndsOn = [_dateFormatter parseDate:[serviceTimePeriodDictionary objectForKey:serviceTimePeriodKey]];
            //NSLog(@"service time period endsOn: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localEndsOn]);
        }
        if ([serviceTimePeriodKey isEqualToString:@"lunchTimePlan"])
        {
            //NSLog(@"---- start lunchTimePlan -----");
            if ( [serviceTimePeriodDictionary objectForKey:serviceTimePeriodKey] != [ NSNull null ] )
            {
                _localLunchTimePlan = [_localLunchTimePlan getLunchTimePlan:[serviceTimePeriodDictionary objectForKey:serviceTimePeriodKey]];
            }
            //NSLog(@"---- end lunchTimePlan -----");
        }
        if ([serviceTimePeriodKey isEqualToString:@"openingTimePlan"])
        {
            //NSLog(@"---- start openingTimePlan -----");
            _localOpeningTimePlan = [_localOpeningTimePlan getOpeningTimePlan:[serviceTimePeriodDictionary objectForKey:serviceTimePeriodKey]];
            //NSLog(@"---- end openingTimePlan -----");
        }
    }
    _localServiceTimePeriod =  [[ServiceTimePeriodDto alloc] init:_localStartsOn
                                                       withEndsOn:_localEndsOn
                                          withServiceTimePeriodId:_localServiceTimePeriodId
                                                withLunchTimePlan:_localLunchTimePlan
                                              withOpeningTimePlan:_localOpeningTimePlan];
    //NSLog(@"_localServiceTimePeriod from %@ to  %@"
    //      ,[[_dateFormatter _englishDayFormatter] stringFromDate:
    //        _localServiceTimePeriod._startsOn]
    //      ,[[_dateFormatter _englishDayFormatter] stringFromDate:
    //        _localServiceTimePeriod._endsOn]);
    return _localServiceTimePeriod;
}


@end

