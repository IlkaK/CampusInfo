/*
 OpeningTimePlanDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header OpeningTimePlanDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the opening time plan data in MensaOverviewDto model. </li>
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

#import "OpeningTimePlanDto.h"
#import "WeekdayDto.h"

@implementation OpeningTimePlanDto
@synthesize _weekdays;
@synthesize _planType;

/*!
 @function init
 Initializes OpeningTimePlanDto.
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
 @function getOpeningTimePlan
 Is called when a new OpeningTimePlanDto instance should be created based on the dictionary information.
 @param openingTimePlanDictionary
 */
- (OpeningTimePlanDto *)getOpeningTimePlan:(NSDictionary *)openingTimePlanDictionary
{
    NSString         *_localPlanType = nil;
    NSMutableArray   *_localWeekdayArray = [[NSMutableArray alloc]init];;
    WeekdayDto       *_localWeekday = [[WeekdayDto alloc]init:nil withFromTime:nil withToTime:nil withTimeplanType:nil];
    OpeningTimePlanDto *_localOpeningTimePlanDto = [[OpeningTimePlanDto alloc]init:nil withPlanType:nil];
    
    for (id openingTimePlanKey in openingTimePlanDictionary)
    {
        if ([openingTimePlanKey isEqualToString:@"type"])
        {
            _localPlanType = [openingTimePlanDictionary objectForKey:openingTimePlanKey];
            //NSLog(@"opening time plan type: %@", _localPlanType);
        }
        
        if (
            [openingTimePlanKey isEqualToString:@"monday"]
            ||  [openingTimePlanKey isEqualToString:@"tuesday"]
            ||  [openingTimePlanKey isEqualToString:@"wednesday"]
            ||  [openingTimePlanKey isEqualToString:@"thursday"]
            ||  [openingTimePlanKey isEqualToString:@"friday"]
            ||  [openingTimePlanKey isEqualToString:@"saturday"]
            ||  [openingTimePlanKey isEqualToString:@"sunday"]
            )
        {
            _localWeekday = [_localWeekday getWeekday:[openingTimePlanDictionary objectForKey:openingTimePlanKey] withWeekdayType:openingTimePlanKey];
            
            [_localWeekdayArray addObject:_localWeekday];
        }
    }
    _localOpeningTimePlanDto = [[OpeningTimePlanDto alloc]init:_localWeekdayArray withPlanType:_localPlanType];
    return _localOpeningTimePlanDto;
}

@end