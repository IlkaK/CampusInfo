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
        NSTimeZone *_timeZone = [NSTimeZone timeZoneWithName:@"CEST"];
        
        _dayFormatter       = [[NSDateFormatter alloc]init];
        [_dayFormatter setTimeZone:_timeZone];
        [_dayFormatter setDateFormat:@"dd.MM.yyyy"];
        
        _weekDayFormatter   = [[NSDateFormatter alloc]init];
        [_weekDayFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
        [_weekDayFormatter setTimeZone:_timeZone];
        [_weekDayFormatter setDateFormat:@"EEEE"];
        
        _timeFormatter      = [[NSDateFormatter alloc]init];
        [_timeFormatter setTimeZone:_timeZone];
        [_timeFormatter setDateFormat:@"HH:mm"];
        [_timeFormatter setDefaultDate:[NSDate date]];
        
        
        _englishDayFormatter = [[NSDateFormatter alloc]init];
        [_englishDayFormatter setTimeZone:_timeZone];
        [_englishDayFormatter setDateFormat:@"yyyy-MM-dd"];
        
        _englishTimeAndDayFormatter = [[NSDateFormatter alloc]init];
        [_englishTimeAndDayFormatter setTimeZone:_timeZone];
        [_englishTimeAndDayFormatter setDateFormat:@"yyyy-MM-dd HH:mm"]; 
    }
    return self;
}

- (NSDate *) parseDate:(NSString *)dateString
{
    NSDate   *_localDate;
    NSString *_localString;
    
    _localString = [dateString substringToIndex:10];
    //NSLog(@"_localString: %@",_localString);
    _localDate   = [[self _englishDayFormatter] dateFromString:_localString];
    //NSLog(@"_localDate: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localDate]);
    return _localDate;
}

@end
