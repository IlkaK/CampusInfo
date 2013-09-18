//
//  WeekdayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import <Foundation/Foundation.h>
#import "DateFormation.h"

@interface WeekdayDto : NSObject
{    
    NSString        *_weekdayType;
    NSDate          *_fromTime;
    NSDate          *_toTime;
    NSString        *_timeplanType;
    DateFormation   *_dateFormatter;
}

@property (nonatomic, retain) NSString          *_weekdayType;
@property (nonatomic, retain) NSDate            *_fromTime;
@property (nonatomic, retain) NSDate            *_toTime;
@property (nonatomic, retain) NSString          *_timeplanType;
@property (nonatomic, retain) DateFormation     *_dateFormatter;


-(id)   init : (NSString  *) newWeekdayType
 withFromTime: (NSDate *)newFromTime
   withToTime: (NSDate *)newToTime
withTimeplanType: (NSString *)newTimeplanType;

- (WeekdayDto *)getWeekday:(NSDictionary *)weekdayDictionary
           withWeekdayType:(NSString *)weekdayType;

@end