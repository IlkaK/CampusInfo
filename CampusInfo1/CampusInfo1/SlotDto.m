//
//  SlotDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/30/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SlotDto.h"


@implementation SlotDto

@synthesize _startTime, _endTime;

-(id) init : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime

{
    self = [super init];
    if (self) {
        self._startTime   = newStartTime;
        self._endTime     = newEndTime;
    }
    return self;
}

-(void) dealloc {
    self._startTime   = nil;
    self._endTime     = nil;
    [super dealloc];
}

@end

