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
    return self;
}

@end
