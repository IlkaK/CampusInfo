//
//  ScheduleDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TimeTableAsyncRequest.h>

@class PersonDto;
@class RoomDto;
@class SchoolClassDto;
@class ScheduleCourseDto;


@interface ScheduleDto : NSObject <TimeTableAsyncRequestDelegate> {
    
    // data structure for schedule
    NSMutableArray        *_days;
    NSString              *_type;
    NSString              *_acronym;
    NSDate                *_scheduleDate;
    NSString              *_connectionEstablished;
    
    // schedule owner 
    PersonDto             *_student;
    PersonDto             *_lecturer;
    RoomDto               *_room;
    ScheduleCourseDto     *_scheduleCourse;
    SchoolClassDto        *_schoolClass;
    
    // gain timetable data from url
    TimeTableAsyncRequest *_asyncTimeTableRequest;
    
    // holding data gained from url
    NSData                *_dataFromUrl;
    

}

@property (nonatomic, retain) NSMutableArray                 *_days;
@property (nonatomic, retain) NSString                       *_type;
@property (nonatomic, retain) NSString                       *_acronym;
@property (nonatomic, retain) NSDate                         *_scheduleDate;
@property (nonatomic, retain) NSString                       *_connectionEstablished;


@property (nonatomic, retain) PersonDto                      *_student;
@property (nonatomic, retain) PersonDto                      *_lecturer;
@property (nonatomic, retain) RoomDto                        *_room;
@property (nonatomic, retain) ScheduleCourseDto              *_scheduleCourse;
@property (nonatomic, retain) SchoolClassDto                 *_schoolClass;


@property (nonatomic, retain) IBOutlet TimeTableAsyncRequest *_asyncTimeTableRequest;
@property (nonatomic, retain) NSData                         *_dataFromUrl;


-(id) initWithAcronym
   :(NSString *)newAcronymString
   :(NSString *)newAcronymType
   :(NSDate   *)newScheduleDate;

-(void):loadScheduleWithAcronym
    :(NSString *)newAcronymString
    :(NSString *)newAcronymType
    :(NSDate   *)newScheduleDate;


@end
