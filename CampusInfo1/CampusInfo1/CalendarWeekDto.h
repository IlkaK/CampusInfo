//
//  CalendarWeekDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 23.07.13.
//
//

#import <Foundation/Foundation.h>

@interface CalendarWeekDto : NSObject
{
    int _week;
    int _year;
}

@property (nonatomic, assign) int _week;
@property (nonatomic, assign) int _year;


-(id)   init : (int) newWeek
     withYear: (int) newYear;

- (CalendarWeekDto *)getCalendarWeek:(NSDictionary *)calendarWeekDictionary;

@end