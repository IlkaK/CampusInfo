//
//  HolidayDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import "HolidayDto.h"

@implementation HolidayDto
@synthesize _holidayId;
@synthesize _name;
@synthesize _version;
@synthesize _startsAt;
@synthesize _endsAt;
@synthesize _dateFormatter;

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

- (HolidayDto *)getHoliday:(NSDictionary *)holidayDictionary
{
    _dateFormatter  = [[DateFormation alloc] init];
    int _localHolidayId;
    NSString *_localVersion;
    NSString *_localName;
    NSDate *_localStartsAt;
    NSDate *_localEndsAt;
    
    HolidayDto *_localHoliday = [[HolidayDto alloc]init:nil withName:nil withVersion:nil withStartsAt:nil withEndsAt:nil];
    
    for (id holidayKey in holidayDictionary)
    {
        if ([holidayKey isEqualToString:@"id"])
        {
            _localHolidayId = [holidayDictionary objectForKey:holidayKey];
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
