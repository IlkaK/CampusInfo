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
@synthesize _fromTime;
@synthesize _toTime;
@synthesize _timeplanType;
@synthesize _dateFormatter;


-(id)   init : (NSString  *) newWeekdayType
 withFromTime: (NSDate *)newFromTime
   withToTime: (NSDate *)newToTime
withTimeplanType:(NSString *)newTimeplanType
{
    self = [super init];
    if (self)
    {
        self._weekdayType = newWeekdayType;
        self._fromTime    = newFromTime;
        self._toTime      = newToTime;
        self._timeplanType = newTimeplanType;
    }
    _dateFormatter  = [[DateFormation alloc] init];
    return self;
}


- (WeekdayDto *)getWeekday:(NSDictionary *)weekdayDictionary
           withWeekdayType:(NSString *)weekdayType
{
    WeekdayDto    *_localWeekday        = nil;
    NSDate        *_localFromTime       = nil;
    NSDate        *_localToTime         = nil;
    NSString      *_localFromTimeString = nil;
    NSString      *_localToTimeString   = nil;
    NSString      *_localTimeplanType   = nil;
    
    for (id weekdayKey in weekdayDictionary)
    {
        //NSLog(@"weekdayKey: %@", weekdayKey);
        if ([weekdayKey isEqualToString:@"from"])
        {
            _localFromTimeString = [weekdayDictionary objectForKey:weekdayKey];
            if (![_localFromTimeString isEqual:[NSNull null]])
            {
                //NSLog(@"%@ from: %@",weekdayType, _localFromTimeString);
                _localFromTime = [[_dateFormatter _timeFormatter]  dateFromString:_localFromTimeString];
            }
        }
        if ([weekdayKey isEqualToString:@"until"])
        {
            _localToTimeString = [weekdayDictionary objectForKey:weekdayKey];
            if (![_localToTimeString isEqual:[NSNull null]])
            {
                //NSLog(@"%@ until: %@", weekdayType, _localToTimeString);
                _localToTime = [[_dateFormatter _timeFormatter]  dateFromString:_localToTimeString];
            }
        }
        if ([weekdayKey isEqualToString:@"type"])
        {
            _localTimeplanType = [weekdayDictionary objectForKey:weekdayKey];
            //NSLog(@"%@ type: %@", weekdayType, _localTimeplanType);
        }
    }
    _localWeekday    = [[WeekdayDto alloc]init:weekdayType
                                  withFromTime:_localFromTime
                                    withToTime:_localToTime
                              withTimeplanType:_localTimeplanType];
    return _localWeekday;
}




@end