//
//  ScheduleEventDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleEventDto.h"


@implementation ScheduleEventDto


@synthesize _description, _startTime, _endTime, _name, _slots, _type, _scheduleEventRealizations;

-(id) init : (NSString       *) newDescription
           : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime
           : (NSString       *) newName   
           : (NSMutableArray *) newSlots
           : (NSString       *) newType
           : (NSMutableArray *) newScheduleEventRealizations

{
    self = [super init];
    if (self) {
        self._description               = newDescription;
        self._startTime                 = newStartTime;
        self._endTime                   = newEndTime;
        self._name                      = newName;
        self._slots                     = newSlots;
        self._type                      = newType;
        self._scheduleEventRealizations = newScheduleEventRealizations;
    }
    return self;
}


@end