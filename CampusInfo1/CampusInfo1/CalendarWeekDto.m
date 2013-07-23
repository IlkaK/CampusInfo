//
//  CalendarWeekDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import "CalendarWeekDto.h"

@implementation CalendarWeekDto

@synthesize _week;
@synthesize _year;

-(id)   init : (int) newWeek
     withYear: (int) newYear
{
    self = [super init];
    if (self)
    {
        self._week   = newWeek;
        self._year   = newYear;
    }
    return self;
}

- (CalendarWeekDto *)getCalendarWeek:(NSDictionary *)calendarWeekDictionary
{
    CalendarWeekDto *_localCalendarWeek = [[CalendarWeekDto alloc]init:nil withYear:nil];
    int _localCalendarWeekWeek;
    int _localCalendarWeekYear;
    
    for (id calendarWeekKey in calendarWeekDictionary)
    {
        if ([calendarWeekKey isEqualToString:@"week"])
        {
            _localCalendarWeekWeek = [[calendarWeekDictionary objectForKey:calendarWeekKey] intValue];
            //NSLog(@"_localCalendarWeekWeek: %i", _localCalendarWeekWeek);
        }
        if ([calendarWeekKey isEqualToString:@"year"])
        {
            _localCalendarWeekYear = [[calendarWeekDictionary objectForKey:calendarWeekKey] intValue];
            //NSLog(@"_localCalendarWeekYear: %i", _localCalendarWeekYear);
        }
    }
    _localCalendarWeek = [_localCalendarWeek init:_localCalendarWeekWeek withYear:_localCalendarWeekYear];
    return _localCalendarWeek;
}




@end
