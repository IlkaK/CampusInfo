/*
 CalendarWeekDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header CalendarWeekDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the calendar week data in MensaMenuDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives week and year to be initally set or a dictionary to browse the data itself. </li>
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

#import "CalendarWeekDto.h"

@implementation CalendarWeekDto

@synthesize _week;
@synthesize _year;

/*!
 @function init
 Initializes CalendarWeekDto.
 @param newWeek
 @param newYear
 */
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

/*!
 @function getCalendarWeek
 Is called when a new CalendarWeekDto instance should be created based on the dictionary information.
 @param calendarWeekDictionary
 */
- (CalendarWeekDto *)getCalendarWeek:(NSDictionary *)calendarWeekDictionary
{
    CalendarWeekDto *_localCalendarWeek = [[CalendarWeekDto alloc]init:0 withYear:0];
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
