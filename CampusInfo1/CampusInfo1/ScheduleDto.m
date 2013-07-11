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
@synthesize _dateFormatter;



- (NSMutableArray *) getDaysWithDictionary:(NSDictionary *)dictionary withKey:(id)key
{
    NSMutableArray *_dayArrayToStore = [[NSMutableArray alloc]init];
    NSArray        *_dayArray        = [dictionary objectForKey:key];
    
    //NSLog(@"day array count: %i",[_dayArray count]);
    
    int i;
    DayDto *_localDay = [[DayDto alloc] init:nil :nil :nil];
    
    for (i = 0; i < [_dayArray count]; i++) 
    {
        _localDay = [_localDay getDay:[_dayArray objectAtIndex:i]];
        
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
        //NSLog(@"getDays => for day %@", [[_dateFormatter _englishDayFormatter] stringFromDate:_localDay._date]);
        
        [_dayArrayToStore addObject:_localDay];
    } 
    
    //NSLog(@"day array to store count: %i",[_dayArrayToStore count]);

    return _dayArrayToStore;
}




//-------------------------------
// asynchronous request 
//-------------------------------

-(void) dataDownloadDidFinish:(NSData*) data {
    
    //NSLog(@"ScheduleDto dataDownloadDidFinish");
    
    self._dataFromUrl = data;
    
    //if (self._dataFromUrl != nil)
    //{
    //    NSString *_receivedString = [[NSString alloc] initWithData:self._dataFromUrl encoding:NSASCIIStringEncoding];
    //    _receivedString = [_receivedString substringToIndex:3000];
    //    NSLog(@"dataDownloadDidFinish %@", _receivedString);
    //}
    
   // NSLog(@"dataDownloadDidFinish %@",[NSThread callStackSymbols]);    
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

        NSString *_scheduleDateString = [[_dateFormatter _englishDayFormatter] stringFromDate:_scheduleDate];
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
        self._student = [[PersonDto alloc] init:nil :nil :nil :nil :nil];
        self._student = [self._student getPersonWithDictionary:dictionary withKey:key];
    } 
    
    // get lecturer information
    if ([key isEqualToString:@"lecturer"])
    {
        self._lecturer = [[PersonDto alloc] init:nil :nil :nil :nil :nil];
        self._lecturer = [self._lecturer getPersonWithDictionary:dictionary withKey:key];
    }  
    
    // get course information            
    if ([key isEqualToString:@"course"]) 
    {
        self._scheduleCourse = [[ScheduleCourseDto alloc] init:nil :nil];
        self._scheduleCourse = [_scheduleCourse getScheduleCourseWithDictionary:dictionary withKey:key];
    }  
    
    // get class information
    if ([key isEqualToString:@"class"]) 
    {
        self._schoolClass  = [[SchoolClassDto alloc] init:nil];
        self._schoolClass  = [self._schoolClass getClassWithDictionary:dictionary withKey:key];
    }  
    
    // get room information
    if ([key isEqualToString:@"room"]) 
    {
        self._room = [[RoomDto alloc] init:nil];
        self._room = [self._room getRoomWithDictionary:dictionary withScheduleKey:key];
    }           
}


-(id) initWithAcronym
    :(NSString *)newAcronymString
    :(NSString *)newAcronymType
    :(NSDate   *)newScheduleDate
{
    self = [super init];

    _dateFormatter  = [[DateFormation alloc] init];
    
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
                    //    NSString *_oneDateString = [[_dateFormatter _englishDayFormatter] stringFromDate:_oneDay._date];
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
                        _localDayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_localDay._date];
                        
                        // only add new day, if it is not already in array
                        for (oldDayArrayI = 0; oldDayArrayI < [self._days count]; oldDayArrayI++) 
                        {
                            _oldDayString = [[_dateFormatter _englishDayFormatter] stringFromDate:_localDay._date];
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
                
                    //_localDateString = [[_dateFormatter _englishDayFormatter] stringFromDate:_localDay._date];
                    
                    int dayArrayI;
                    for (dayArrayI = 0; dayArrayI < [_days count]; dayArrayI++) 
                    {
                        DayDto   *_oneDay        = [_days objectAtIndex:dayArrayI];
                        NSString *_oneDateString = [[_dateFormatter _englishDayFormatter]stringFromDate:_oneDay._date];
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
