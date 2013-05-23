//
//  ScheduleDto.m
//  CampusInfo1
//
//  Created by Ilka Kokemor on 3/31/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ScheduleDto.h"
#import "DayDto.h"
#import "PersonDto.h"
#import "SchoolClassDto.h"
#import "RoomDto.h"
#import "SlotDto.h"
#import "DayDto.h"
#import "DepartmentDto.h"
#import "TimeTableAsyncRequest.h"
#import "ScheduleEventDto.h"
#import "ScheduleEventRealizationDto.h"
#import "ScheduleCourseDto.h"

@implementation ScheduleDto

@synthesize _days;
@synthesize _type;
@synthesize _acronym;
@synthesize _scheduleDate;
@synthesize _connectionEstablished;

@synthesize _student;
@synthesize _lecturer;
@synthesize _room;
@synthesize _scheduleCourse;
@synthesize _schoolClass;

@synthesize _asyncTimeTableRequest;
@synthesize _dataFromUrl;

@synthesize _errorMessage;


- (NSDateFormatter *)dayFormatter {
    NSDateFormatter *_dayFormatter = [[NSDateFormatter alloc]init];
    [_dayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
    [_dayFormatter setDateFormat:@"yyyy-MM-dd"]; 
    return _dayFormatter;
} 

- (NSDateFormatter *)timeFormatter {
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
    [timeFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
	[timeFormatter setDateFormat:@"HH:mm"]; 
    return timeFormatter;
}

- (NSDateFormatter *)timeAndDayFormatter {
    NSDateFormatter *timeAndDayFormatter = [[NSDateFormatter alloc]init];
    [timeAndDayFormatter setTimeZone:[NSTimeZone timeZoneWithName:@"CEST"]];
	[timeAndDayFormatter setDateFormat:@"yyyy-MM-dd HH:mm"]; 
    return timeAndDayFormatter;
}

- (NSDate *) parseDate:(NSString *)dateString
{
    NSDate   *_localDate;
    NSString *_localString;
    
    _localString = [dateString substringToIndex:10];
    //NSLog(@"_localString: %@",_localString);
    _localDate   = [[self dayFormatter] dateFromString:_localString];
    //NSLog(@"_localDate: %@", [[self dayFormatter] stringFromDate:_localDate]);
    return _localDate;
}


- (DepartmentDto *)getDepartmentWithDictionary:(NSDictionary *)dictionary withPersonKey:(id)key{
    DepartmentDto *_localDepartment      = nil;
    NSString      *_name                 = nil;
    NSDictionary  *_departmentDictionary = [dictionary objectForKey:key];
    
    for (id departmentKey in _departmentDictionary) 
    {
        if ([departmentKey isEqualToString:@"name"]) 
        {
            _name = [_departmentDictionary objectForKey:departmentKey];
            //NSLog(@"department name: %@",_name);
        }
    } // end loop over keys     
    _localDepartment    = [[DepartmentDto alloc]init:_name]; 
    return _localDepartment;
}


- (RoomDto *) getRoomWithDictionary:(NSDictionary *)dictionary withScheduleKey:(id) key{
    RoomDto       *_localRoom      = nil;
    NSString      *_name           = nil;
    NSDictionary  *_roomDictionary = [dictionary objectForKey:key];
    
    if (_roomDictionary != (id)[NSNull null])
    {
    for (id roomKey in _roomDictionary) 
    {
        if ([roomKey isEqualToString:@"name"]) {
            _name = [_roomDictionary objectForKey:roomKey];
        }
    }    
    _localRoom    = [[RoomDto alloc]init:_name]; 
    }
    return _localRoom;
}


- (SchoolClassDto *) getClassWithDictionary:(NSDictionary *)scheduleDictionary withKey:(id) scheduleKey
{
    SchoolClassDto *_localClass      = nil;
    NSString       *_className       = nil;
    NSDictionary   *_classDictionary = nil;
    
    if (scheduleKey == nil)
    {
        _classDictionary = scheduleDictionary;
    }
    else 
    {
       _classDictionary = [scheduleDictionary objectForKey:scheduleKey];    
    }
    
    if (_classDictionary != (id)[NSNull null])
    {
    for (id classKey in _classDictionary) 
    {
        if ([classKey isEqualToString:@"name"]) {
            _className = [_classDictionary objectForKey:classKey];
        }
    }    
    _localClass = [[SchoolClassDto alloc]init:_className]; 
    }
    return _localClass;
}


- (ScheduleCourseDto *) getScheduleCourseWithDictionary:(NSDictionary *)dictionary withKey:(id) key
{
    ScheduleCourseDto *_localCourse       = nil;
    NSString          *_courseName        = nil;
    NSString          *_courseDescription = nil;
    NSDictionary      *_courseDictionary  = [dictionary objectForKey:key];
    
     if (_courseDictionary != (id)[NSNull null])  
     {
    for (id courseKey in _courseDictionary) 
    {
        if ([courseKey isEqualToString:@"name"]) 
        {
            _courseName        = [_courseDictionary objectForKey:courseKey];
        }
        if ([courseKey isEqualToString:@"description"]) 
        {
            _courseDescription = [_courseDictionary objectForKey:courseKey];
        }

    }   
    _localCourse    = [[ScheduleCourseDto alloc]init:_courseName:_courseDescription]; 
     }
    return _localCourse;
}



- (PersonDto *) getPersonWithDictionary:(NSDictionary *)dictionary withKey:(id) key
{
    PersonDto     *_localPerson      = nil;
    NSString      *_firstName        = nil;
    NSString      *_lastName         = nil;
    NSString      *_shortName        = nil;
    NSString      *_personType       = nil;
    DepartmentDto *_department       = nil;
    NSDictionary  *_personDictionary = nil;
    
    
    if (key == nil)
    {
        _personDictionary = dictionary;
    }
    else
    {
        _personDictionary = [dictionary objectForKey:key];
    }

    if (_personDictionary != (id)[NSNull null])  
    {
    for (id personKey in _personDictionary) {

        //NSLog(@"personKey: %@", personKey);
        if ([personKey isEqualToString:@"firstName"]) {
            _firstName = [_personDictionary objectForKey:personKey];
            //NSLog(@"_firstName: %@",_firstName);
        }
    
        if ([personKey isEqualToString:@"lastName"]) {
            _lastName = [_personDictionary objectForKey:personKey];
            //NSLog(@"_lastName: %@",_lastName);
        }
        if ([personKey isEqualToString:@"shortName"]) {
            _shortName = [_personDictionary objectForKey:personKey];
            //NSLog(@"_shortName: %@",_shortName);
        }
        
        if ([personKey isEqualToString:@"type"]) {
            _personType = [_personDictionary objectForKey:personKey];
            //NSLog(@"_shortName: %@",_personType);
        }

        if ([personKey isEqualToString:@"department"]) {
            if ([_personDictionary objectForKey:personKey] != (id)[NSNull null])  
            {
                _department = [self getDepartmentWithDictionary:_personDictionary withPersonKey:personKey];
                //NSLog(@"_department._name: %@",_department._name);
            }
        }
        
    } // end loop over keys     
    }
    _localPerson    = [[PersonDto alloc]init:_shortName:_firstName:_lastName: _personType :_department]; 
    return _localPerson;
}


- (ScheduleEventRealizationDto *) getEventRealization:(NSDictionary *)realizationDictionary
{
    ScheduleEventRealizationDto *_localRealization      = nil;
    RoomDto                     *_realizationRoom       = nil;
    NSMutableArray              *_lecturerArrayToStore  = [[NSMutableArray alloc]init];
    NSMutableArray              *_classesArrayToStore   = [[NSMutableArray alloc]init];
    
    for (id realizationKey in realizationDictionary) 
    {
        // get room of event realization
        if ([realizationKey isEqualToString:@"room"]) 
        {
            if ([realizationDictionary objectForKey:realizationKey] != (id)[NSNull null])  
            {
                _realizationRoom = [self getRoomWithDictionary:realizationDictionary withScheduleKey:realizationKey];
                //NSLog(@"_realizationRoom._name: %@",_realizationRoom._name);
            }
        }
        
        if ([realizationKey isEqualToString:@"lecturers"]) 
        {
            NSArray  *_lecturersArray = [realizationDictionary objectForKey:realizationKey];
            
            //NSLog(@"_lecturersArray count: %i",[_lecturersArray count]);
            
            int lecturerArrayI;
            for (lecturerArrayI = 0; lecturerArrayI < [_lecturersArray count]; lecturerArrayI++) 
            {   
                NSDictionary *_personDictionary = [_lecturersArray objectAtIndex:lecturerArrayI];
                
                PersonDto *_lectuerPerson = [self getPersonWithDictionary:_personDictionary withKey:nil];
                //NSLog(@"_lectuerPerson._shortName: %@",_lectuerPerson._shortName);
                
                [_lecturerArrayToStore addObject:_lectuerPerson];
            }
        }
        if ([realizationKey isEqualToString:@"classes"]) 
        {
            NSArray  *_classesArray = [realizationDictionary objectForKey:realizationKey];
            int classesArrayI;
            for (classesArrayI = 0; classesArrayI < [_classesArray count]; classesArrayI++) 
            {   
                NSDictionary *_classDictionary = [_classesArray objectAtIndex:classesArrayI];
                
                SchoolClassDto *_realizationClass = [self getClassWithDictionary:_classDictionary withKey:nil];
                
                //NSLog(@"_realizationClass._name: %@",_realizationClass._name);
                [_classesArrayToStore addObject:_realizationClass];
            }
        }
    }   
    _localRealization    = [[ScheduleEventRealizationDto alloc]init:_realizationRoom:_lecturerArrayToStore:_classesArrayToStore]; 
    return _localRealization;
}


- (SlotDto *) getSlot:(NSDictionary *)slotDictionary{
    
    SlotDto        *_localSlot;
    NSDate         *_slotStartTime;
    NSDate         *_slotEndTime;
    
    for (id slotKey in slotDictionary) 
    {
        if ([slotKey isEqualToString:@"startTime"]) 
        {
            
            // 2012-04-04T08:00:00+02:00
            //[str substringWithRange:NSMakeRange(3, [str length]-3)];
            
            NSString *_slotStartTimeString = [slotDictionary objectForKey:slotKey];
            _slotStartTimeString           = [_slotStartTimeString substringWithRange:NSMakeRange(11, 5)];
            _slotStartTime                 = [[self timeFormatter]  dateFromString:_slotStartTimeString];
            //NSLog(@"_slotStartTimeString: %@",_slotStartTime);
        }
        if ([slotKey isEqualToString:@"endTime"]) 
        {
            NSString *_slotEndTimeString = [slotDictionary objectForKey:slotKey];
            _slotEndTimeString           = [_slotEndTimeString substringWithRange:NSMakeRange(11, 5)];
            _slotEndTime                 = [[self timeFormatter]  dateFromString:_slotEndTimeString];
            //NSLog(@"_slotEndTimeString: %@",_slotEndTimeString);
        }
        
    } // end loop over slotDictionary

    _localSlot = [[SlotDto alloc]init: _slotStartTime :_slotEndTime];
    return _localSlot;
}



- (ScheduleEventDto *) getEvent:(NSDictionary *)eventDictionary
{

    ScheduleEventDto  *_localScheduleEvent;
    NSDate            *_eventStartTime;
    NSDate            *_eventEndTime;
    NSString          *_eventDescription;
    NSString          *_eventType;
    NSString          *_eventName;
    NSMutableArray    *_slotArrayToStore      = [[NSMutableArray alloc]init];
    NSMutableArray    *_eventRealizationArray = [[NSMutableArray alloc]init];
    
    for (id eventKey in eventDictionary) 
    {
         //NSLog(@"eventKey: %@",eventKey);
        
        // get start time of event
        if ([eventKey isEqualToString:@"startTime"]) 
        {
            // 2012-04-04T08:00:00+02:00
            //[str substringWithRange:NSMakeRange(3, [str length]-3)];
            NSString *_eventStartTimeString = [eventDictionary objectForKey:eventKey];
            _eventStartTimeString           = [_eventStartTimeString substringWithRange:NSMakeRange(11, 5)];
            _eventStartTime                 = [[self timeFormatter]  dateFromString:_eventStartTimeString];
            //NSLog(@"_eventStartTime: %@",_eventStartTimeString);
        }
        
        // get end time of event
        if ([eventKey isEqualToString:@"endTime"]) 
        {
            NSString *_eventEndTimeString = [eventDictionary objectForKey:eventKey];
            _eventEndTimeString           = [_eventEndTimeString substringWithRange:NSMakeRange(11, 5)];
            _eventEndTime                 = [[self timeFormatter]  dateFromString:_eventEndTimeString];
            //NSLog(@"_eventEndTime: %@",_eventEndTimeString);
        }
        
        // get description of event
        if ([eventKey isEqualToString:@"description"]) 
        {
          _eventDescription = [eventDictionary objectForKey:eventKey];
        //NSLog(@"_eventDescription: %@",_eventDescription);
        }
        
        // get name of event
        if ([eventKey isEqualToString:@"name"]) 
        {
            _eventName = [eventDictionary objectForKey:eventKey];
             //NSLog(@"_eventName: %@",_eventName);
        }

        
        // get type of event
        if ([eventKey isEqualToString:@"type"]) 
        {
            _eventType = [eventDictionary objectForKey:eventKey];
             //NSLog(@"_eventType: %@",_eventType);
        }
        
        // get eventRealization 
        if ([eventKey isEqualToString:@"eventRealizations"]) 
        {
            NSArray *_eventArray = [eventDictionary objectForKey:eventKey];
            
            if ((NSNull *)_eventArray != [NSNull null])
            {
                //NSLog(@"_eventArray count: %i",[_eventArray count]);
            
                // loop over slots
                int  eventArrayI;
                for (eventArrayI = 0; eventArrayI < [_eventArray count]; eventArrayI++)
                {
                    ScheduleEventRealizationDto *_realization =
                    [self getEventRealization:[_eventArray objectAtIndex:eventArrayI]];
                    //NSLog(@"_realization._room._name: %@",_realization._room._name);
                
                    [_eventRealizationArray addObject:_realization];
                }
            }
            
        }
        // get time slots 
        if ([eventKey isEqualToString:@"slots"]) 
        {
            NSArray  *_slotArray = [eventDictionary objectForKey:eventKey];
            
            //NSLog(@"_slotArray count: %i",[_slotArray count]);
            
            // loop over slots
            int slotArrayI;
            for (slotArrayI = 0; slotArrayI < [_slotArray count]; slotArrayI++) 
            {
                SlotDto *_localSlot = 
                [self getSlot:[_slotArray objectAtIndex:slotArrayI]];
                [_slotArrayToStore addObject:_localSlot];
            }
        }
    
    } 
    
    _localScheduleEvent = [[ScheduleEventDto alloc]init:_eventDescription
                                                       :_eventStartTime 
                                                       :_eventEndTime
                                                       :_eventName
                                                       :_slotArrayToStore
                                                       :_eventType
                                                       :_eventRealizationArray];
    //NSLog(@"_localScheduleEvent._name: %@", _localScheduleEvent._name);
    return _localScheduleEvent;
}


- (DayDto *) getDay:(NSDictionary *)dayDictionary
{
    NSDate         *_dayDate;
    NSMutableArray *_slotArrayToStore  = [[NSMutableArray alloc]init];
    NSMutableArray *_eventArrayToStore = [[NSMutableArray alloc]init];

    //NSLog(@"start parsing day");
    for (id daykey in dayDictionary) 
    {
        //NSLog(@"daykey: %@", daykey);
        
        if ([daykey isEqualToString:@"date"]) 
        {
            _dayDate = [self parseDate:[dayDictionary objectForKey:daykey]];
            //NSLog(@"dayDate: %@", [[self dayFormatter] stringFromDate:_dayDate]);
        }

        // get event information
        if ([daykey isEqualToString:@"events"]) 
        {
            NSArray  *_eventArray = [dayDictionary objectForKey:daykey];
            
            //NSLog(@"events to parse count: %i",[_eventArray count]);
            
            // loop over slots
            int eventArrayI;
            for (eventArrayI = 0; eventArrayI < [_eventArray count]; eventArrayI++) 
            {
                ScheduleEventDto *_localEvent = [self getEvent:[_eventArray objectAtIndex:eventArrayI]];
                //NSLog(@"%i localEvent: %@", eventArrayI,  _localEvent._name);
                [_eventArrayToStore addObject:_localEvent];
            }
            
            //NSLog(@"event array count: %i",[_eventArrayToStore count]);
        }
        
        // get slot information
        if ([daykey isEqualToString:@"slots"]) {
            
            NSArray  *_slotArray = [dayDictionary objectForKey:daykey];
            
            // loop over slots
            int slotArrayI;
            for (slotArrayI = 0; slotArrayI < [_slotArray count]; slotArrayI++) 
            {
                SlotDto *_localSlot = [self getSlot:[_slotArray objectAtIndex:slotArrayI]];
                [_slotArrayToStore addObject:_localSlot];
            }
            
            //NSLog(@"slot array count: %i",[_slotArrayToStore count]);
        }
    } 
    //NSLog(@"end parsing day");

    return [[DayDto alloc]init: _dayDate : _eventArrayToStore: _slotArrayToStore ];
}



- (NSMutableArray *) getDaysWithDictionary:(NSDictionary *)dictionary withKey:(id)key
{
    NSMutableArray *_dayArrayToStore = [[NSMutableArray alloc]init];
    NSArray        *_dayArray        = [dictionary objectForKey:key];
    
    //NSLog(@"day array count: %i",[_dayArray count]);
    
    int i;
    for (i = 0; i < [_dayArray count]; i++) 
    {
        DayDto *_localDay = [self getDay:[_dayArray objectAtIndex:i]];
        
        //int eventArrayI;
        //for (eventArrayI = 0; eventArrayI < [_localDay._events count]; eventArrayI++) 
        //{
        //    ScheduleEventDto *_localEvent = [_localDay._events objectAtIndex:eventArrayI];
        //    NSString *_toEvent            = [[self timeFormatter] stringFromDate: _localEvent._endTime];
        //    NSString *_fromEvent          = [[self timeFormatter] stringFromDate: _localEvent._startTime];
            
        //    NSLog(@"getDays => %i event in table cell: %@ from %@ to %@"
        //          ,eventArrayI
        //          ,_localEvent._name
        //          ,_fromEvent
        //          ,_toEvent
        //          );
        //}
        //NSLog(@"getDays => for day %@", [[self dayFormatter] stringFromDate:_localDay._date]);
        
        [_dayArrayToStore addObject:_localDay];
    } 
    
    //NSLog(@"day array to store count: %i",[_dayArrayToStore count]);

    return _dayArrayToStore;
}



/* TODO: do we need that?
- (NSDate *) getDateWithDictionary:(NSDictionary *)dictionary withKey:(id)key
{  
    NSString *_subType = [dictionary objectForKey:key];
    NSDate   *_startDateToStore = [self parseDate:_subType];
    return _startDateToStore;
}
 */





//-------------------------------
// asynchronous request 
//-------------------------------

-(void) dataDownloadDidFinish:(NSData*) data {
    
    _dataFromUrl = data;
    
   // NSLog(@"dataDownloadDidFinish %@",[NSThread callStackSymbols]);
    
    //NSString *someString = [NSString stringWithFormat:@"%@", _dataFromUrl]; 
    //someString = [someString substringToIndex:100];
    //NSLog(@"dataDownloadDidFinish %@", someString);
    //NSLog(@"1");
    
}


// triggered by schedule.init
-(void) downloadData
{
    NSURL *_url; 

    if ([_acronym length] == 0 ||
        [_type    length] == 0 )
    {
        _url = [NSURL URLWithString:
                   @"https://srv-lab-t-874.zhaw.ch/v1/schedules/students/schutda0?startingAt=2012-05-14&days=7"];
    }
    else
    {
        
        //NSLog(@"DOWNLOAD DATA ELSE ---type: %@-----acronym: %@ -----",_type, _acronym ); 

        NSString *_scheduleDateString = [[self dayFormatter] stringFromDate:_scheduleDate];
        NSString *_translatedAcronym  = _acronym;
        
        if ([self._type isEqualToString:@"rooms"])
        {
            _translatedAcronym = [_translatedAcronym lowercaseString];
            //NSLog(@"_translatedAcronym: %@", _translatedAcronym);
        } 
        
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"%" withString:@"%25"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"(" withString:@"%28"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@")" withString:@"%29"];

        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"*" withString:@"%2A"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"+" withString:@"%2B"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"," withString:@"%2C"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"-" withString:@"%2D"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"." withString:@"%2E"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"/" withString:@"%2F"];
        
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@":" withString:@"%3A"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@";" withString:@"%3B"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"<" withString:@"%3C"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"=" withString:@"%3D"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@">" withString:@"%3E"];
        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"?" withString:@"%3F"];

        _translatedAcronym = [_translatedAcronym stringByReplacingOccurrencesOfString:@"\\" withString:@"%5C"];
        
        NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/schedules/%@/%@?startingAt=%@&days=7"
                                , _type
                                , _translatedAcronym
                                , _scheduleDateString];
        
        NSLog(@"_urlString %@",_urlString ); 
        
        //_translatedAcronym = @"TE%20319";
        // NSString *_urlString = [NSString stringWithFormat:@"https://srv-lab-t-874.zhaw.ch/v1/schedules/rooms/%@?startingAt=%@&days=7"
         //                       ,_translatedAcronym
         //                       , _scheduleDateString];
        
        _url       = [NSURL URLWithString:_urlString];

    }

    [_asyncTimeTableRequest downloadData:_url];

}



-(void)threadDone:(NSNotification*)arg
{   
    //NSLog(@"Thread exiting");
}





- (NSDictionary *) getDictionaryFromUrl
{

    _asyncTimeTableRequest = [[TimeTableAsyncRequest alloc] init];
    _asyncTimeTableRequest._timeTableAsynchRequestDelegate = self; 
    [self performSelectorInBackground:@selector(downloadData) withObject:nil];

    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(threadDone:)
                                                 name:NSThreadWillExitNotification
                                               object:nil];
    
    NSError      *_error = nil;
    NSDictionary *_scheduleDictionary;
    //NSLog(@"2");
    
     //   NSLog(@"getDictionaryFromUrl %@",[NSThread callStackSymbols]);
    
    //NSString *someString = [NSString stringWithFormat:@"%@", _dataFromUrl]; 
    //NSLog(@"getDictionaryFromUrl data from url %@", someString);
    
    //NSString *someString = [[NSString alloc] initWithData:_dataFromUrl encoding:NSUTF8StringEncoding];
    //NSLog(@"getDictionaryFromUrl %@", someString);
    
    if (_dataFromUrl == nil) 
    {
        
        
        //NSLog(@"getDictionaryFromUrl NO DATA HERE");
        
        
        //NSMutableData *responseData = [[NSMutableData data] retain];
        //NSURLRequest  *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"http://192.168.1.102:49619/v1/schedules/musteeri"]];
        //NSURLResponse *response = nil;
        //NSError *error = nil;
        //getting the data
        //NSData *newData = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        //json parse
        //NSString *responseString = [[NSString alloc] initWithData:newData encoding:NSUTF8StringEncoding];
        //responseString = [responseString substringToIndex:10];
        //NSLog(@"did something :  %@", responseString);

        
    
        return nil;
    }    
    else
    {
        //NSLog(@"getDictionaryFromUrl got some data putting it now into dictionary");
        //NSString *someString = [[NSString alloc] initWithData:_dataFromUrl encoding:NSUTF8StringEncoding];
        //NSLog(@"getDictionaryFromUrl %@", someString);
        _scheduleDictionary = [NSJSONSerialization 
                               JSONObjectWithData:_dataFromUrl 
                               options:kNilOptions 
                               error:&_error];
    
    }
    return _scheduleDictionary;
}




- (NSString *) getScheduleType:(NSString*)insertType
{
    NSString *_scheduleType = nil; 
    
    if ([insertType isEqualToString: @"Student"]) 
    {
        _scheduleType   = @"student";
    }                     
    
    if ([insertType isEqualToString: @"Lecturer"]) 
    {
        _scheduleType   = @"lecturer";
    }                     
    
    if ([insertType isEqualToString: @"Course"]) 
    {
        _scheduleType   = @"course";
    }                     
    
    if ([insertType isEqualToString: @"Class"]) 
    {
        _scheduleType   = @"class";
    }                     
    
    if ([insertType isEqualToString: @"Room"]) 
    {
        _scheduleType   = @"room";                        
    }        
    //NSLog(@"schedule type %@", _scheduleType);

    return _scheduleType;
}


- (id) setExampleData 
{
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

    NSString *_dayDateString1 = [[self dayFormatter] stringFromDate:_dayDate1];
    NSString *_dayDateString2 = [[self dayFormatter] stringFromDate:_dayDate2];
    
    
    NSDate *_eventStartTime1a = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:00", _dayDateString1]];
    NSDate *_eventEndTime1a   = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 09:35", _dayDateString1]];
    
    SlotDto          *_slot1a1   = [[SlotDto alloc]init
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:00", _dayDateString1]]
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:45", _dayDateString1]]
                                    ];
    SlotDto          *_slot1a2   = [[SlotDto alloc]init
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 08:50", _dayDateString1]]
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 09:35", _dayDateString1]]
                                    ];
    [_slotArray1a    addObject:_slot1a1 ];
    [_slotArray1a    addObject:_slot1a2 ];

    
    NSDate *_eventStartTime1b = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:00", _dayDateString1]];
    NSDate *_eventEndTime1b   = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 11:35", _dayDateString1]];
    
    SlotDto          *_slot1b1   = [[SlotDto alloc]init
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:00", _dayDateString1]]
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:45", _dayDateString1]]
                                    ];
    SlotDto          *_slot1b2   = [[SlotDto alloc]init
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 10:50", _dayDateString1]]
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 11:35", _dayDateString1]]
                                    ];
    [_slotArray1b    addObject:_slot1b1 ];
    [_slotArray1b    addObject:_slot1b2 ];

    [_slotArrayDay1  addObject:_slot1a1 ];
    [_slotArrayDay1  addObject:_slot1a2 ];
    [_slotArrayDay1  addObject:_slot1b1 ];
    [_slotArrayDay1  addObject:_slot1b2 ];

    
    
    SlotDto          *_slot2a    = [[SlotDto alloc]init
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:00", _dayDateString2]]
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:45", _dayDateString2]]
                                    ];
    [_slotArray2a    addObject:_slot2a ];

    SlotDto          *_slot2b   = [[SlotDto alloc]init
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:50", _dayDateString2]]
                                    :[[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 15:35", _dayDateString2]]
                                    ];
    [_slotArray2b    addObject:_slot2b ];

    [_slotArrayDay2  addObject:_slot2a ];
    [_slotArrayDay2  addObject:_slot2b ];

    
    NSDate *_eventStartTime2a = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:00", _dayDateString2]];
    NSDate *_eventEndTime2a   = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:45", _dayDateString2]];
    NSDate *_eventStartTime2b = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 14:50", _dayDateString2]];
    NSDate *_eventEndTime2b   = [[self timeAndDayFormatter]  dateFromString:[NSString stringWithFormat:@"%@ 15:35", _dayDateString2]];
    
    NSString *_eventDescription1a = @"Java Vorlesung";
    NSString *_eventDescription1b = @"Java Praktikum";

    NSString *_eventDescription2a = @"C++ Vorlesung";
    NSString *_eventDescription2b = @"C++ Praktikum";

    NSString *_eventName1a = @"t.xy";    
    NSString *_eventName1b = @"t.yz";    

    NSString *_eventName2a = @"t.aa";    
    NSString *_eventName2b = @"t.vv";   
    
    NSString *_eventType   = @"Course";

    
    ScheduleEventRealizationDto *_realization1a = nil;
    ScheduleEventRealizationDto *_realization1b = nil;
    ScheduleEventRealizationDto *_realization2a = nil;
    ScheduleEventRealizationDto *_realization2b = nil;
    
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

    _realization1a = [[ScheduleEventRealizationDto alloc]init:_realizationRoom1a:_lecturerArray1:_classArray1]; 
    _realization1b = [[ScheduleEventRealizationDto alloc]init:_realizationRoom1b:_lecturerArray1:_classArray1]; 
    _realization2a = [[ScheduleEventRealizationDto alloc]init:_realizationRoom2a:_lecturerArray2:_classArray2]; 
    _realization2b = [[ScheduleEventRealizationDto alloc]init:_realizationRoom2b:_lecturerArray2:_classArray2]; 
    
    NSMutableArray *_realizationArray1a    = [[NSMutableArray alloc]init];
    NSMutableArray *_realizationArray1b    = [[NSMutableArray alloc]init];
    NSMutableArray *_realizationArray2a    = [[NSMutableArray alloc]init];
    NSMutableArray *_realizationArray2b    = [[NSMutableArray alloc]init];

    [_realizationArray1a    addObject:_realization1a ];
    [_realizationArray1b    addObject:_realization1b ];
    [_realizationArray2a    addObject:_realization2a ];
    [_realizationArray2b    addObject:_realization2b ];

    
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
    
    self._days     = _exampleDayArray;
    return self;
}



-(void)setTypeDetailsWithDictionary:(NSDictionary *)dictionary withKey:(id)key
{
    // get student information
    if ([key isEqualToString:@"student"]) 
    {
        self._student = [self getPersonWithDictionary:dictionary withKey:key];
    } 
    
    // get lecturer information
    if ([key isEqualToString:@"lecturer"]) 
    {
        self._lecturer = [self getPersonWithDictionary:dictionary withKey:key];
    }  
    
    // get course information            
    if ([key isEqualToString:@"course"]) 
    {
        self._scheduleCourse = [self getScheduleCourseWithDictionary:dictionary withKey:key];
    }  
    
    // get class information
    if ([key isEqualToString:@"class"]) 
    {
        self._schoolClass  = [self getClassWithDictionary:dictionary withKey:key];
    }  
    
    // get room information
    if ([key isEqualToString:@"room"]) 
    {
        self._room = [self getRoomWithDictionary:dictionary withScheduleKey:key];
    }           

}


-(id) initWithAcronym
    :(NSString *)newAcronymString
    :(NSString *)newAcronymType
    :(NSDate   *)newScheduleDate
{
    self = [super init];

    NSLog(@"_acronymString %@ _acronymType %@", newAcronymString, newAcronymType);
    
    if (self) 
    {           
        [self loadScheduleWithAcronym:newAcronymString:newAcronymType:newScheduleDate];
    }
    
    //NSLog(@"stacktrace initWithURL %@",[NSThread callStackSymbols]);
    //NSLog(@"finished loading data from acronym");
    return self;
}


-(void) loadScheduleWithAcronym
    :(NSString *)newAcronymString
    :(NSString *)newAcronymType
    :(NSDate   *)newScheduleDate
{
    //self = [self setExampleData];
    //self._acronym       = newAcronymString;
    //self._type          = newAcronymType;
    //self._scheduleDate  = newScheduleDate;    
    
    
    NSDictionary *_scheduleDictionary = nil;
    
    //if (   self._acronym == nil 
    //    || !([self._acronym isEqualToString:newAcronymString])  
    //    || self._days == nil
    //   )
    //{
        NSLog(@"loadScheduleWithAcronym old acronym: %@ - new acronym: %@", self._acronym , newAcronymString);
        
        self._acronym       = newAcronymString;
        self._type          = newAcronymType;
        self._scheduleDate  = newScheduleDate;
    
        _scheduleDictionary = [self getDictionaryFromUrl];
    
        if (_scheduleDictionary == nil)
        {
            NSLog(@"no connection");
            self._connectionEstablished      = @"NO";
        }
        else 
        {
            //NSLog(@"IF connection established");
            self._connectionEstablished      = @"YES";
            
            for (id scheduleKey in _scheduleDictionary) 
            {
                //NSLog(@"scheduleKey:%@",scheduleKey);
                
                if ([scheduleKey isEqualToString:@"Message"])
                {
                    NSString *_message = [_scheduleDictionary objectForKey:scheduleKey];
                    self._errorMessage = _message;
                    NSLog(@"Message: %@",_message);
                }
                else
                {
                  self._errorMessage = nil;
                  // define type of schedule
                  if ([scheduleKey isEqualToString:@"type"])
                  {
                      self._type = [self getScheduleType:[_scheduleDictionary objectForKey:scheduleKey]];
                  }
                  if ([scheduleKey isEqualToString:@"days"])
                  {
                      self._days = [self getDaysWithDictionary:_scheduleDictionary withKey:scheduleKey];
                    
                    //int dayArrayI;
                    //for (dayArrayI = 0; dayArrayI < [_days count]; dayArrayI++)
                    //{
                    //    DayDto   *_oneDay        = [_days objectAtIndex:dayArrayI];
                    //    NSString *_oneDateString = [[self dayFormatter] stringFromDate:_oneDay._date];
                    //    NSLog(@"initWithAcronym _oneDateString => %@", _oneDateString);
                    //    int eventArrayI;
                    //    for (eventArrayI = 0; eventArrayI < [_oneDay._events count]; eventArrayI++)
                    //    {
                    //        ScheduleEventDto *_localEvent = [_oneDay._events objectAtIndex:eventArrayI];
                    //        NSLog(@"initWithAcronym => %i event in table cell: %@ (%@)", eventArrayI,  _localEvent._name, _localEvent._type);
                     //   }
                    //}
                  }
                  [self setTypeDetailsWithDictionary:_scheduleDictionary withKey:scheduleKey];
                }
            }
        }
    //}
    /*
    else 
    {
        self._type          = newAcronymType;
        self._scheduleDate  = newScheduleDate;
        _scheduleDictionary = [self getDictionaryFromUrl];
    
        if (_scheduleDictionary == nil) 
        {
            NSLog(@"no connection");
            self._connectionEstablished      = @"NO";
        }
        else 
        {
            NSLog(@"ELSE connection established");
            self._connectionEstablished      = @"YES";
            NSString *_alreadyInArray        = @"NO";
            NSString *_oldDayString;
            NSString *_localDayString;
            DayDto   *_localDay;
            
            for (id scheduleKey in _scheduleDictionary) 
            {            
                // get days
                if ([scheduleKey isEqualToString:@"days"]) 
                {
                    NSMutableArray *_newDayArray = [[NSMutableArray alloc]init];
                    _newDayArray                 = [self getDays:_scheduleDictionary:scheduleKey];
                    
                    NSLog(@"new days count %i", [_newDayArray count]);
                    
                    int newDayArrayI;
                    int oldDayArrayI;
                    for (newDayArrayI = 0; newDayArrayI < [_newDayArray count]; newDayArrayI++) 
                    {
                        _localDay       = [_newDayArray objectAtIndex:newDayArrayI];
                        _alreadyInArray = @"NO";
                        _localDayString = [[self dayFormatter] stringFromDate:_localDay._date];
                        
                        // only add new day, if it is not already in array
                        for (oldDayArrayI = 0; oldDayArrayI < [self._days count]; oldDayArrayI++) 
                        {
                            _oldDayString = [[self dayFormatter] stringFromDate:_localDay._date];
                            if ([_localDayString isEqualToString:_oldDayString]) 
                            {
                                _alreadyInArray = @"YES";
                            }
                        }
                        
                        if ([_alreadyInArray isEqualToString:@"NO"]) 
                        {
                            [self._days addObject:_localDay];
                        }
                    }
                
                    //_localDateString = [[self dayFormatter] stringFromDate:_localDay._date];
                    
                    int dayArrayI;
                    for (dayArrayI = 0; dayArrayI < [_days count]; dayArrayI++) 
                    {
                        DayDto   *_oneDay        = [_days objectAtIndex:dayArrayI];
                        NSString *_oneDateString = [[self dayFormatter] stringFromDate:_oneDay._date];
                        NSLog(@"loadScheduleWithAcronym _oneDateString => %@", _oneDateString);
                        int eventArrayI;
                        for (eventArrayI = 0; eventArrayI < [_oneDay._events count]; eventArrayI++) 
                        {
                            ScheduleEventDto *_localEvent = [_oneDay._events objectAtIndex:eventArrayI];
                            NSLog(@"loadScheduleWithAcronym => %i event in table cell: %@", eventArrayI,  _localEvent._name);
                        }
                    }
                } 
            }
        } 
    }
    */
     
}


@end
