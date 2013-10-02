/*
 ScheduleEventRealizationDto.m
 ZHAW Engineering CampusInfo
 */

/*!
 * @header ScheduleEventRealizationDto.m
 * @author Ilka Kokemor
 * @copyright 2013 ZHAW
 * @discussion
 * <ul>
 * <li> Responsibilities:
 *   <ul>
 *      <li> Holds data for ScheduleEventRealization in TimeTableDto model. </li>
 *  </ul>
 * </li>
 *
 * <li> Receiving data:
 *   <ul>
 *      <li> It receives room, lecturers and schoolClasses to be initally set or a dictionary to browse the data itself. </li>
 *   </ul>
 * </li>
 *
 * <li> Sending data:
 *   <ul>
 *      <li> It returns itself when called. </li>
 *   </ul>
 * </li>
 *
 * </ul>
 */

#import "ScheduleEventRealizationDto.h"
#import "RoomDto.h"
#import "PersonDto.h"
#import "SchoolClassDto.h"

@implementation ScheduleEventRealizationDto

@synthesize _room, _lecturers, _schoolClasses;

/*!
 @function init
 Needs to be called initally, when instance of ScheduleEventRealizationDto is created.
 @param newRoom
 @param newLecturers
 @param newSchoolClass
 */
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

/*!
 @function getEventRealization
 Is called when a new ScheduleEventRealizationDto instance should be created based on the dictionary information.
 @param realizationDictionary
 */
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
