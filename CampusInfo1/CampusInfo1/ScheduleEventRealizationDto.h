//
//  ScheduleEventRealizationDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 11.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class RoomDto;

@interface ScheduleEventRealizationDto : NSObject
{
    RoomDto        *_room;
    NSMutableArray *_lecturers;
    NSMutableArray *_schoolClasses;
}

@property (nonatomic, retain) RoomDto        *_room;
@property (nonatomic, retain)   NSMutableArray *_lecturers;
@property (nonatomic, retain)   NSMutableArray *_schoolClasses;


-(id) init : (RoomDto        *) newRoom
           : (NSMutableArray *) newLecturers
           : (NSMutableArray *) newSchoolClass;


@end
