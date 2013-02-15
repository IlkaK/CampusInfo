//
//  ScheduleEventRealizationDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 11.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleEventRealizationDto.h"
#import "RoomDto.h"

@implementation ScheduleEventRealizationDto

@synthesize _room, _lecturers, _schoolClasses;


-(id) init : (RoomDto        *) newRoom
           : (NSMutableArray *) newLecturers
           : (NSMutableArray *) newSchoolClass;

{
    self = [super init];
    if (self) {
        self._room          = newRoom;
        self._lecturers     = newLecturers;
        self._schoolClasses = newSchoolClass;
    }
    return self;
}


-(void) dealloc {
    self._room          = nil; 
    self._lecturers     = nil;
    self._schoolClasses = nil;
    [super dealloc];
}


@end
