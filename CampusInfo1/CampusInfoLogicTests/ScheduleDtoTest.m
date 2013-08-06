//
//  ScheduleDtoTest.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 06.08.13.
//
//

#import "ScheduleDtoTest.h"

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

@implementation ScheduleDtoTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}


- (void) testWithExampleData
{
    ScheduleDto    *_exampleSchedule;
    DateFormation  *_dateFormatter = [[DateFormation alloc] init];
    DayDto         *_exampleDay1     = nil;
    DayDto         *_exampleDay2     = nil;
    NSMutableArray *_exampleDayArray = [[NSMutableArray alloc]init];
    
    NSDate         *_dayDate1        = [NSDate date];
    NSDate         *_dayDate2        = [_dayDate1 dateByAddingTimeInterval:(1*24*60*60)];
    
    NSMutableArray *_slotArrayDay1 = [[NSMutableArray alloc]init];
    NSMutableArray *_slotArrayDay2 = [[NSMutableArray alloc]init];
    
    NSMutableArray *_slotArray1a  = [[NSMutableArray alloc]init];
    NSMutableArray *_slotArray1b  = [[NSMutableArray alloc]init];
    NSMutableArray *_slotArray2a  = [[NSMutableArray alloc]init];
    NSMutableArray *_slotArray2b  = [[NSMutableArray alloc]init];
    
    NSMutableArray *_eventArray1 = [[NSMutableArray alloc]init];
    NSMutableArray *_eventArray2 = [[NSMutableArray alloc]init];
    
    ScheduleEventDto *_event1a   = nil;
    ScheduleEventDto *_event1b   = nil;
    ScheduleEventDto *_event2a   = nil;
    ScheduleEventDto *_event2b   = nil;
    
    NSString *_dayDateString1 = [[_dateFormatter _englishDayFormatter] stringFromDate:_dayDate1];
    NSString *_dayDateString2 = [[_dateFormatter _englishDayFormatter] stringFromDate:_dayDate2];
    
    
    NSDate *_eventStartTime1a = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:00", _dayDateString1]];
    NSDate *_eventEndTime1a   = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 09:35", _dayDateString1]];
    
    SlotDto          *_slot1a1   = [[SlotDto alloc]init
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:00", _dayDateString1]]
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:45", _dayDateString1]]
                                    ];
    SlotDto          *_slot1a2   = [[SlotDto alloc]init
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:50", _dayDateString1]]
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 09:35", _dayDateString1]]
                                    ];
    [_slotArray1a    addObject:_slot1a1 ];
    [_slotArray1a    addObject:_slot1a2 ];
    
    
    NSDate *_eventStartTime1b = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:00", _dayDateString1]];
    NSDate *_eventEndTime1b   = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 11:35", _dayDateString1]];
    
    SlotDto          *_slot1b1   = [[SlotDto alloc]init
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:00", _dayDateString1]]
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:45", _dayDateString1]]
                                    ];
    SlotDto          *_slot1b2   = [[SlotDto alloc]init
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:50", _dayDateString1]]
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 11:35", _dayDateString1]]
                                    ];
    [_slotArray1b    addObject:_slot1b1 ];
    [_slotArray1b    addObject:_slot1b2 ];
    
    [_slotArrayDay1  addObject:_slot1a1 ];
    [_slotArrayDay1  addObject:_slot1a2 ];
    [_slotArrayDay1  addObject:_slot1b1 ];
    [_slotArrayDay1  addObject:_slot1b2 ];
    
    
    
    SlotDto          *_slot2a    = [[SlotDto alloc]init
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:00", _dayDateString2]]
                                    :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:45", _dayDateString2]]
                                    ];
    [_slotArray2a    addObject:_slot2a ];
    
    SlotDto          *_slot2b   = [[SlotDto alloc]init
                                   :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:50", _dayDateString2]]
                                   :[[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 15:35", _dayDateString2]]
                                   ];
    [_slotArray2b    addObject:_slot2b ];
    
    [_slotArrayDay2  addObject:_slot2a ];
    [_slotArrayDay2  addObject:_slot2b ];
    
    
    NSDate *_eventStartTime2a = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:00", _dayDateString2]];
    NSDate *_eventEndTime2a   = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:45", _dayDateString2]];
    NSDate *_eventStartTime2b = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:50", _dayDateString2]];
    NSDate *_eventEndTime2b   = [[_dateFormatter _englishTimeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 15:35", _dayDateString2]];
    
    NSString *_eventDescription1a = @"Java Vorlesung";
    NSString *_eventDescription1b = @"Java Praktikum";
    
    NSString *_eventDescription2a = @"C++ Vorlesung";
    NSString *_eventDescription2b = @"C++ Praktikum";
    
    NSString *_eventName1a = @"t.xy";
    NSString *_eventName1b = @"t.yz";
    
    NSString *_eventName2a = @"t.aa";
    NSString *_eventName2b = @"t.vv";
    
    NSString *_eventType   = @"Course";
    
    RoomDto *_realizationRoom1a = [[RoomDto alloc]init:@"TE123"];
    RoomDto *_realizationRoom1b = [[RoomDto alloc]init:@"TB111"];
    RoomDto *_realizationRoom2a = [[RoomDto alloc]init:@"TH876"];
    RoomDto *_realizationRoom2b = [[RoomDto alloc]init:@"TE333"];
    
    PersonDto *_realizationPerson1a = [[PersonDto alloc]init:@"meha":@"Hans"    :@"Meier"  : @"Lecturer" :[[DepartmentDto alloc]init:@"T"]];
    PersonDto *_realizationPerson1b = [[PersonDto alloc]init:@"muer":@"Erika"   :@"Muster" : @"Lecturer" :[[DepartmentDto alloc]init:@"T"]];
    PersonDto *_realizationPerson2a = [[PersonDto alloc]init:@"muhe":@"Heinrich":@"Mueller": @"Lecturer" :[[DepartmentDto alloc]init:@"T"]];
    PersonDto *_realizationPerson2b = [[PersonDto alloc]init:@"hean":@"Andreas" :@"Heinz"  : @"Lecturer" :[[DepartmentDto alloc]init:@"T"]];
    
    SchoolClassDto *_realizationClass1a =  [[SchoolClassDto alloc]init:@"inf01"];
    SchoolClassDto *_realizationClass1b =  [[SchoolClassDto alloc]init:@"inf02"];
    SchoolClassDto *_realizationClass2a =  [[SchoolClassDto alloc]init:@"inf03"];
    SchoolClassDto *_realizationClass2b =  [[SchoolClassDto alloc]init:@"inf04"];
    
    NSMutableArray *_lecturerArray1 = [[NSMutableArray alloc]init];
    NSMutableArray *_lecturerArray2 = [[NSMutableArray alloc]init];
    NSMutableArray *_classArray1    = [[NSMutableArray alloc]init];
    NSMutableArray *_classArray2    = [[NSMutableArray alloc]init];
    
    [_lecturerArray1 addObject:_realizationPerson1a];
    [_lecturerArray1 addObject:_realizationPerson1b];
    [_lecturerArray2 addObject:_realizationPerson2a];
    [_lecturerArray2 addObject:_realizationPerson2b];
    [_classArray1    addObject:_realizationClass1a ];
    [_classArray1    addObject:_realizationClass1b ];
    [_classArray2    addObject:_realizationClass2a ];
    [_classArray2    addObject:_realizationClass2b ];
    
    
    ScheduleEventRealizationDto *_eventRealization1a = [[ScheduleEventRealizationDto alloc]init:nil :nil :nil ];
    _eventRealization1a = [_eventRealization1a init:_realizationRoom1a :_lecturerArray1 :_classArray1];
    
    ScheduleEventRealizationDto *_eventRealization1b = [[ScheduleEventRealizationDto alloc]init:nil :nil :nil ];
    _eventRealization1a = [_eventRealization1a init:_realizationRoom1b :_lecturerArray1 :_classArray1];
    
    ScheduleEventRealizationDto *_eventRealization2a = [[ScheduleEventRealizationDto alloc]init:nil :nil :nil ];    
    _eventRealization2a = [_eventRealization2a init:_realizationRoom2a :_lecturerArray2 :_classArray2];
    
    ScheduleEventRealizationDto *_eventRealization2b =  [[ScheduleEventRealizationDto alloc]init:nil :nil :nil ];
    _eventRealization2b =  [_eventRealization2b init:_realizationRoom2b :_lecturerArray2 :_classArray2 ];
    
    NSMutableArray *_realizationArray1a    = [[NSMutableArray alloc]init];
    NSMutableArray *_realizationArray1b    = [[NSMutableArray alloc]init];
    NSMutableArray *_realizationArray2a    = [[NSMutableArray alloc]init];
    NSMutableArray *_realizationArray2b    = [[NSMutableArray alloc]init];
    
    [_realizationArray1a    addObject:_eventRealization1a ];
    [_realizationArray1b    addObject:_eventRealization1b ];
    [_realizationArray2a    addObject:_eventRealization2a ];
    [_realizationArray2b    addObject:_eventRealization2b ];
    
    _event1a = [[ScheduleEventDto alloc]init:_eventDescription1a
                                            :_eventStartTime1a
                                            :_eventEndTime1a
                                            :_eventName1a
                                            :_slotArray1a
                                            :_eventType
                                            :_realizationArray1a];
    
    _event1b = [[ScheduleEventDto alloc]init:_eventDescription1b
                                            :_eventStartTime1b
                                            :_eventEndTime1b
                                            :_eventName1b
                                            :_slotArray1b
                                            :_eventType
                                            :_realizationArray1b];
    
    _event2a = [[ScheduleEventDto alloc]init:_eventDescription2a
                                            :_eventStartTime2a
                                            :_eventEndTime2a
                                            :_eventName2a
                                            :_slotArray2a
                                            :_eventType
                                            :_realizationArray2a];
    
    _event2b = [[ScheduleEventDto alloc]init:_eventDescription2b
                                            :_eventStartTime2b
                                            :_eventEndTime2b
                                            :_eventName2b
                                            :_slotArray2b
                                            :_eventType
                                            :_realizationArray2b];
    
    [_eventArray1    addObject:_event1a ];
    [_eventArray1    addObject:_event1b ];
    [_eventArray2    addObject:_event2a ];
    [_eventArray2    addObject:_event2b ];
    
    
    _exampleDay1 = [[DayDto alloc]init: _dayDate1 : _eventArray1: _slotArrayDay1 ];
    _exampleDay2 = [[DayDto alloc]init: _dayDate2 : _eventArray2: _slotArrayDay2 ];
    
    
    [_exampleDayArray addObject:_exampleDay1];
    [_exampleDayArray addObject:_exampleDay2];
    
    _exampleSchedule = [[ScheduleDto alloc]initWithExampleDays:_exampleDayArray :@"student"];
    
    int number1 = 2;
    int number2 = [_exampleSchedule._days count];
    
    STAssertEquals(number1, number2, @"Example day has %i (%i) days.",number1, number2);
    
}


@end
