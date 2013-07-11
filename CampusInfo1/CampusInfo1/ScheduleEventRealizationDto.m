//
//  ScheduleEventRealizationDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 11.05.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleEventRealizationDto.h"
#import "RoomDto.h"
#import "PersonDto.h"
#import "SchoolClassDto.h"

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


- (ScheduleEventRealizationDto *) getEventRealization:(NSDictionary *)realizationDictionary
{
    ScheduleEventRealizationDto *_localRealization      = nil;
    RoomDto                     *_realizationRoom       = [[RoomDto alloc] init:nil];
    NSMutableArray              *_lecturerArrayToStore  = [[NSMutableArray alloc]init];
    NSMutableArray              *_classesArrayToStore   = [[NSMutableArray alloc]init];
    
    for (id realizationKey in realizationDictionary)
    {
        // get room of event realization
        if ([realizationKey isEqualToString:@"room"])
        {
            if ([realizationDictionary objectForKey:realizationKey] != (id)[NSNull null])
            {
                _realizationRoom = [_realizationRoom getRoomWithDictionary:realizationDictionary withScheduleKey:realizationKey];
                //NSLog(@"_realizationRoom._name: %@",_realizationRoom._name);
            }
        }
        
        if ([realizationKey isEqualToString:@"lecturers"])
        {
            NSArray  *_lecturersArray = [realizationDictionary objectForKey:realizationKey];
            
            //NSLog(@"_lecturersArray count: %i",[_lecturersArray count]);
            
            int lecturerArrayI;
            PersonDto *_lectuerPerson = [[PersonDto alloc]init:nil:nil:nil: nil :nil];
            for (lecturerArrayI = 0; lecturerArrayI < [_lecturersArray count]; lecturerArrayI++)
            {
                NSDictionary *_personDictionary = [_lecturersArray objectAtIndex:lecturerArrayI];
                
                
                //for (id personKey in _personDictionary)
                //{
                //    NSLog(@"personKey: %@ value of key: %@", personKey, [_personDictionary objectForKey:personKey]);
                //}
                
                _lectuerPerson = [_lectuerPerson getPersonWithDictionary:_personDictionary withKey:nil];
                //NSLog(@"_lectuerPerson._shortName: %@",_lectuerPerson._shortName);
                [_lecturerArrayToStore addObject:_lectuerPerson];
            }
        }
        if ([realizationKey isEqualToString:@"classes"])
        {
            NSArray  *_classesArray = [realizationDictionary objectForKey:realizationKey];
            int classesArrayI;
            SchoolClassDto *_realizationClass = [[SchoolClassDto alloc] init:nil];
            
            for (classesArrayI = 0; classesArrayI < [_classesArray count]; classesArrayI++)
            {
                NSDictionary *_classDictionary = [_classesArray objectAtIndex:classesArrayI];
                
                _realizationClass = [_realizationClass getClassWithDictionary:_classDictionary withKey:nil];
                
                //NSLog(@"_realizationClass._name: %@",_realizationClass._name);
                [_classesArrayToStore addObject:_realizationClass];
            }
        }
    }
    _localRealization    = [[ScheduleEventRealizationDto alloc]init:_realizationRoom:_lecturerArrayToStore:_classesArrayToStore];
    return _localRealization;
}



@end
