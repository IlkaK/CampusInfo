//
//  WeekdayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 17.07.13.
//
//

#import <Foundation/Foundation.h>
#import <DateFormation.h>

@interface WeekdayDto : NSObject
{    
    NSString   *_weekdayType;
    NSDate     *_toTime;
    NSDate     *_fromTime;
    DateFormation  *_dateFormatter;    
}

@property (nonatomic, retain) NSString  *_weekdayType;
@property (nonatomic, retain) NSDate  *_toTime;
@property (nonatomic, retain) NSDate  *_fromTime;
@property (nonatomic, retain) DateFormation  *_dateFormatter;

-(id)   init : (NSString  *) newWeekdayType
 withFromTime: (NSDate *)newFromTime
   withToTime: (NSDate *)newToTime;

- (WeekdayDto *) getWeekdayWithDictionary:(NSDictionary *)dictionary
                                  withKey:(id) key
                          withWeekdayType:(NSString *)weekdayType;

@end