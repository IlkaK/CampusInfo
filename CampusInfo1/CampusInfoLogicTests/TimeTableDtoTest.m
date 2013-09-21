//
//  TimeTableDtoTest.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 20.09.13.
//
//

#import "TimeTableDtoTest.h"
#import "DateFormation.h"
#import "ScheduleDto.h"
#import "DayDto.h"
#import "ScheduleEventDto.h"
#import "SlotDto.h"
#import "ScheduleEventRealizationDto.h"
#import "RoomDto.h"
#import "PersonDto.h"
#import "DepartmentDto.h"
#import "SchoolClassDto.h"
#import "TimeTableDtoTestConstants.h"
#import "UIConstantStrings.h"


@implementation TimeTableDtoTest

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    [super tearDown];
}


- (SchoolClassDto *)schoolClassDto1
{
    SchoolClassDto *_newClass = [[SchoolClassDto alloc]init:className1];
    STAssertEquals(_newClass._name, className1, @"class1 %@ = %@",_newClass._name, className1);
    return _newClass;
}

- (SchoolClassDto *)schoolClassDto2
{
    SchoolClassDto *_newClass = [[SchoolClassDto alloc]init:className2];
    STAssertEquals(_newClass._name, className2, @"class2 %@ = %@",_newClass._name, className2);
    return _newClass;
}

- (RoomDto *)roomDto1
{
    RoomDto *_newRoom = [[RoomDto alloc]init:roomName1];
    STAssertEquals(_newRoom._name, roomName1, @"room1 %@ = %@",_newRoom._name, roomName1);
    return _newRoom;
}

- (RoomDto *)roomDto2
{
    RoomDto *_newRoom = [[RoomDto alloc]init:roomName2];
    STAssertEquals(_newRoom._name, roomName2, @"room2 %@ = %@",_newRoom._name, roomName2);
    return _newRoom;
}

- (DepartmentDto *)departementDto1
{
    DepartmentDto *_newDepartment = [[DepartmentDto alloc]init:departementName1];
    STAssertEquals(_newDepartment._name, departementName1, @"department1 %@ = %@",_newDepartment._name, departementName1);
    return _newDepartment;
}

- (DepartmentDto *)departementDto2
{
    DepartmentDto *_newDepartment = [[DepartmentDto alloc]init:departementName2];
    STAssertEquals(_newDepartment._name, departementName2, @"department2 %@ = %@",_newDepartment._name, departementName2);
    return _newDepartment;
}

- (PersonDto *)personDto1:(DepartmentDto *)newDepartment
{
    PersonDto       *_newPerson = [[PersonDto alloc]init:lecturerAcronym1:lecturerPrename1:lecturerName1:TimeTableTypeLecturerEnglish:newDepartment];
    STAssertEquals(_newPerson._shortName, lecturerAcronym1, @"person1 acronym %@ = %@",_newPerson._shortName, lecturerAcronym1);
    STAssertEquals(_newPerson._firstName, lecturerPrename1, @"person1 first name %@ = %@",_newPerson._firstName, lecturerPrename1);
    STAssertEquals(_newPerson._lastName, lecturerName1, @"person1 last name %@ = %@",_newPerson._lastName, lecturerName1);
    STAssertEquals(_newPerson._department._name, departementName1, @"person1 department %@ = %@",_newPerson._department._name, departementName1);
    return _newPerson;
}

- (PersonDto *)personDto2:(DepartmentDto *)newDepartment
{
    PersonDto       *_newPerson = [[PersonDto alloc]init:lecturerAcronym2:lecturerPrename2:lecturerName2:TimeTableTypeLecturerEnglish:newDepartment];
    STAssertEquals(_newPerson._shortName, lecturerAcronym2, @"person2 acronym %@ = %@",_newPerson._shortName, lecturerAcronym2);
    STAssertEquals(_newPerson._firstName, lecturerPrename2, @"person2 first name %@ = %@",_newPerson._firstName, lecturerPrename2);
    STAssertEquals(_newPerson._lastName, lecturerName2, @"person2 last name %@ = %@",_newPerson._lastName, lecturerName2);
    STAssertEquals(_newPerson._department._name, departementName2, @"person1 department %@ = %@",_newPerson._department._name, departementName2);
    return _newPerson;
}

- (SlotDto *)slotDto1:(DateFormation *)dateFormater
{
    SlotDto *_newSlot    = [[SlotDto alloc]init:[[dateFormater _timeFormatter] dateFromString:startTime1 ]
                                                :[[dateFormater _timeFormatter] dateFromString:endTime1 ]];
    
    STAssertTrue([[[_newSlot._dateFormatter _timeFormatter] stringFromDate: _newSlot._startTime] isEqualToString:startTime1],[NSString stringWithFormat:@"slot1 start time %@ = %@",[[_newSlot._dateFormatter _timeFormatter] stringFromDate: _newSlot._startTime], startTime1 ]);

    STAssertTrue([[[_newSlot._dateFormatter _timeFormatter] stringFromDate: _newSlot._endTime] isEqualToString:endTime1],[NSString stringWithFormat:@"slot1 end time %@ = %@",[[_newSlot._dateFormatter _timeFormatter] stringFromDate: _newSlot._endTime], endTime1 ]);

    return _newSlot;
}

- (SlotDto *)slotDto2:(DateFormation *)dateFormater
{
    SlotDto *_newSlot    = [[SlotDto alloc]init:[[dateFormater _timeFormatter] dateFromString:startTime2 ]
    :[[dateFormater _timeFormatter] dateFromString:endTime2 ]];
    
    NSString *_startTime = [[_newSlot._dateFormatter _timeFormatter] stringFromDate: _newSlot._startTime];
    NSString *_endTime = [[_newSlot._dateFormatter _timeFormatter] stringFromDate: _newSlot._endTime];
    
    STAssertTrue([_startTime isEqualToString:startTime2],[NSString stringWithFormat:@"slot2 start time %@ = %@", _startTime, startTime2 ]);
    STAssertTrue([_endTime isEqualToString:endTime2],[NSString stringWithFormat:@"slot2 end time %@ = %@",_endTime, endTime2 ]);

    return _newSlot;
}


- (ScheduleEventRealizationDto *)eventRealization1WithLecturer:(PersonDto *)newLecturer
                                               withSchoolClass:(SchoolClassDto *)newSchoolClass
                                                      withRoom:(RoomDto *)newRoom
{
    NSMutableArray *_lecturerArray = [[NSMutableArray alloc]init];
    [_lecturerArray addObject:newLecturer];
    
    NSMutableArray *_schoolClassArray = [[NSMutableArray alloc]init];
    [_schoolClassArray addObject:newSchoolClass];
    
    ScheduleEventRealizationDto *_eventRealization = [[ScheduleEventRealizationDto alloc]init:newRoom
                                                                                             :_lecturerArray
                                                                                             :_schoolClassArray ];
    
    STAssertEquals(_eventRealization._room._name, roomName1, @"schedule event realization1 room %@ = %@",_eventRealization._room._name, roomName1);
    int cnt = [_eventRealization._lecturers count];
    STAssertEquals(cnt, 1, @"schedule event realization1 lecturer count %i = %i",cnt, 1);
    cnt = [_eventRealization._schoolClasses count];
    STAssertEquals(cnt, 1, @"schedule event realization1 classes count %i = %i",cnt, 1);
    
    PersonDto *_oneLocalPerson = [_eventRealization._lecturers objectAtIndex:0];
    SchoolClassDto *_oneLocalClass = [_eventRealization._schoolClasses objectAtIndex:0];
    
    STAssertEquals(_oneLocalPerson._shortName, lecturerAcronym1, @"schedule event realization1 lecturer %@ = %@",_oneLocalPerson._shortName, lecturerAcronym1);
    
    STAssertEquals(_oneLocalClass._name, className1, @"schedule event realization1 class %@ = %@",_oneLocalClass._name, className1);
    
    return _eventRealization;
}


- (ScheduleEventRealizationDto *)eventRealization2WithLecturer1:(PersonDto *)newLecturer1
                                                  withLecturer2:(PersonDto *)newLecturer2
                                               withSchoolClass1:(SchoolClassDto *)newSchoolClass1
                                               withSchoolClass2:(SchoolClassDto *)newSchoolClass2
                                                       withRoom:(RoomDto *)newRoom
{
    NSMutableArray *_lecturerArray = [[NSMutableArray alloc]init];
    [_lecturerArray addObject:newLecturer1];
    [_lecturerArray addObject:newLecturer2];
    
    NSMutableArray *_schoolClassArray = [[NSMutableArray alloc]init];
    [_schoolClassArray addObject:newSchoolClass1];
    [_schoolClassArray addObject:newSchoolClass2];
    
    ScheduleEventRealizationDto *_eventRealization = [[ScheduleEventRealizationDto alloc]init:newRoom
                                                                                             :_lecturerArray
                                                                                             :_schoolClassArray ];
    
    STAssertEquals(_eventRealization._room._name, roomName2, @"schedule event realization2 room %@ = %@",_eventRealization._room._name, roomName2);
    int cnt = [_eventRealization._lecturers count];
    STAssertEquals(cnt, 2, @"schedule event realization2 lecturer count %i = %i",cnt, 2);
    cnt = [_eventRealization._schoolClasses count];
    STAssertEquals(cnt, 2, @"schedule event realization2 classes count %i = %i",cnt, 2);
    
    return _eventRealization;
}


- (ScheduleEventRealizationDto *)eventRealization3WithLecturer1:(PersonDto *)newLecturer1
                                                  withLecturer2:(PersonDto *)newLecturer2
                                               withSchoolClass1:(SchoolClassDto *)newSchoolClass1
                                                       withRoom:(RoomDto *)newRoom
{
    NSMutableArray *_lecturerArray = [[NSMutableArray alloc]init];
    [_lecturerArray addObject:newLecturer1];
    [_lecturerArray addObject:newLecturer2];
    
    NSMutableArray *_schoolClassArray = [[NSMutableArray alloc]init];
    [_schoolClassArray addObject:newSchoolClass1];
    
    ScheduleEventRealizationDto *_eventRealization = [[ScheduleEventRealizationDto alloc]init:newRoom
                                                                                             :_lecturerArray
                                                                                             :_schoolClassArray ];
    
    STAssertEquals(_eventRealization._room._name, roomName3, @"schedule event realization3 room %@ = %@",_eventRealization._room._name, roomName3);
    int cnt = [_eventRealization._lecturers count];
    STAssertEquals(cnt, 2, @"schedule event realization3 lecturer count %i = %i",cnt, 2);
    cnt = [_eventRealization._schoolClasses count];
    STAssertEquals(cnt, 1, @"schedule event realization3 classes count %i = %i",cnt, 1);
    
    return _eventRealization;
}


- (ScheduleEventRealizationDto *)eventRealization4WithLecturer1:(PersonDto *)newLecturer1
                                               withSchoolClass1:(SchoolClassDto *)newSchoolClass1
                                               withSchoolClass2:(SchoolClassDto *)newSchoolClass2
                                                       withRoom:(RoomDto *)newRoom
{
    NSMutableArray *_lecturerArray = [[NSMutableArray alloc]init];
    [_lecturerArray addObject:newLecturer1];
    
    NSMutableArray *_schoolClassArray = [[NSMutableArray alloc]init];
    [_schoolClassArray addObject:newSchoolClass1];
    [_schoolClassArray addObject:newSchoolClass2];
    
    ScheduleEventRealizationDto *_eventRealization = [[ScheduleEventRealizationDto alloc]init:newRoom
                                                                                             :_lecturerArray
                                                                                             :_schoolClassArray ];
    
    STAssertTrue([_eventRealization._room._name isEqualToString:roomName4],  [NSString stringWithFormat:@"schedule event realization4 room %@ = %@",_eventRealization._room._name, roomName4]);
    
    int cnt = [_eventRealization._lecturers count];
    STAssertEquals(cnt, 1, @"schedule event realization4 lecturer count %i = %i",cnt, 1);
    cnt = [_eventRealization._schoolClasses count];
    STAssertEquals(cnt, 2, @"schedule event realization4 classes count %i = %i",cnt, 2);
    
    return _eventRealization;
}


- (ScheduleEventDto *)scheduleEvent1WithEventRealization:(ScheduleEventRealizationDto *)newEventRealization
                                                withSlot:(SlotDto *)newSlot
                                       withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot];
    
    NSMutableArray *_realizationArray = [[NSMutableArray alloc]init];
    [_realizationArray addObject:newEventRealization];
    
    ScheduleEventDto *_scheduleEvent = [[ScheduleEventDto alloc]init:lectureDescription1
                                                                    :[[dateFormatter _timeFormatter] dateFromString:startTime1 ]
                                                                    :[[dateFormatter _timeFormatter] dateFromString:endTime1 ]
                                                                    :lectureName1
                                                                    :_slotArray
                                                                    :TimeTableTypeLecturerEnglish
                                                                    :_realizationArray];

    STAssertEquals(_scheduleEvent._name, lectureName1, @"schedule event1 name %@ = %@",_scheduleEvent._name, lectureName1);
    int cnt = [_scheduleEvent._scheduleEventRealizations count];
    STAssertEquals(cnt, 1, @"schedule event1 realization count %i = %i",cnt, 1);
    cnt = [_scheduleEvent._slots count];
    STAssertEquals(cnt, 1, @"schedule event1 slots count %i = %i",cnt, 1);
    return _scheduleEvent;
}


- (ScheduleEventDto *)scheduleEvent2WithEventRealization1:(ScheduleEventRealizationDto *)newEventRealization1
                                    withEventRealization2:(ScheduleEventRealizationDto *)newEventRealization2
                                                withSlot1:(SlotDto *)newSlot1
                                                withSlot2:(SlotDto *)newSlot2
                                       withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot1];
    [_slotArray addObject:newSlot2];
    
    NSMutableArray *_realizationArray = [[NSMutableArray alloc]init];
    [_realizationArray addObject:newEventRealization1];
    [_realizationArray addObject:newEventRealization2];
    
    ScheduleEventDto *_scheduleEvent = [[ScheduleEventDto alloc]init:lectureDescription2
                                                                    :[[dateFormatter _timeFormatter] dateFromString:startTime2 ]
                                                                    :[[dateFormatter _timeFormatter] dateFromString:endTime3 ]
                                                                    :lectureName2
                                                                    :_slotArray
                                                                    :TimeTableTypeLecturerEnglish
                                                                    :_realizationArray];
    
    STAssertEquals(_scheduleEvent._name, lectureName2, @"schedule event2 name %@ = %@",_scheduleEvent._name, lectureName2);
    int cnt = [_scheduleEvent._scheduleEventRealizations count];
    STAssertEquals(cnt, 2, @"schedule event1 realization count %i = %i",cnt, 2);
    cnt = [_scheduleEvent._slots count];
    STAssertEquals(cnt, 2, @"schedule event2 slots count %i = %i",cnt, 2);
    
    return _scheduleEvent;
}


- (ScheduleEventDto *)scheduleEvent3WithEventRealization1:(ScheduleEventRealizationDto *)newEventRealization1
                                                withSlot1:(SlotDto *)newSlot1
                                                withSlot2:(SlotDto *)newSlot2
                                        withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot1];
    [_slotArray addObject:newSlot2];
    
    NSMutableArray *_realizationArray = [[NSMutableArray alloc]init];
    [_realizationArray addObject:newEventRealization1];
    
    ScheduleEventDto *_scheduleEvent = [[ScheduleEventDto alloc]init:lectureDescription3
                                                                    :[[dateFormatter _timeFormatter] dateFromString:startTime4 ]
                                                                    :[[dateFormatter _timeFormatter] dateFromString:endTime5 ]
                                                                    :lectureName3
                                                                    :_slotArray
                                                                    :TimeTableTypeLecturerEnglish
                                                                    :_realizationArray];
    
    STAssertEquals(_scheduleEvent._name, lectureName3, @"schedule event3 name %@ = %@",_scheduleEvent._name, lectureName3);
    int cnt = [_scheduleEvent._scheduleEventRealizations count];
    STAssertEquals(cnt, 1, @"schedule event1 realization count %i = %i",cnt, 1);
    cnt = [_scheduleEvent._slots count];
    STAssertEquals(cnt, 2, @"schedule event3 slots count %i = %i",cnt, 2);
    
    return _scheduleEvent;
}


- (ScheduleEventDto *)scheduleEvent4WithEventRealization1:(ScheduleEventRealizationDto *)newEventRealization1
                                    withEventRealization2:(ScheduleEventRealizationDto *)newEventRealization2
                                                withSlot1:(SlotDto *)newSlot1
                                        withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot1];
    
    NSMutableArray *_realizationArray = [[NSMutableArray alloc]init];
    [_realizationArray addObject:newEventRealization1];
    [_realizationArray addObject:newEventRealization2];
    
    ScheduleEventDto *_scheduleEvent = [[ScheduleEventDto alloc]init:lectureDescription4
                                                                    :[[dateFormatter _timeFormatter] dateFromString:startTime6 ]
                                                                    :[[dateFormatter _timeFormatter] dateFromString:endTime6 ]
                                                                    :lectureName4
                                                                    :_slotArray
                                                                    :TimeTableTypeLecturerEnglish
                                                                    :_realizationArray];
    
    STAssertEquals(_scheduleEvent._name, lectureName4, @"schedule event4 name %@ = %@",_scheduleEvent._name, lectureName4);
    
    int cnt = [_scheduleEvent._scheduleEventRealizations count];
    STAssertEquals(cnt, 2, @"schedule event4 realization count %i = %i",cnt, 2);
    cnt = [_scheduleEvent._slots count];
    STAssertEquals(cnt, 1, @"schedule event4 slots count %i = %i",cnt, 1);
    
    return _scheduleEvent;
}


- (DayDto *)dayDto1WithScheduleEvent1:(ScheduleEventDto *)newScheduleEvent1
                            withSlot1:(SlotDto *)newSlot1
                    withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_eventArray = [[NSMutableArray alloc]init];
    [_eventArray addObject:newScheduleEvent1];
    
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot1];
    
    
    DayDto *_day = [[DayDto alloc]init:[[dateFormatter _dayFormatter] dateFromString:day1 ]
                                    :_eventArray
                                    :_slotArray
                    ];
    int cnt = [_day._events count];
    STAssertEquals(cnt, 1, @"day1 events count %i = %i",cnt, 1);
    cnt = [_day._slots count];
    STAssertEquals(cnt, 1, @"day1 slots count %i = %i",cnt, 1);
    
    return _day;
}


- (DayDto *)dayDto2WithScheduleEvent1:(ScheduleEventDto *)newScheduleEvent1
                   withScheduleEvent2:(ScheduleEventDto *)newScheduleEvent2
                            withSlot1:(SlotDto *)newSlot1
                            withSlot2:(SlotDto *)newSlot2
                    withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_eventArray = [[NSMutableArray alloc]init];
    [_eventArray addObject:newScheduleEvent1];
    [_eventArray addObject:newScheduleEvent2];
    
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot1];
    [_slotArray addObject:newSlot2];
    
    DayDto *_day = [[DayDto alloc]init:[[dateFormatter _dayFormatter] dateFromString:day2 ]
                                      :_eventArray
                                      :_slotArray
                    ];
    int cnt = [_day._events count];
    STAssertEquals(cnt, 2, @"day2 events count %i = %i",cnt, 2);
    cnt = [_day._slots count];
    STAssertEquals(cnt, 2, @"day2 slots count %i = %i",cnt, 2);
    
    return _day;
}

- (DayDto *)dayDto3WithScheduleEvent1:(ScheduleEventDto *)newScheduleEvent1
                            withSlot1:(SlotDto *)newSlot1
                            withSlot2:(SlotDto *)newSlot2
                    withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_eventArray = [[NSMutableArray alloc]init];
    [_eventArray addObject:newScheduleEvent1];
    
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot1];
    [_slotArray addObject:newSlot2];
    
    DayDto *_day = [[DayDto alloc]init:[[dateFormatter _dayFormatter] dateFromString:day1 ]
                                      :_eventArray
                                      :_slotArray
                    ];
    int cnt = [_day._events count];
    STAssertEquals(cnt, 1, @"day3 events count %i = %i",cnt, 1);
    cnt = [_day._slots count];
    STAssertEquals(cnt, 2, @"day3 slots count %i = %i",cnt, 2);
    
    return _day;
}


- (DayDto *)dayDto4WithScheduleEvent1:(ScheduleEventDto *)newScheduleEvent1
                   withScheduleEvent2:(ScheduleEventDto *)newScheduleEvent2
                            withSlot1:(SlotDto *)newSlot1
                    withDateFormatter:(DateFormation *)dateFormatter
{
    NSMutableArray *_eventArray = [[NSMutableArray alloc]init];
    [_eventArray addObject:newScheduleEvent1];
    [_eventArray addObject:newScheduleEvent2];
    
    NSMutableArray *_slotArray = [[NSMutableArray alloc]init];
    [_slotArray addObject:newSlot1];
    
    DayDto *_day = [[DayDto alloc]init:[[dateFormatter _dayFormatter] dateFromString:day2 ]
                                      :_eventArray
                                      :_slotArray
                    ];
    
    int cnt = [_day._events count];
    STAssertEquals(cnt, 2, @"day2 events count %i = %i",cnt, 2);
    cnt = [_day._slots count];
    STAssertEquals(cnt, 1, @"day2 slots count %i = %i",cnt, 1);
    return _day;
}

- (void) testWithExampleData
{
    DateFormation *_dateFormater = [[DateFormation alloc]init];
    
    SchoolClassDto *_class1 = [self schoolClassDto1];
    SchoolClassDto *_class2 = [self schoolClassDto2];
    SchoolClassDto *_class3 = [[SchoolClassDto alloc]init:className3];
    SchoolClassDto *_class4 = [[SchoolClassDto alloc]init:className4];
    
    RoomDto *_room1 = [self roomDto1];
    RoomDto *_room2 = [self roomDto2];
    RoomDto *_room3 = [[RoomDto alloc]init:roomName3];
    RoomDto *_room4 = [[RoomDto alloc]init:roomName4];
    
    DepartmentDto   *_department1 = [self departementDto1];
    DepartmentDto   *_department2 = [self departementDto2];
    
    PersonDto *_person1 = [self personDto1:_department1];
    PersonDto *_person2 = [self personDto2:_department2];
    PersonDto *_person3 = [[PersonDto alloc]init:lecturerAcronym3:lecturerPrename3:lecturerName3:TimeTableTypeLecturerEnglish:_department1];
    PersonDto *_person4 = [[PersonDto alloc]init:lecturerAcronym4:lecturerPrename4:lecturerName3:TimeTableTypeLecturerEnglish:_department1];
    
    SlotDto *_slot1 = [self slotDto1:_dateFormater];
    SlotDto *_slot2 = [self slotDto2:_dateFormater];
    SlotDto *_slot3 = [[SlotDto alloc]init  :[[_dateFormater _timeFormatter] dateFromString:startTime3]
                                            :[[_dateFormater _timeFormatter] dateFromString:endTime3]];
    SlotDto *_slot4 = [[SlotDto alloc]init  :[[_dateFormater _timeFormatter] dateFromString:startTime4]
                                            :[[_dateFormater _timeFormatter] dateFromString:endTime4]];
    SlotDto *_slot5 = [[SlotDto alloc]init  :[[_dateFormater _timeFormatter] dateFromString:startTime5]
                                            :[[_dateFormater _timeFormatter] dateFromString:endTime5]];
    SlotDto *_slot6 = [[SlotDto alloc]init  :[[_dateFormater _timeFormatter] dateFromString:startTime6]
                                            :[[_dateFormater _timeFormatter] dateFromString:endTime6]];
    
    ScheduleEventRealizationDto *_eventRealization1 = [self eventRealization1WithLecturer:_person1
                                                                          withSchoolClass:_class1
                                                                                 withRoom:_room1];
    
    ScheduleEventRealizationDto *_eventRealization2 = [self eventRealization2WithLecturer1:_person2
                                                                             withLecturer2:_person3
                                                                          withSchoolClass1:_class2
                                                                          withSchoolClass2:_class3
                                                                                  withRoom:_room2];
    
    ScheduleEventRealizationDto *_eventRealization3 = [self eventRealization3WithLecturer1:_person3
                                                                             withLecturer2:_person4
                                                                          withSchoolClass1:_class4
                                                                                  withRoom:_room3];
    
    ScheduleEventRealizationDto *_eventRealization4 = [self eventRealization4WithLecturer1:_person4
                                                                          withSchoolClass1:_class1
                                                                          withSchoolClass2:_class2
                                                                                  withRoom:_room4];
    
    ScheduleEventDto *_scheduleEvent1 = [self scheduleEvent1WithEventRealization:_eventRealization1
                                                                        withSlot:_slot1
                                                               withDateFormatter:_dateFormater
                                         ];
                                         
                                         
    ScheduleEventDto *_scheduleEvent2 = [self scheduleEvent2WithEventRealization1:_eventRealization2
                                                            withEventRealization2:_eventRealization3
                                                                        withSlot1:_slot2
                                                                        withSlot2:_slot3
                                                                withDateFormatter:_dateFormater
                                         ];
    
    
    ScheduleEventDto *_scheduleEvent3 = [self scheduleEvent3WithEventRealization1:_eventRealization4
                                                                        withSlot1:_slot4
                                                                        withSlot2:_slot5
                                                                withDateFormatter:_dateFormater
                                         ];
    
    ScheduleEventDto *_scheduleEvent4 = [self scheduleEvent4WithEventRealization1:_eventRealization3
                                                            withEventRealization2:_eventRealization4
                                                                        withSlot1:_slot5
                                                                withDateFormatter:_dateFormater
                                         ];
    
    DayDto *_day1 = [self dayDto1WithScheduleEvent1:_scheduleEvent1
                                          withSlot1:_slot1
                                  withDateFormatter:_dateFormater];
    
    DayDto *_day2 = [self dayDto2WithScheduleEvent1:_scheduleEvent2
                                 withScheduleEvent2:_scheduleEvent3
                                          withSlot1:_slot2
                                          withSlot2:_slot3
                                  withDateFormatter:_dateFormater];
    
    DayDto *_day3 = [self dayDto3WithScheduleEvent1:_scheduleEvent4
                                          withSlot1:_slot4
                                          withSlot2:_slot5
                                  withDateFormatter:_dateFormater];
    
    DayDto *_day4 = [self dayDto4WithScheduleEvent1:_scheduleEvent3
                                 withScheduleEvent2:_scheduleEvent4
                                          withSlot1:_slot6
                                  withDateFormatter:_dateFormater];
    
    NSMutableArray *_dayArray = [[NSMutableArray alloc]init];
    [_dayArray addObject:_day1];
    [_dayArray addObject:_day2];
    [_dayArray addObject:_day3];
    [_dayArray addObject:_day4];
    
    ScheduleDto *_schedule1 = [[ScheduleDto alloc]initWithExampleDays:_dayArray :TimeTableTypeLecturerEnglish];
    
    int cnt = [_schedule1._days count];
    STAssertEquals(cnt, 4, @"schedule day count %i = %i",cnt, 4);
    
}



@end
