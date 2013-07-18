//
//  OpeningTimePlanDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import "OpeningTimePlanDto.h"
#import "WeekdayDto.h"

@implementation OpeningTimePlanDto
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
            NSLog(@"opening time plan type: %@", _localPlanType);
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