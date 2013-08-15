//
//  DateFormation.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 10.07.13.
//
//

#import <Foundation/Foundation.h>

@interface DateFormation : NSObject
{
    NSDateFormatter *_dayFormatter;
    NSDateFormatter *_englishDayFormatter;
    NSDateFormatter *_weekDayFormatter;
    NSDateFormatter *_timeFormatter;
    NSDateFormatter *_englishTimeAndDayFormatter;
}

@property (nonatomic, retain) NSDateFormatter *_dayFormatter;
@property (nonatomic, retain) NSDateFormatter *_weekDayFormatter;
@property (nonatomic, retain) NSDateFormatter *_timeFormatter;
@property (nonatomic, retain) NSDateFormatter *_englishDayFormatter;
@property (nonatomic, retain) NSDateFormatter *_englishTimeAndDayFormatter;

- (id) init;

- (NSDate *) parseDate:(NSString *)dateString;
- (NSDate *) parseDateFromXMLString:(NSString *)dateString;

@end
