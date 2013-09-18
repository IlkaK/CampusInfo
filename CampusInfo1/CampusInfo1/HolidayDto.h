//
//  HolidayDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 18.07.13.
//
//

#import <Foundation/Foundation.h>
#import "DateFormation.h"

@interface HolidayDto : NSObject
{
    int               _holidayId;
    NSString         *_name;
    NSString         *_version;
    NSDate           *_startsAt;
    NSDate           *_endsAt;
    DateFormation    *_dateFormatter;
}

@property (nonatomic, assign) int               _holidayId;
@property (nonatomic, retain) NSString          *_name;
@property (nonatomic, retain) NSString          *_version;
@property (nonatomic, retain) NSDate            *_startsAt;
@property (nonatomic, retain) NSDate            *_endsAt;
@property (nonatomic, retain) DateFormation     *_dateFormatter;


-(id)                   init: (int) newHolidayId
                    withName: (NSString *)newName
                 withVersion: (NSString *)newVersion
                withStartsAt: (NSDate *)newStartsAt
                  withEndsAt: (NSDate *)newEndsAt;

- (HolidayDto *)getHoliday:(NSDictionary *)holidayDictionary;

@end