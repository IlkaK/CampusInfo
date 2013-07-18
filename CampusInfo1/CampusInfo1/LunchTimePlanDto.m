//
//  LunchTimePlanDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import "LunchTimePlanDto.h"
#import "WeekdayDto.h"

@implementation LunchTimePlanDto
@synthesize _weekdays;
@synthesize _planType;

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

- (LunchTimePlanDto *)getLunchTimePlan:(NSDictionary *)lunchTimePlanDictionary
{
    NSString         *_localPlanType = nil;
    NSMutableArray   *_localWeekdayArray = [[NSMutableArray alloc]init];;
    WeekdayDto       *_localWeekday = [[WeekdayDto alloc]init:nil withFromTime:nil withToTime:nil withTimeplanType:nil];
    LunchTimePlanDto *_localLunchTimePlanDto = [[LunchTimePlanDto alloc]init:nil withPlanType:nil];
    
    for (id lunchTimePlanKey in lunchTimePlanDictionary)
    {
        if ([lunchTimePlanKey isEqualToString:@"type"])
        {
            _localPlanType = [lunchTimePlanDictionary objectForKey:lunchTimePlanKey];
            NSLog(@"lunch time plan type: %@", _localPlanType);
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