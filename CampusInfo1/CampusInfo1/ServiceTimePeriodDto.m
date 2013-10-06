/*
 ServiceTimePeriodDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ServiceTimePeriodDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the service time period data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives the start and end date, id, lunch time and opening time plan to be initally set or a dictionary to browse the data itself. </li>
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

/*!
 @function init
 Initializes ServiceTimePeriodDto.
 @param newStartsOn
 @param newEndsOn
 @param newServiceTimePeriodId
 @param newLunchTimePlan
 @param newOpeningTimePlan
 */
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

/*!
 @function getServiceTimePeriod
 Is called when a new ServiceTimePeriodDto instance should be created based on the dictionary information.
 @param serviceTimePeriodDictionary
 */
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

