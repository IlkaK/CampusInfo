//
//  ScheduleEventDto.h
//  CampusInfo1
//
//  Created by Ilka Kokemor on 07.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleEventDto : NSObject
{    
    NSString       *_description;
    NSDate         *_startTime;
    NSDate         *_endTime;
    NSString       *_name;
    NSMutableArray *_slots;
    NSString       *_type;
    NSMutableArray *_scheduleEventRealizations;
}

@property (nonatomic, retain) NSString       *_description; 
@property (nonatomic, retain) NSDate         *_startTime;
@property (nonatomic, retain) NSDate         *_endTime;
@property (nonatomic, retain) NSString       *_name; 
@property (nonatomic, retain) NSMutableArray *_slots;
@property (nonatomic, retain) NSString       *_type; 
@property (nonatomic, retain) NSMutableArray *_scheduleEventRealizations;


-(id) init : (NSString       *) newDescription
           : (NSDate         *) newStartTime
           : (NSDate         *) newEndTime
           : (NSString       *) newName
           : (NSMutableArray *) newSlots
           : (NSString       *) newType
           : (NSMutableArray *) newScheduleEventRealizations;


@end
