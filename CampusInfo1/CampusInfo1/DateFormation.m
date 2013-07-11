//
//  DateFormation.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 10.07.13.
//
//

#import "DateFormation.h"

@implementation DateFormation

@synthesize _dayFormatter;
@synthesize _timeFormatter;
@synthesize _weekDayFormatter;
@synthesize _englishTimeAndDayFormatter;
@synthesize _englishDayFormatter;

-(id) init 
{
    self = [super init];
    if (self)
    {
        _dayFormatter       = [[NSDateFormatter alloc]init];
        [_dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
        [_dayFormatter setDateFormat:@"dd.MM.yyyy"];
        
        _weekDayFormatter   = [[NSDateFormatter alloc]init];
        [_weekDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [_weekDayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
        [_weekDayFormatter setDateFormat:@"EEEE"];
        
        _timeFormatter      = [[NSDateFormatter alloc]init];
        [_timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
        [_timeFormatter setDateFormat:@"HH:mm"];
        [_timeFormatter setDefaultDate:[NSDate date]];
        
        
        _englishDayFormatter = [[NSDateFormatter alloc]init];
        [_englishDayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
        [_englishDayFormatter setDateFormat:@"yyyy-MM-dd"];
        
        _englishTimeAndDayFormatter = [[NSDateFormatter alloc]init];
        [_englishTimeAndDayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
        [_englishTimeAndDayFormatter setDateFormat:@"yyyy-MM-dd HH:mm"]; 
    }
    return self;
}

@end
