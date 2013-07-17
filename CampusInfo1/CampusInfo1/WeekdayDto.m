//
//  WeekdayDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import "WeekdayDto.h"

@implementation WeekdayDto

@synthesize _weekdayType;
@synthesize _toTime;
@synthesize _fromTime;
@synthesize _dateFormatter;

-(id)   init : (NSString  *) newWeekdayType
 withFromTime: (NSDate *)newFromTime
   withToTime: (NSDate *)newToTime
{
    self = [super init];
    if (self)
    {
        self._weekdayType = newWeekdayType;
        self._toTime      = newToTime;
        self._fromTime    = newFromTime;
    }
    _dateFormatter  = [[DateFormation alloc] init]; 
    return self;
}

- (WeekdayDto *) getWeekdayWithDictionary:(NSDictionary *)dictionary
                                  withKey:(id) key
                          withWeekdayType:(NSString *)weekdayType
{
    WeekdayDto    *_localWeekday   = nil;
    NSDictionary  *_weekdayDictionary = [dictionary objectForKey:key];
    NSDate        *_localFromTime;
    NSDate        *_localToTime;
    _dateFormatter  = [[DateFormation alloc] init];
    
    if (_weekdayDictionary != (id)[NSNull null])
    {
        for (id weekdayKey in _weekdayDictionary)
        {
            if ([weekdayKey isEqualToString:@"from"])
            {
                _fromTime = [[_dateFormatter _timeFormatter]  dateFromString:[_weekdayDictionary objectForKey:weekdayKey]];
            }
            if ([weekdayKey isEqualToString:@"until"])
            {
                _toTime = [[_dateFormatter _timeFormatter]  dateFromString:[_weekdayDictionary objectForKey:weekdayKey]];
            }
        }
    }
    
    _localWeekday    = [[WeekdayDto alloc]init:weekdayType
                                  withFromTime:_localFromTime
                                    withToTime:_localToTime];
    return _localWeekday;
}


@end