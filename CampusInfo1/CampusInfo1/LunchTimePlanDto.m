/*
 LunchTimePlanDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header LunchTimePlanDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the lunch time plan data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives an array of week days and plan type to be initally set or a dictionary to browse the data itself. </li>
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

#import "LunchTimePlanDto.h"
#import "WeekdayDto.h"

@implementation LunchTimePlanDto
@synthesize _weekdays;
@synthesize _planType;

/*!
 @function init
 Initializes LunchTimePlanDto.
 @param newWeekdays
 @param newPlanType
 */
-(id)           init: (NSMutableArray  *) newWeekdays
        withPlanType: (NSString *)newPlanType
{
    self = [super init];
    if (self)
    {
        self._weekdays = newWeekdays;
        self._planType = newPlanType;
    }
    return self;
}

/*!
 @function getLunchTimePlan
 Is called when a new LunchTimePlanDto instance should be created based on the dictionary information.
 @param lunchTimePlanDictionary
 */
- (LunchTimePlanDto *)getLunchTimePlan:(NSDictionary *)lunchTimePlanDictionary
{
    //NSLog(@"start getLunchTimePlan");
    NSString         *_localPlanType = nil;
    NSMutableArray   *_localWeekdayArray = [[NSMutableArray alloc]init];
    WeekdayDto       *_localWeekday = [[WeekdayDto alloc]init:nil withFromTime:nil withToTime:nil withTimeplanType:nil];
    LunchTimePlanDto *_localLunchTimePlanDto = [[LunchTimePlanDto alloc]init:nil withPlanType:nil];
    
    
    for (id lunchTimePlanKey in lunchTimePlanDictionary)
    {
        //NSLog(@"lunchTimePlanKey: %@", lunchTimePlanKey);
        
        if ([lunchTimePlanKey isEqualToString:@"type"])
        {
            _localPlanType = [lunchTimePlanDictionary objectForKey:lunchTimePlanKey];
            //NSLog(@"lunch time plan type: %@", _localPlanType);
        }
    
        if (
                [lunchTimePlanKey isEqualToString:@"monday"]
            ||  [lunchTimePlanKey isEqualToString:@"tuesday"]
            ||  [lunchTimePlanKey isEqualToString:@"wednesday"]
            ||  [lunchTimePlanKey isEqualToString:@"thursday"]
            ||  [lunchTimePlanKey isEqualToString:@"friday"]
            ||  [lunchTimePlanKey isEqualToString:@"saturday"]
            ||  [lunchTimePlanKey isEqualToString:@"sunday"]
            )
        {
            _localWeekday = [_localWeekday getWeekday:[lunchTimePlanDictionary objectForKey:lunchTimePlanKey] withWeekdayType:lunchTimePlanKey];
            
            [_localWeekdayArray addObject:_localWeekday];
        }
    }
    _localLunchTimePlanDto = [[LunchTimePlanDto alloc]init:_localWeekdayArray withPlanType:_localPlanType];
    return _localLunchTimePlanDto;
}


@end