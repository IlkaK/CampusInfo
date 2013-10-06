/*
 HolidayDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header HolidayDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds the holiday data in MensaOverviewDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives holiday id, name, version, start and end date to be initally set or a dictionary to browse the data itself. </li>
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

#import "HolidayDto.h"

@implementation HolidayDto
@synthesize _holidayId;
@synthesize _name;
@synthesize _version;
@synthesize _startsAt;
@synthesize _endsAt;
@synthesize _dateFormatter;

/*!
 @function init
 Initializes HolidayDto.
 @param newHolidayId
 @param newName
 @param newVersion
 @param newStartsAt
 @param newEndsAt
 */
-(id)                   init: (int) newHolidayId
                    withName: (NSString *)newName
                 withVersion: (NSString *)newVersion
                withStartsAt: (NSDate *)newStartsAt
                  withEndsAt: (NSDate *)newEndsAt
{
    self = [super init];
    if (self)
    {
        self._holidayId = newHolidayId;
        self._name = newName;
        self._version = newVersion;
        self._startsAt = newStartsAt;
        self._endsAt = newEndsAt;
    }
    _dateFormatter  = [[DateFormation alloc] init];
    return self;
}

/*!
 @function getHoliday
 Is called when a new HolidayDto instance should be created based on the dictionary information.
 @param holidayDictionary
 */
- (HolidayDto *)getHoliday:(NSDictionary *)holidayDictionary
{
    int _localHolidayId;
    NSString *_localVersion;
    NSString *_localName;
    NSDate *_localStartsAt;
    NSDate *_localEndsAt;
    
    HolidayDto *_localHoliday = [[HolidayDto alloc]init:0 withName:nil withVersion:nil withStartsAt:nil withEndsAt:nil];
    
    for (id holidayKey in holidayDictionary)
    {
        if ([holidayKey isEqualToString:@"id"])
        {
            _localHolidayId = [[holidayDictionary objectForKey:holidayKey] intValue];
            //NSLog(@"holiday id: %i", _localHolidayId);
        }
        if ([holidayKey isEqualToString:@"version"])
        {
            _localVersion = [holidayDictionary objectForKey:holidayKey];
            //NSLog(@"holiday version: %@", _localVersion);
        }
        if ([holidayKey isEqualToString:@"name"])
        {
            _localName = [holidayDictionary objectForKey:holidayKey];
            //NSLog(@"holiday name: %@", _localName);
        }
        if ([holidayKey isEqualToString:@"startsAt"])
        {
            _localStartsAt = [_dateFormatter parseDate:[holidayDictionary objectForKey:holidayKey]];
            //NSLog(@"holiday startsAt: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localStartsAt]);
        }
        if ([holidayKey isEqualToString:@"endsAt"])
        {
            _localEndsAt = [_dateFormatter parseDate:[holidayDictionary objectForKey:holidayKey]];
            //NSLog(@"holiday endsAt: %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localEndsAt]);
        }
    }
    _localHoliday = [[HolidayDto alloc]init:_localHolidayId withName:_localName withVersion:_localVersion withStartsAt:_localStartsAt withEndsAt:_localEndsAt];
    return _localHoliday;
}


@end
