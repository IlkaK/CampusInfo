//
//  DayDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DayDto.h"


@implementation DayDto
@synthesize _date, _events, _slots;

-(id) init : (NSDate         *) newDate
           : (NSMutableArray *) newEvents
           : (NSMutableArray *) newSlots
{
    self = [super init];
    if (self) {
        self._date   = newDate;
        self._events = newEvents;
        self._slots  = newSlots;
    }
    return self;
}

-(void) dealloc {
    self._date   = nil;
    self._events = nil;
    self._slots  = nil;
    [super dealloc];
}

@end

