/*
 DateFormation.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header DateFormation.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Provides date formatter constants. </li>
 *      <li> Provides methods to format strings to dates. </li>
 *  </ul>
 * </li>
 * <li> Receiving data:
 *   <ul>
 *      <li> Receives strings to format into dates. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It sends back the formatted dates. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "DateFormation.h"

@implementation DateFormation

@synthesize _dayFormatter;
@synthesize _timeFormatter;
@synthesize _weekDayFormatter;
@synthesize _englishTimeAndDayFormatter;
@synthesize _englishDayFormatter;

/*!
 @function init
 Initialization of the date formatters.
 */
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

/*!
 @function parseDate
 Parses the given string into date.
 @param dateString
 */
- (NSDate *) parseDate:(NSString *)dateString
{
    NSDate   *_localDate;
    NSString *_localString;
    
    _localString = [dateString substringToIndex:10];
    //NSLog(@"_localString: %@",_localString);
    _localDate   = [[self _englishDayFormatter] dateFromString:_localString];
    //NSLog(@"_localDate: %@", [[self _englishDayFormatter] stringFromDate:_localDate]);
    return _localDate;
}

/*!
 @function parseTime
 Parses the given string into time.
 @param dateString
 */
- (NSDate *) parseTime:(NSString *)dateString
{
    NSDate   *_localTime;
    NSString *_localString = [dateString substringFromIndex:11];
    //NSLog(@"1 _localString: %@",_localString);
    
    _localString = [_localString substringToIndex:5];
    //NSLog(@"2 _localString: %@",_localString);
    _localTime   = [[self _timeFormatter] dateFromString:_localString];
    
    //NSLog(@"_localTime: %@", [[self _timeFormatter] stringFromDate:_localTime]);
    return _localTime;
}

/*!
 @function parseDateFromXMLString
 Parses the given xml string into date.
 @param dateString
 */
-(NSDate *) parseDateFromXMLString:(NSString *)dateString
{
    NSDate   *_localDate;

    //NSString *_weekDayString = [dateString substringToIndex:3];
    //NSLog(@"_weekDayString: %@",_weekDayString);
    
    NSString *_dayString = [dateString substringFromIndex:5];
    _dayString = [_dayString substringToIndex:11];
    //NSLog(@"_dayString: %@",_dayString);
    
    NSString *_day = [_dayString substringFromIndex:0];
    _day = [_day substringToIndex:2];
    //NSLog(@"_day: %@",_day);
    
    NSString *_month = [_dayString substringFromIndex:3];
    _month = [_month substringToIndex:3];
    //NSLog(@"_month: %@",_month);
    
    NSString *_monthNumber;
    
    if ([_month isEqualToString:@"Jan"]) { _monthNumber = @"01"; }
    if ([_month isEqualToString:@"Feb"]) { _monthNumber = @"02"; }
    if ([_month isEqualToString:@"Mar"]) { _monthNumber = @"03"; }
    if ([_month isEqualToString:@"Apr"]) { _monthNumber = @"04"; }
    if ([_month isEqualToString:@"May"]) { _monthNumber = @"05"; }
    if ([_month isEqualToString:@"Jun"]) { _monthNumber = @"06"; }
    if ([_month isEqualToString:@"Jul"]) { _monthNumber = @"07"; }
    if ([_month isEqualToString:@"Aug"]) { _monthNumber = @"08"; }
    if ([_month isEqualToString:@"Sep"]) { _monthNumber = @"09"; }
    if ([_month isEqualToString:@"Oct"]) { _monthNumber = @"10"; }
    if ([_month isEqualToString:@"Nov"]) { _monthNumber = @"11"; }
    if ([_month isEqualToString:@"Dec"]) { _monthNumber = @"12"; }
    
    
    NSString *_year = [_dayString substringFromIndex:7];
    _year = [_year substringToIndex:4];
    //NSLog(@"_year: %@",_year);
    
    NSString *_timeString = [dateString substringFromIndex:17];
    _timeString = [_timeString substringToIndex:5];
    //NSLog(@"_timeString: %@",_timeString);
    
    NSString *_allStrings = [NSString stringWithFormat:@"%@-%@-%@ %@",_year, _monthNumber, _day, _timeString];
    //NSString *_allStrings = [NSString stringWithFormat:@"%@-%@-%@ 07:00",_year, _monthNumber, _day];

    //NSLog(@"_allStrings: %@",_allStrings);
    
    _localDate   = [[self _englishTimeAndDayFormatter] dateFromString:_allStrings];
    //NSLog(@"_localDate: %@", [[self _englishTimeAndDayFormatter] stringFromDate:_localDate]);
    
    return _localDate;
}

@end
